/* dgrep.c */
/*----------------------------------------------------------------------+
|	INCLUDE								|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<errno.h>
#include	"cbuni.h"

#ifdef		WIN32
#include	<io.h>
#include	<fcntl.h>
#else
#include	<dirent.h>
#include	<signal.h>
#endif

/*----------------------------------------------------------------------+
|	External	Variables					|
+----------------------------------------------------------------------*/
char	srchstr[80] = "";
char	homedir[128] = "";
char	srchext[32][128] = { "" };
#ifdef	WIN32
char	lower_srchext[32][128] = { "" };
#endif
int	stdoutfl = 1;
char	buffer[64*1024];

/*----------------------------------------------------------------------+
|	Functions							|
+----------------------------------------------------------------------*/
#ifdef	WIN32
#define _START_ 	1
#define _END_		0
char *
errmsg( opt )
int	opt;		/* 1=getmsg, 0=end(free) */
{
static	char	*lpMsgBuf = (char *)0;

	if( opt )
	{
		FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER |
			FORMAT_MESSAGE_FROM_SYSTEM, (LPCVOID)0, GetLastError(),
			/* Default language */
			MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
			/* Display the string. */
			(LPTSTR) &lpMsgBuf,
			0, (va_list *)0 );
		return( lpMsgBuf );
	}
	else
	{
		if( lpMsgBuf != (char *)0 )
			LocalFree( lpMsgBuf );
		return( (char *)0 );
	}
}
#endif

/*----------------------------------------------------------------------+
| get base cmd name without directory path, extensions(exe,com)		|
| argv0 : UNIX?, NT=cmd as input,95?,DOS=full filepath with .exe/.com	|
+----------------------------------------------------------------------*/
char	*
#if	defined( __CB_STDC__ )
getcmdname( char *argv0 )
#else
getcmdname( argv0 )
char	*argv0;
#endif
{
	register	i;
#ifdef	WIN32
	register	j;
static	char		cmdname[80];
#endif

	for( i=strlen(argv0)-1; i>=0; i-- )
	{
#ifdef	WIN32
		if( argv0[i] == '\\' || argv0[i] == ':' ) break;
#else
		if( argv0[i] == '/' ) break;
#endif
	}

#ifdef	WIN32
	/* assume exe or com is followed by '.' only once. */
	for( j=i+1; j<(int)strlen( argv0 ); j++ )
	{
		if( argv0[j] == '.' )
		{
			memcpy( cmdname, &argv0[i+1], j-i-1 );
			cmdname[ j-i-1 ] = '\0';
			return( cmdname );
		}
	}
#endif

	return( (char *)( argv0 + i + 1 ) );
}

/*---------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
prt_usage( char *argv0 )
#else
prt_usage( argv0 )
char	*argv0;
#endif
{
	char		cmdname[80];

	strcpy( cmdname, getcmdname( argv0 ) );

	printf( "\n" );
	printf( "\tUSAGE : %s [-search_file_extention] ", cmdname );
	printf( "search_string [directory]\n" );
	printf( "\n" );
	printf( "\t   -c : search file name is *.c\n" );
	printf( "\t   -h : search file name is *.h\n" );
	printf( "\t-c -h : search file name is *.c or *.h\n" );
	printf( "\n" );

	exit( 1 );

} /* prt_usage */

/*---------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
check_args( int argc, char *argv[] )
#else
check_args( argc, argv )
int	argc;
char	*argv[];
#endif
{
	register	i;
	int		extcnt = 0;
	char		*argv0;
#ifdef	WIN32
	int		k;
#endif

	argv0 = argv[0];

	if( argc < 2 )
		prt_usage( argv0 );

	while( argc > 1 )
	{
		if( argv[1][0] == '-' )
		{
			if( argv[1][1] != (char)0 )
			{
				for( i=0; i<extcnt; i++ )
					if( !strcmp( srchext[i], &argv[1][1] ) )
						break;

				if( i == extcnt && extcnt >= 32 )
				{
					printf( "\n" );
					printf( "Too many " );
					printf( "search_file_extention. " );
					printf( "MAX is 32.\n" );
					prt_usage( argv0 );
				}
				else if( i == extcnt )
				{
#ifdef	WIN32
					for(k=1;k<(int)strlen(argv[1]); k++ )
					{
						if( isalpha( argv[1][k] ) &&
						    isupper( argv[1][k] ) )
						{
						lower_srchext[extcnt][k-1] =
							tolower(argv[1][k]);
						}
						else
						{
						lower_srchext[extcnt][k-1] =
								argv[1][k];
						}
					}
					lower_srchext[extcnt][k-1] = '\0';
#endif
					strcpy( srchext[extcnt++],&argv[1][1] );
				}
			}
		}
		else
		{
			if( srchstr[0] == (char)0 )
				strcpy( srchstr, argv[1] );
			else if( homedir[0] == (char)0 )
				strcpy( homedir, argv[1] );
		}

		argc--;
		argv++;
	}

	if( srchstr[0] == (char)0 )
		prt_usage( argv0 );
	if( homedir[0] == (char)0 )
		strcpy( homedir, "." );

	for( i=strlen(srchstr)-1; i>=0 && srchstr[i]!=' '; i-- );
	if( i >= 0 )
	{
		memmove( &srchstr[1], srchstr, strlen( srchstr ) );
		srchstr[0] = '"';
		srchstr[strlen(srchstr)] = '"';
	}

	return;

} /* check_args */

/*---------------------------------------------------------------------*/
void
check_output( void )
{
	if( ! isatty( fileno( stdout ) ) )
		stdoutfl = 0;

	return;

} /* check_output */

void
#if	defined( __CB_STDC__ )
check_home_dir( char *dirname )
#else
check_home_dir( dirname )
char	*dirname;
#endif
{
#ifdef	WIN32
	struct	_stat	buf;
#else
	struct	stat	buf;
#endif

#ifdef	WIN32
	if( _stat( dirname, &buf ) < 0 )
	{
		printf( "directory(%s) stat() error:%s",
						dirname, errmsg( _START_ ) );
		errmsg( _END_ );
		exit( 2 );
	}
#else
	if( stat( dirname, &buf ) < 0 )
	{
		printf( "directory(%s) stat error(%d).\n", dirname, errno );
		exit( 2 );
	}
#endif

	/* if( !S_ISDIR( buf.st_mode ) )*/
	if( ( buf.st_mode & 0xF000 ) != S_IFDIR )
	{
		printf( "%s is not directoy.\n", dirname );
		exit( 2 );
	}

	return;

} /* check_home_dir */

/*----------------------------------------------------------------------+
| to avoid source-file which was already created by shell		|
|						by redirection cmd	|
| ex) fcom *.c > kkk.c then kkk.c may have been already created and	|
|	    included in argv(*.c) list					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
isredirfile( char *fpath )
#else
isredirfile( fpath )
char	*fpath;
#endif
{
#ifdef WIN32
	return( 0 );
#else
static	struct	stat	stdout_statbuf = {0};
	struct	stat	statbuf;

	if( !stdout_statbuf.st_ino )
		fstat( fileno(stdout), &stdout_statbuf );

	stat( fpath, &statbuf );
	if( statbuf.st_ino == stdout_statbuf.st_ino )
		return( 1 );
	else
		return( 0 );
#endif
}

/*---------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
grep_exec( char *fname )
#else
grep_exec( fname )
char	*fname;
#endif
{
	int	lineno;
	int	lines_found;
	FILE	*sfd;

	if( isredirfile( fname ) )
		return( 0 );

	/* start grep for a file */
	if( ( sfd = fopen( fname, "rb" ) ) == (FILE *)0 )
	{
		printf( "%s: can't open.\n", fname );
		return( -1 );
	}

	printf( "%s:", fname );

	/* loop-3 : loop to EOF */
	for( lineno=0, lines_found=0; !feof( sfd ); )
	{
		if( fgets( buffer, sizeof buffer, sfd ) == 0 )
				break;

		lineno++;			/* current line no */

		/* find string */
		if( strstr( buffer, srchstr ) )
		{
			if( lines_found != 0 )	/* if not first found */
				printf( "%s:", fname );
			printf( "%d:", lineno );

			/* write contents */
			fwrite( buffer, strlen( buffer ), 1, stdout );

			lines_found++;
		}

	}	/* end of loop-3 : loop to EOF */

	fclose( sfd );

	if( lines_found == 0 )
	{
		if( stdoutfl )
			printf( "\r%*.*s\r", strlen( fname ) + 1,
						strlen( fname ) + 1, " " );
		else
		{
			fseek( stdout, -1 * ( strlen( fname ) + 1 ), SEEK_CUR );
			printf( "%*.*s", strlen( fname ) + 1,
						strlen( fname ) + 1, " " );
			fseek( stdout, -1 * ( strlen( fname ) + 1 ), SEEK_CUR );
		}
	}

	return( 0 );

} /* grep_exec */

/*---------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
search_cur_dir( char *dirname )
#else
search_cur_dir( dirname )
char	*dirname;
#endif
{
	register	i, j;
	char		subdir[256];
#ifdef	WIN32
	HANDLE		hFind;
	WIN32_FIND_DATA	w32fd;
	char		dirlist[255];		/* "dirname\*.*" */
#else
	struct	stat	buf;
	DIR		*dp;
	struct	dirent	*dirp;
#endif

#ifdef	WIN32
	sprintf( dirlist, "%s\\*.*", dirname );
	hFind = FindFirstFile( dirlist, &w32fd );
	if( hFind == INVALID_HANDLE_VALUE )
	{
		printf( "cannot open directory(%s).FindFirstFile() error:%s",
						dirname, errmsg( _START_ ) );
		errmsg( _END_ );
		return -1;
	}
#else
	if( ( dp = opendir( dirname ) ) == (DIR *)0 )
	{
		printf( "cannot open directory(%s). errno(%d)\n",
							dirname, errno );
		return -1;
	}
#endif

#ifdef	WIN32
	do
#else
	while( ( dirp = readdir( dp ) ) != (struct dirent *)0 )
#endif
	{
#ifdef	WIN32
		if( w32fd.dwFileAttributes == FILE_ATTRIBUTE_DIRECTORY )
		{
			continue;
		}
		strcpy( subdir, dirname );
		strcat( subdir, "\\" );
		strcat( subdir, w32fd.cFileName );
#else
		strcpy( subdir, dirname );
		strcat( subdir, "/" );
		strcat( subdir, dirp->d_name );
		if( stat( subdir, &buf ) < 0 )
		{
			printf( "file (%s) stat error(%d).\n", subdir, errno );
			closedir( dp );
			return -1;
		}
		/* if( S_ISDIR( buf.st_mode ) || S_ISLNK( buf.st_mode ) ) */
		if( ( buf.st_mode & 0xF000 ) == S_IFDIR )
			continue;
		if ( ( buf.st_mode & 0xF000 ) == S_IFLNK )
			continue;
#endif
		if( srchext[0][0] != (char)0 )
		{
#ifdef	WIN32
			for( i=strlen(w32fd.cFileName)-1;
			     i>=0 && w32fd.cFileName[i]!='.';
			     i-- );
#else
			for( i=strlen(dirp->d_name)-1;
			     i>=0 && dirp->d_name[i]!='.';
			     i-- );
#endif
			if( i < 0 )
				continue;

			i++;
			for( j=0; j<32 && srchext[j][0]!=(char)0; j++ )
			{
#ifdef	WIN32
				char	lower_fname[255];
				int		k;
				for( k=i; k<(int)strlen(w32fd.cFileName); k++ )
				{
					if( isalpha( w32fd.cFileName[k] ) &&
					    isupper( w32fd.cFileName[k] ) )
					{
						lower_fname[k] =
						tolower( w32fd.cFileName[k] );
					}
					else
					{
						lower_fname[k] =
							w32fd.cFileName[k];
					}
				}
				lower_fname[k] = '\0';

				if( !strcmp( lower_srchext[j], &(lower_fname[i]) ) )
#else
				if( !strcmp( srchext[j], &(dirp->d_name[i]) ) )
#endif
				{
					grep_exec( subdir );
					break;
				}
			}
		}
		else
		{
			grep_exec( subdir );
		}
	}
#ifdef	WIN32
	while( FindNextFile( hFind, &w32fd ) );
#endif

#ifdef	WIN32
	FindClose( hFind );
#else
	closedir( dp );
#endif

	return 0;

} /* search_cur_dir */

/*---------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
search_sub_dir( char *dirname )
#else
search_sub_dir( dirname )
char	*dirname;
#endif
{
	char		subdir[256];
#ifdef	WIN32
	HANDLE		hFind;
	WIN32_FIND_DATA w32fd;
	char		dirlist[255];		/* "dirname\*.*" */
#else
	struct	stat	buf;
	DIR		*dp;
	struct	dirent	*dirp;
#endif

#ifdef	WIN32
	sprintf( dirlist, "%s\\*.*", dirname );
	hFind = FindFirstFile( dirlist, &w32fd );
	if( hFind == INVALID_HANDLE_VALUE )
	{
		printf( "cannot open directory(%s).FindFirstFile() error:%s",
						dirname, errmsg( _START_ ) );
		errmsg( _END_ );
		return -1;
	}
#else
	if( ( dp = opendir( dirname ) ) == (DIR *)0 )
	{
		printf( "cannot open directory(%s). errno(%d)\n",
							dirname, errno );
		return -1;
	}
#endif

#ifdef	WIN32
	do
#else
	while( ( dirp = readdir( dp ) ) != (struct dirent *)0 )
#endif
	{
#ifdef	WIN32
		if( !strcmp( w32fd.cFileName, "." ) ||
		    !strcmp( w32fd.cFileName, ".." ) )
		{
			continue;
		}

		if( w32fd.dwFileAttributes != FILE_ATTRIBUTE_DIRECTORY )
			continue;
		strcpy( subdir, dirname );
		strcat( subdir, "\\" );
		strcat( subdir, w32fd.cFileName );
#else
		if( !strcmp( dirp->d_name, "." ) ||
		    !strcmp( dirp->d_name, ".." ) )
		{
			continue;
		}

		strcpy( subdir, dirname );
		strcat( subdir, "/" );
		strcat( subdir, dirp->d_name );

		if( stat( subdir, &buf ) < 0 )
		{
			printf( "file(%s) stat error(%d).\n",
							subdir, errno );
			closedir( dp );
			return -1;
		}

		/* if( !S_ISDIR( buf.st_mode ) )	*/
		if( ( buf.st_mode & 0xF000 ) != S_IFDIR )
			continue;
#endif

		if( search_cur_dir( subdir ) < 0 )
		{
#ifdef	WIN32
			FindClose( hFind );
#else
			closedir( dp );
#endif
			return -1;
		}

		if( search_sub_dir( subdir ) < 0 )
		{
#ifdef	WIN32
			FindClose( hFind );
#else
			closedir( dp );
#endif
			return -1;
		}
	}
#ifdef	WIN32
	while( FindNextFile( hFind, &w32fd ) );
#endif

#ifdef	WIN32
	FindClose( hFind );
#else
	closedir( dp );
#endif

	return 0;

} /* search_sub_dir */

/*---------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	setbuf( stdout, 0 );

	check_args( argc, argv );

#ifndef WIN32
	signal( SIGINT, exit );
	signal( SIGTERM, exit );
#endif

	check_output();

	check_home_dir( homedir );

	if( search_cur_dir( homedir ) < 0 )
		return( 4 );

	if( search_sub_dir( homedir ) < 0 )
		return( 4 );

	return( 0 );
} /* main */

/******* End of dgrep.c ************************************************/
