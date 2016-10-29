/* grep string utility */
/*	usage : sgrep <option> file1 file2 file3 ... */

#include	<string.h>
#include	<stdlib.h>
#include	<stdio.h>

#ifdef		WIN32
#include	<io.h>
#include	<fcntl.h>
#ifndef		R_OK
#define 	R_OK	04
#endif
#else
#include	<unistd.h>
#endif

#include	"cbuni.h"


/*----------------------------------------------------------------------*/
/* define and extern variables */
/*----------------------------------------------------------------------*/

#define S_BUFSIZE 32*1024

/* option bits */
#define	OPT_WITHLINENO		1	/* output line numbers */
#define	OPT_WITHFPATH		2	/* output with fpath eachline */
#define	OPT_PRINTALLFILES	4	/* do not ignore not found files */
#define	OPT_PRINTSUMMARY	8	/* print summary */
struct	S_SFLIST {
	char	fpath[255];
	struct	S_SFLIST *next;
};

/*----------------------------------------------------------------------*/
/* function declaration */
/*----------------------------------------------------------------------*/
void	s_prtcommand();
int	s_dogrep CBD2(( int argc, char *argv[], int nopt, char *srchstr,
							int optval ));
#ifndef WIN32
int	s_chkifredirfile CBD2(( char *fpath ));
int	s_chkiffile CBD2(( char *fpath ));
#endif
int	s_sfiles_add CBD2(( struct S_SFLIST **sfiles, char *fpath ));
int	s_sfiles_free CBD2(( struct S_SFLIST **sfiles ));

/*----------------------------------------------------------------------*/
/* MAIN Procedure */
/* sgrepfun() actually same as main() */
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	int	i;
	int	files_input_started = 0;
	int	nopt;			/* no of options */
	char	srchstr[255];		/* search string */
	int	optval;			/* option value. bitwise */

	setbuf( stdout, (char *)0 );

	srchstr[0] = '\0';
	nopt = 0;
	optval = 0;

	if( argc < 3 ) {
		s_prtcommand();
		return(1);
	}

	for( i=1; i<argc; i++ )
	{
		if( argv[i][0] == '-' )
		{
			if( files_input_started )
			{
				printf("\n command error!\n" );
				s_prtcommand();
				return(1);
			}

			switch( argv[i][1] )
			{
			case 'n' :
				nopt ++;
				optval |= OPT_WITHLINENO;
				break;
			case 'p' :
				nopt ++;
				optval |= OPT_WITHFPATH;
				break;
			case 's' :
				nopt ++;
				optval |= OPT_PRINTSUMMARY;
				break;
			case 'f' :
				nopt ++;
				optval |= OPT_PRINTALLFILES;
				break;
			default  :
				printf( "\nInvalid Option %2.2s\n", argv[i] );
				s_prtcommand();
				return(1);
			}
		}
		else {
			if( !srchstr[0] ) {
				strcpy( srchstr, argv[i] );
			}
			else	files_input_started = 1;
		}
	}

	if( !srchstr[0] ) {
		printf( "\n search string not defined!\n" );
		s_prtcommand();
		return(1);
	}
	if( !files_input_started ) {
		printf( "\n Source files not defined!\n" );
		s_prtcommand();
		return(1);
	}

#ifdef	WIN32
	_setmode( _fileno(stdout), _O_BINARY );
#endif

	return( s_dogrep( argc, argv, nopt, srchstr, optval ) );
}

void
s_prtcommand()
{
	printf("\n" );
	printf("   +-------------------------------------------------+\n" );
	printf("   |   grep string utility                           |\n" );
	printf("   |-------------------------------------------------|\n" );
	printf("   | Usage : sgrep string <options> file1 <file2 ..> |\n" );
	printf("   |     <options>                                   |\n" );
	printf("   |       -n : with line no                         |\n" );
	printf("   |       -p : with file path                       |\n" );
	printf("   |       -s : print summary                        |\n" );
	printf("   |       -f : print all not found files            |\n" );
	printf("   |     by S.T.Woo.  HYSYS. 1998.5                  |\n" );
	printf("   |     V1.0                                        |\n" );
	printf("   +-------------------------------------------------+\n" );
	printf("\n" );
}

int
#if	defined( __CB_STDC__ )
s_dogrep( int argc, char *argv[], int nopt, char *srchstr, int optval )
#else
s_dogrep( argc, argv, nopt, srchstr, optval )
int	argc;
char 	*argv[];
int	nopt;
char	*srchstr;
int	optval;
#endif
{
	int		lineno, lines_found, lines_found_tot;
	int		nfiles, nfiles_found;
	int		i;
	int		errexit = 0;
	char		spath[255];		/* source file path */
	FILE		*sfd = (FILE *)0;
	char		*sbuf;			/* read line buffer */
	struct S_SFLIST *sfiles;

	int		nokfile = 0;	/* ok files */
	int		nzerofile=0;	/* skip files abnormally */
	int		nerrfile=0;

	lines_found_tot = 0;
	nfiles_found = 0;
	sfiles = (struct S_SFLIST * )0;

	sbuf = malloc( S_BUFSIZE + 1 ); 	/* read line buffer */
	if( sbuf == (char *)0 )
	{
		printf( "Insufficient memory(malloc %d bytes) Error!\n",
			S_BUFSIZE );
		return(-1);
	}
	sbuf[ S_BUFSIZE ] = '\0';

	/* loop-1 : loop for args */
	for( i=1+1+nopt, nfiles=0; i<argc; i++ )
	{
#ifdef	WIN32
	int		argsts; 	/* 0=startof arg, 1=nextof arg, */
					/* -1=endof arg */
	char		dirpath[255];
	int		j;
	HANDLE		hFind = INVALID_HANDLE_VALUE;
	WIN32_FIND_DATA w32fd;

	/* loop-2 : loop for files : WIN32 only to consider wild char *,? */
	for( argsts=0 ; argsts>=0 ; )
	{
		if( !argsts )			/* FIRST */
		{
			/* get directory path */
			for( j=strlen(argv[i])-1; j>=0; j-- )
			{
				if( argv[i][j] == '\\' || argv[i][j] == ':' )
					break;
			}
			if( j >= 0 )
			{
				strncpy( dirpath, argv[i], j+1 );
				dirpath[j+1] = '\0';
			}
			else	dirpath[0] = '\0';

			hFind = FindFirstFile( argv[i], &w32fd );
			if( hFind == INVALID_HANDLE_VALUE )
			{
				printf( "%s: Invalid path(no such file)!\n",
					argv[i] );
				argsts=-1;
				break;
			}
			argsts = 1;
			/* skip . and .. */
			if( !strcmp( w32fd.cFileName, "." ) ||
				!strcmp( w32fd.cFileName, ".." ) )
			{
				continue;
			}
		}
		else
		{	/* NEXT */
			if( !FindNextFile( hFind, &w32fd ) )	/*NO MORE*/
			{
				argsts=-1;
				break;
			}
			/* skip . and .. */
			if( !strcmp( w32fd.cFileName, "." ) ||
				!strcmp( w32fd.cFileName, ".." ) )
			{
				continue;
			}
		}
		strcpy( spath, dirpath );
		strcat( spath, w32fd.cFileName );
#else
		strcpy( spath, argv[i] );
#endif
		/* now 1 file selected */
		switch( s_sfiles_add( &sfiles, spath ) )
		{
			case -1 :	/* ERR */
				printf( "%s: Insufficient memory Error!\n",
								spath );
				errexit = 1;	/* stop fcom */
				break;
			case 0	:	/* OK */
				break;
			case 1	:	/* ALREAY EXIST */
				/*printf(
				"%s: duplicated.(alreay done)\n", spath );*/
				continue;
		}

		if( errexit ) break;

		/* skip if file alreay combined by previous args */
		/* - to avoid duplication (ex) fcom aaa.c *.c
				=> aaa.c aaa.c b.c ... */

#ifdef	WIN32
		if( w32fd.dwFileAttributes == FILE_ATTRIBUTE_DIRECTORY )
#else
		if( !s_chkiffile( spath ) )
#endif
		{
			if( optval & OPT_PRINTALLFILES )
				printf( "%s: is a directory.\n", spath );
			continue;
		}
#ifndef WIN32
		if( s_chkifredirfile( spath ) )
			continue;
#endif
		nfiles++;

		/* start grep for a file */
		if( ( sfd = fopen( spath, "rb" ) ) == (FILE *)0 )
		{
			printf( "%s: can't open.\n", spath );
			nerrfile++;
			continue;
		}

		printf( "%s:", spath );

		/* loop-3 : loop to EOF */
		for( lineno = 0, lines_found = 0; !feof( sfd );  )
		{
			if( fgets( sbuf, S_BUFSIZE, sfd ) == 0 )
				break;

			lineno++;		/* current line no */

			/* find string */
			if( strstr( sbuf, srchstr ) )
			{
				if( lines_found == 0 )	/* if first found */
				{
					if( !(optval & OPT_WITHFPATH) )
						printf( "\n" );
				}
				else
				{
					if( optval & OPT_WITHFPATH )
						printf( "%s:", spath );
				}
				if( optval & OPT_WITHLINENO )
					printf( "%d:", lineno );
				/* write contents */
				/* puts( sbuf ); */
				fwrite( sbuf, strlen( sbuf ), 1, stdout );
				lines_found++;
				lines_found_tot++;
			}

		}	/* end of loop-3 : loop to EOF */

		fclose( sfd );

		if( lines_found > 0 )	/* string found */
		{
			nokfile++;
			nfiles_found++;
			printf( "\n" );
		}
		else if( lineno > 0 )	/* string not found */
		{
			nokfile++;
			if( optval & OPT_PRINTALLFILES )
				printf( "\n" );
			else
			{
				printf( "\r%*.*s\r", strlen( spath ) + 2,
						strlen( spath ) + 2, " " );
			}
		}
		else		/* zero size file : skip */
		{
			if( optval & OPT_PRINTALLFILES )
				printf( " zero file.\n" );
			else
			{
				printf( "\r%*.*s\r", strlen( spath ) + 2,
						strlen( spath ) + 2, " " );
			}
			nzerofile++;
		}

		/* end grep for a file */

#ifdef	WIN32
	}		/* end of loop-2 : loop for files of same wild char *,? WIN32 */
	if( hFind != INVALID_HANDLE_VALUE )	FindClose( hFind );
	if( errexit )	break;
#endif

	}		/* end of loop-1 : loop for args */

	/* free file path list table */
	s_sfiles_free( &sfiles );

	if( errexit )
	{
		/* printf( "\n Abnormally terminated !\n" ); */
		free( sbuf );
		return(-1);
	}

	if( !( optval & OPT_PRINTSUMMARY ) ) 
	{
		free( sbuf );
		return( 0 );
	}

	if( lines_found_tot )
		printf( "\t<%s> Found %d lines at %d files in %d files\n",
			srchstr, lines_found_tot, nfiles_found, nfiles );
	else
		printf( "\t<%s> Not found in %d files\n", srchstr, nfiles );

	if( nzerofile + nerrfile )
	{
		printf( "\n\t%d files successfully checked.\n", nokfile );
		if( nzerofile )
			printf(
			"\t%d files are not checked(zero size).\n", nzerofile );
		if( nerrfile )
			printf(
			"\t%d files are not checked(can't open).\n", nerrfile );
	}

	free( sbuf );
	return(0);
}

#ifndef WIN32
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<stdio.h>
/* if file then return 1, else (directory) then return 0 */
int
#if	defined( __CB_STDC__ )
s_chkiffile( char *fpath )
#else
s_chkiffile( fpath )
char	*fpath;
#endif
{
struct	stat	statbuf;

	stat( fpath, &statbuf );
	if( statbuf.st_mode >= (long)0x8000 ) return(1);
	else	return(0);
}
#endif

#ifndef WIN32
/* 980428 bug patch : to avoid source-file which was already created by
	shell by redirection cmd
	ex) sgrep srch *.c > kkk.c then kkk.c may have been already created and
	    included in argv(*.c) list */
int
#if	defined( __CB_STDC__ )
s_chkifredirfile( char *fpath )
#else
s_chkifredirfile( fpath )
char	*fpath;
#endif
{
static	struct	stat	stdout_statbuf = {0};
	struct	stat	statbuf;

	if( !stdout_statbuf.st_ino )
		fstat( fileno(stdout), &stdout_statbuf );

	stat( fpath, &statbuf );
	if( statbuf.st_ino == stdout_statbuf.st_ino )
		return(1);
	else	return(0);
}
#endif

/*----------------------------------------------------------------------*/
/* add filepath to table to avoid duplicated filelist input */
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
s_sfiles_add( struct S_SFLIST **sfiles, char *fpath )
#else
s_sfiles_add( sfiles, fpath )
struct S_SFLIST **sfiles;
char		*fpath;
#endif
{
	struct	S_SFLIST	*sfl;

	if( (*sfiles) == (struct S_SFLIST *) 0 )
	{
		(*sfiles) = (struct S_SFLIST *)
			malloc( sizeof( struct S_SFLIST ) );
		if( (*sfiles) == (struct S_SFLIST *)0 )
			return( -1 );		/* ERR */
		strcpy( (*sfiles)->fpath, fpath );
		(*sfiles)->next = (struct S_SFLIST *)0;
		return(0);		/* OK */
	}
	else
	{
		sfl = (*sfiles);
		for( ; ; )
		{
			if( !strcmp( sfl->fpath, fpath ) )	/* ALREADY EXIST */
				return(1);
			else if( sfl->next == (struct S_SFLIST *)0 )
				break;
			else
				sfl = sfl->next;
		}

		sfl->next = (struct S_SFLIST *)
			malloc( sizeof( struct S_SFLIST ) );
		if( sfl->next == (struct S_SFLIST *)0 )
			return( -1 );		/* ERR */
		sfl = sfl->next;
		strcpy( sfl->fpath, fpath );
		sfl->next = (struct S_SFLIST *)0;
		return(0);		/* OK */
	}
}

/*----------------------------------------------------------------------*/
/* free memory for sfiles table */
/*----------------------------------------------------------------------*/
int
s_sfiles_free( sfiles )
struct	S_SFLIST ** sfiles;
{
	struct	S_SFLIST	*sfl;
	struct	S_SFLIST	*sfltmp;


	for( sfl=(*sfiles); ; )
	{
		if( sfl == (struct S_SFLIST *)0 )
			break;
		sfltmp = sfl;
		sfl = sfl->next;
		free( sfltmp );
	}

	(*sfiles) = (struct S_SFLIST *)0;
	return( 0 );
}
