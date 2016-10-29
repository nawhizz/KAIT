/* dwc.c */
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
/*WWWWWWWWW	char	srchstr[80] = ""; */
char	homedir[128] = "";
char	srchext[32][128] = { "" };
#ifdef	WIN32
char	lower_srchext[32][128] = { "" };
#endif
int	stdoutfl = 1;
char	buffer[64*1024];

int	opt_dirsummary = 0;		/* do not print each files */

/*----------------------------------------------------------------------+
|	Functions							|
+----------------------------------------------------------------------*/
/* 12345678 -> [    12,345,678] */
/* len = length of formatted buffer */
char	*
#if	defined( __CB_STDC__ )
nfmt( char *buf, int num, int len  )
#else
nfmt( buf, num, len  )
char	*buf;		/* output buffer ptr */
int	num;		/* input */
int	len;		/* input */
#endif
{
	char	sbuf[20];		/* min. 16 */
	int	n1,n2,n3,n4;

	n1 = num / 1000000000;
	num = num % 1000000000;
	n2 = num / 1000000;
	num = num % 1000000;
	n3 = num / 1000;
	n4 = num % 1000;

	memset( sbuf, ' ', sizeof sbuf );
	if( n1 > 0 )
	    sprintf( sbuf, "%3d,%03d,%03d,%03d\0", n1, n2, n3, n4 );
	else if( n2 > 0 )
	    sprintf( sbuf, "    %3d,%03d,%03d\0", n2, n3, n4 );
	else if( n3 > 0 )
	    sprintf( sbuf, "        %3d,%03d\0", n3, n4 );
	else 
	    sprintf( sbuf, "            %3d\0", n4 );

	strcpy( buf, (char *)&sbuf[ 15 - len ] );
	return( buf );
}

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
	printf( "\tFile Count utility for directory (recursive).\n" );
	printf( "\n" );
	printf( "\tUSAGE : %s <-opt> <-file_extention> ", cmdname );
	printf( "directory\n" );
	printf( "\n" );
	printf( "\t	-d = list only directory summary.\n" );
	printf( "\t ex) dwc -c -h . => count for is *.c or *.h in .\n" );
	printf( "\t ex) dwc ttt => count all files in ttt directory\n" );
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
			if( argv[1][1] != (char)0 &&
				argv[1][1] == 'd' && argv[1][2] == '\0')
			{
				opt_dirsummary = 1;
			}
			else if( argv[1][1] != (char)0 )
			{
				for( i=0; i<extcnt; i++ )
					if( !strcmp( srchext[i], &argv[1][1] ) )
						break;

				if( i == extcnt && extcnt >= 32 )
				{
					printf( "\n" );
					printf( "Too many " );
					printf( "file_extention. " );
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
/*WWWWWWWWWWWWW
			if( srchstr[0] == (char)0 )
				strcpy( srchstr, argv[1] );
			else
WWWWWWWWWWWWWW*/
			if( homedir[0] == (char)0 )
				strcpy( homedir, argv[1] );
		}

		argc--;
		argv++;
	}

/*WWWWWWWWWWWWWW
	if( srchstr[0] == (char)0 )
		prt_usage( argv0 );
WWWWWWWWWWWWWWW*/
	if( homedir[0] == (char)0 )
		strcpy( homedir, "." );

/*WWWWWWWWWWWWWWW
	for( i=strlen(srchstr)-1; i>=0 && srchstr[i]!=' '; i-- );
	if( i >= 0 )
	{
		memmove( &srchstr[1], srchstr, strlen( srchstr ) );
		srchstr[0] = '"';
		srchstr[strlen(srchstr)] = '"';
	}
WWWWWWWWWWWWWWW*/

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
/* do it for a file. fname = filepath */
int
#if	defined( __CB_STDC__ )
do_a_file( char *fname, int *nlines, int *nbytes )
#else
do_a_file( fname, nlines, nbytes )
char	*fname;
int	*nlines;
int	*nbytes;
#endif
{
	int	lineno;
	int	lines_found;
	FILE	*sfd;
	char	buf[100];

	(*nlines)	= 0;
	(*nbytes)	= 0;

	if( isredirfile( fname ) )
		return( 0 );

	/* start grep for a file */
	if( ( sfd = fopen( fname, "rb" ) ) == (FILE *)0 )
	{
		printf( "%s: can't open.\n", fname );
		return( -1 );
	}

	/* loop-3 : loop to EOF */
	for( lineno=0, lines_found=0; !feof( sfd ); )
	{
		if( fgets( buffer, sizeof buffer, sfd ) == 0 )
				break;
		lineno++;
		(*nlines)++;
	}	/* end of loop-3 : loop to EOF */
	fclose( sfd );

	if( !opt_dirsummary ) printf( "%s	: %s Line.\n",
		fname, nfmt(buf,*nlines,6) );

	return( 0 );

} /* do_a_file */

/*---------------------------------------------------------------------*/
/* search files in current current directory except sub directories */
int
#if	defined( __CB_STDC__ )
search_cur_dir( char *dirname, int *nfiles, int *nlines, int *nbytes )
#else
search_cur_dir( dirname, nfiles, nlines, nbytes )
char	*dirname;		/* input */
int	*nfiles;		/* output */
int	*nlines;		/* output */
int	*nbytes;		/* output */
#endif
{
	register	i, j;
	char		direntry[256];
#ifdef	WIN32
	HANDLE		hFind;
	WIN32_FIND_DATA	w32fd;
	char		dirlist[255];		/* "dirname\*.*" */
#else
	struct	stat	buf;
	DIR		*dp;
	struct	dirent	*dirp;
#endif
	int		nlines_a_file;
	int		nbytes_a_file;

	(*nfiles)	= 0;
	(*nlines)	= 0;
	(*nbytes)	= 0;

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
		strcpy( direntry, dirname );
		strcat( direntry, "\\" );
		strcat( direntry, w32fd.cFileName );
#else
		strcpy( direntry, dirname );
		strcat( direntry, "/" );
		strcat( direntry, dirp->d_name );
		if( stat( direntry, &buf ) < 0 )
		{
			printf( "file (%s) stat error(%d).\n",
				direntry, errno );
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
					do_a_file( direntry, &nlines_a_file,
						&nbytes_a_file );
					(*nfiles)++;
					(*nlines) += nlines_a_file;
					(*nbytes) += nbytes_a_file;
					break;
				}
			}
		}
		else
		{
			do_a_file( direntry, &nlines_a_file, &nbytes_a_file );
			(*nfiles)++;
			(*nlines) += nlines_a_file;
			(*nbytes) += nbytes_a_file;
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
/* search files in current directory and in subdirectiories recursively */
/* (by calling search_cur_dir() and recursive calling search_dir_recursive() )*/
int
#if	defined( __CB_STDC__ )
search_dir_recursive( char *dirname, int *ndir, int *nfiles, int *nlines, int *nbytes , int *ndir_tot, int *nfiles_tot, int *nlines_tot, int *nbytes_tot )
#else
search_dir_recursive( dirname, ndir, nfiles, nlines, nbytes , ndir_tot, nfiles_tot, nlines_tot, nbytes_tot )
char	*dirname;		/* input */
int	*ndir;			/* output. just in current dir. */
int	*nfiles;		/* output. just in current dir.  */
int	*nlines;		/* output. just in current dir.  */
int	*nbytes;		/* output. just in current dir.  */
int	*ndir_tot;		/* output. total recursively */
int	*nfiles_tot;		/* output. total recursively */
int	*nlines_tot;		/* output. total recursively */
int	*nbytes_tot;		/* output. total recursively */
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
	int	ndir_subdir;
	int	nfiles_subdir;
	int	nlines_subdir;
	int	nbytes_subdir;
	int	ndir_tot_subdir;
	int	nfiles_tot_subdir;
	int	nlines_tot_subdir;
	int	nbytes_tot_subdir;
	char	buf1[20];		/* min. 16 */
	char	buf2[20];		/* min. 16 */
	char	buf3[20];		/* min. 16 */

	(*ndir)		= 0;
	(*nfiles)	= 0;
	(*nlines)	= 0;
	(*nbytes)	= 0;
	(*ndir_tot)	= 0;
	(*nfiles_tot)	= 0;
	(*nlines_tot)	= 0;
	(*nbytes_tot)	= 0;

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

		if( search_dir_recursive( subdir, 
			&ndir_subdir, &nfiles_subdir,
			&nlines_subdir, &nbytes_subdir,
			&ndir_tot_subdir, &nfiles_tot_subdir,
			&nlines_tot_subdir, &nbytes_tot_subdir ) < 0 )
		{
#ifdef	WIN32
			FindClose( hFind );
#else
			closedir( dp );
#endif
			return -1;
		}

		(*ndir)++;
		(*ndir_tot)++;
		(*ndir_tot)	+= ndir_tot_subdir;
		(*nfiles_tot)	+= nfiles_tot_subdir;
		(*nlines_tot)	+= nlines_tot_subdir;
		(*nbytes_tot)	+= nbytes_tot_subdir;

	}
#ifdef	WIN32
	while( FindNextFile( hFind, &w32fd ) );
#endif

#ifdef	WIN32
	FindClose( hFind );
#else
	closedir( dp );
#endif

	if( search_cur_dir( dirname, nfiles, nlines, nbytes ) < 0 )
	{
		return -1;
	}

	(*nfiles_tot)	+= (*nfiles);
	(*nlines_tot)	+= (*nlines);
	(*nbytes_tot)	+= (*nbytes);

	printf( "%s", dirname );
#ifdef	WIN32
	if( !opt_dirsummary ) printf ("\\" );
#else
	if( !opt_dirsummary ) printf ("/" );
#endif
	if( !opt_dirsummary || (*ndir) > 0 ) printf( " (TOTAL)" );
	printf( "	:" );
	printf( " %s File", nfmt(buf2,*nfiles_tot,6) );
	printf( " %s Line", nfmt(buf3,*nlines_tot,9) );
	if( (*ndir_tot) > 0 ) printf( " %s Dir", nfmt(buf1,*ndir_tot,5) );
	printf( ".\n" );
	return 0;

} /* search_dir_recursive */

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
	int	ndir;
	int	nfiles;
	int	nlines;
	int	nbytes;
	int	ndir_tot;
	int	nfiles_tot;
	int	nlines_tot;
	int	nbytes_tot;
	char	buf[20];		/* min. 16 */

	setbuf( stdout, 0 );

	check_args( argc, argv );

#ifndef WIN32
	signal( SIGINT, exit );
	signal( SIGTERM, exit );
#endif

	check_output();

	check_home_dir( homedir );

	if( search_dir_recursive( homedir, &ndir, &nfiles, &nlines, &nbytes,
			&ndir_tot, &nfiles_tot, &nlines_tot, &nbytes_tot ) < 0 )
		return( 4 );

	printf( "\n" );
	printf( "%s Summary.\n", homedir );
	printf( "	Total %s Dirs.\n", nfmt(buf, ndir_tot, 13 ) );
	printf( "	Total %s Files.\n", nfmt(buf, nfiles_tot, 13 ) );
	printf( "	Total %s Lines.\n", nfmt(buf, nlines_tot, 13 ) );
	/*printf( "	Total %s Bytes.\n", nfmt(buf, nbytes_tot, 13 ) ); */
	printf( "\n" );

	return( 0 );
} /* main */

/******* End of dwc.c ************************************************/
/*WWWW
search_cur_dir( char *dirname, int *nfiles, int *nlines, int *nbytes )
search_dir_recursive( char *dirname, int *ndir, int *nfiles, int *nlines, int *nbytes , int *ndir_tot, int *nfiles_tot, int *nlines_tot, int *nbytes_tot )
do_a_file( char *fname, int *nlines, int *nbytes )
WWWW*/
