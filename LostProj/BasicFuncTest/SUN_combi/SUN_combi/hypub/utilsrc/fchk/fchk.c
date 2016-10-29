/* fchk.c */
/************************************************************************
* Text file check and convert CR/LF/EOF <-> LF utility			*
*	usage : fchk <option> file1 file2 file3 ...			*
************************************************************************/

#include	<string.h>
#include	<stdio.h>
#include	"cbuni.h"

#ifdef		WIN32
#include	<io.h>
#include	<fcntl.h>
#include	<sys/types.h>		/* for stat() */
#include	<sys/stat.h>		/* for stat() */
#include	<sys/utime.h>		/* for utime() */
#define 	R_OK	04
#else
#include	<unistd.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<stdio.h>
#include	<utime.h>
#endif

/*----------------------------------------------------------------------+
|	Defines 							|
+----------------------------------------------------------------------*/
#define BUFSIZE 		64*1024
#define MAXLINELEN		512	/* max. line length if text format */

#define FK_UNKNOWN		0	/* not assigned yet */
#define FK_TEXT_CRLF		1	/* text file which includes CR+LF */
#define FK_TEXT_LF		2	/* text file which includes LF */
#define FK_CONTROL		4	/* include control characters */
#define FK_EOF			8	/* include EOF at endoffile */
#define FK_ZEROSIZE		16	/* zero size file */
#define FK_BINARY		32	/* binary file */
#define FK_OPENERR		64	/* open err */
#define FK_CONVERTED		128	/* if file converted */
#define FK_ERR			0xffff	/* critical err */

/*----------------------------------------------------------------------+
|	Extern Variables						|
+----------------------------------------------------------------------*/
char		tmppath[]= "_fchk.tmp"; /* temporary output file path */
unsigned char	buf[BUFSIZE+1]; 	/* read file buffer */
unsigned char	wbuf[BUFSIZE*2+1];	/* write file buffer */
int		narg;			/* no of arguments */
int		noption;		/* no of options */
int		opt_topc;
int		opt_tounix;
int		opt_remaintime; 	/* remain file update time */
char		**argvptr;

/*----------------------------------------------------------------------+
|	Function Declaration						|
+----------------------------------------------------------------------*/
char	* getbasename CBD2(( char *fpath ));
void	prtcommand();
int	dofchk();
int	do_a_file CBD2(( char *fpath ));
#ifndef WIN32
int	chkifredirfile CBD2(( char *fpath ));
int	chkiffile CBD2(( char *fpath ));
#endif
int	sfiles_add CBD2(( char *fpath ));
void	sfiles_free();
void	sfiles_init();

/*----------------------------------------------------------------------*/
/* MAIN Procedure */
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
	int	ret;

	narg = argc;
	noption = 0;
	opt_topc = 0;
	opt_tounix = 0;
	opt_remaintime = 0;

	for( i=0; i<argc; i++ ) {
		if( argv[i][0] == '-' ) {
			switch( argv[i][1] ) {
				case 'p' :
					noption ++;
					opt_topc = 1;
					break;
				case 'u' :
					noption ++;
					opt_tounix = 1;
					break;
				case 't' :
					noption ++;
					opt_remaintime = 1;
					break;
				default  :
					printf( "\nInvalid Option %s\n",
						argv[i] );
					prtcommand();
					return(1);
			}
		}
	}

	if( opt_topc && opt_tounix )
	{
	      printf( "\n-u and -p option can't be used at the same time.\n\n");
		return(1);
	}

	if( !opt_topc && !opt_tounix && opt_remaintime )
	{
		printf( "\nInvalid option -t. use -t with -p or -u.\n\n" );
		return(1);
	}

	if( argc - noption < 2 ) {
		prtcommand();
		return(1);
	}

	argvptr = argv;

#ifdef	WIN32
	_setmode( _fileno(stdout), _O_BINARY );
#endif

	printf( "\n" );
	if( opt_tounix	) {
		printf( "converting Text Files to UNIX format");
		printf( "(all CR+LF -> LF, EOF deleted).....\n");
		if( opt_remaintime )
			printf( "(without changing file access time.)\n\n" );
	}
	if( opt_topc  ) {
		printf( "Converting Text Files to PC format");
		printf( "(all LF -> CR+LF).....\n");
		if( opt_remaintime )
			printf( "(without changing file access time.)\n\n" );
	}

	ret = dofchk();

	if( access( tmppath, R_OK ) == 0 )
	{
		unlink( tmppath );
	}

	return( ret );
}

void
prtcommand()
{
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |   Text File Check and Convert CRLF Utility      |\n" );
	printf( "   |-------------------------------------------------|\n" );
	printf( "   | Usage : fchk <options> file1 <file2 ...>        |\n" );
	printf( "   |     <options>                                   |\n" );
	printf( "   |       -p : convert to PC format (LF->CR+LF)     |\n" );
	printf( "   |       -u : convert to UNIX format (CR+LF->LF)   |\n" );
	printf( "   |       -t : convert without changing file time   |\n" );
	printf( "   |     if no options, chk only format in detail.   |\n" );
	printf( "   |     by S.T.Woo.  HYSYS. 1998.5                  |\n" );
	printf( "   |     V1.0                                        |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
}

int
dofchk()
{
	char	spath[255];			/* source file path */
	int	argp;
	int	fkind;
	/* no of files */
	int	nfile_sum = 0;		/* total */
	int	nfile_text_pc = 0;
	int	nfile_text_unix = 0;
	int	nfile_text_pcunix = 0;
	int	nfile_zerosize = 0;
	int	nfile_binary = 0;
	int	nfile_openerr = 0;
	int	nfile_converted = 0;


	sfiles_init();

	/* loop-1 : loop for args */
	for( argp=1+noption, nfile_sum=0; argp<narg; argp++ )
	{
#ifdef	WIN32
		int	argsts;
			/* 0=startof arg, 1=nextof arg, -1=endof arg */
		char	dirpath[255];
		int	j;
		HANDLE	hFind = INVALID_HANDLE_VALUE;
		WIN32_FIND_DATA w32fd;

		/* loop-2 : loop for files : WIN32 only consider wild char *,? */
		for( argsts=0 ; argsts>=0 ; ) {

		if( !argsts ) { /* FIRST */
			/* get directory path */
			for( j=strlen(argvptr[argp])-1; j>=0; j-- ) {
				if( argvptr[argp][j] == '\\' ||
					argvptr[argp][j] == ':' )
					break;
			}
			if( j >= 0 ) {
				strncpy( dirpath, argvptr[argp], j+1 );
				dirpath[j+1] = '\0';
			}
			else		dirpath[0] = '\0';

			hFind = FindFirstFile( argvptr[argp], &w32fd );
			if( hFind == INVALID_HANDLE_VALUE ) {	/* ERROR */
				printf( "%s -> Invalid path(no such file)!\n",
					argvptr[argp] );
				argsts=-1;
				break;
			}
			argsts = 1;
			/* skip . and .. */
			if( !strcmp( w32fd.cFileName, "." ) ||
				!strcmp( w32fd.cFileName, ".." ) ) {
				continue;
			}
		} else {	/* NEXT */
			if( !FindNextFile( hFind, &w32fd ) ) {	/*NO MORE*/
				argsts=-1;
				break;
			}
			/* skip . and .. */
			if( !strcmp( w32fd.cFileName, "." ) ||
				!strcmp( w32fd.cFileName, ".." ) )
				continue;
		}
		strcpy( spath, dirpath );
		strcat( spath, w32fd.cFileName );
#else
		strcpy( spath, argvptr[argp] );
#endif

		switch( sfiles_add( spath ) ) {
			case -1 :	/* ERR */
				printf( "%s -> Insufficient memory !\n", spath );
				printf( "\n Abnormally terminated !\n" );
				return(1);
			case 0	:	/* OK */
				break;
			case 1	:	/* ALREAY EXIST */
				continue;
		}

		/* skip if file alreay combined by previous args */
		/* - to avoid duplication (ex) fchk aaa.c *.c =>
			aaa.c aaa.c b.c ... */
#ifdef	WIN32
		if( w32fd.dwFileAttributes == FILE_ATTRIBUTE_DIRECTORY ) {
#else
		if( !chkiffile( spath ) ) {
#endif
			continue;
		}
#ifndef WIN32
		if( chkifredirfile( spath ) ) {
			continue;
		}
#endif

		nfile_sum++;

		printf( "%s", spath );
		fflush( stderr );

		fkind = do_a_file( spath );
		if( fkind == FK_ERR )
		{
			printf( "\n Abnormally terminated !\n" );
			return(1);
		}
		switch( fkind & ~FK_CONTROL & ~FK_EOF & ~FK_CONVERTED )
		{
			case	FK_UNKNOWN	:
				if( fkind & FK_EOF )
				{
					printf( " \t=> Text ( PC )" );
					printf( " ( no CR/LF )" );
					printf( " ( with EOF )" );
					if( fkind & FK_CONVERTED )
					nfile_text_pc++;
				}
				else
				{
					printf( " \t=> Text ( UNIX )" );
					printf( " ( no CR/LF )" );
					nfile_text_unix++;
				}
				break;
			case	FK_TEXT_CRLF	:
				printf( " \t=> Text ( PC )" );
				if( fkind & FK_CONTROL )
					printf( " ( includes CONTROL CHARs )" );
				if( fkind & FK_EOF )
					printf( " ( with EOF )" );
				nfile_text_pc++;
				break;
			case	FK_TEXT_LF	:
				printf( " \t=> Text ( UNIX )" );
				if( fkind & FK_CONTROL )
					printf( " ( includes CONTROL CHARs )" );
				if( fkind & FK_EOF )
					printf( " ( with EOF )" );
				nfile_text_unix++;
				break;
			case	FK_TEXT_CRLF | FK_TEXT_LF :
				printf( " \t=> Text ( PC+UNIX )" );
				printf( " ( both LF and CRLF )" );
				if( fkind & FK_CONTROL )
					printf( " ( includes CONTROL CHARs )" );
				if( fkind & FK_EOF )
					printf( " ( with EOF )" );
				nfile_text_pcunix++;
				break;
			case	FK_ZEROSIZE	:
				printf( " \t=> Zero size !!" );
				nfile_zerosize++;
				break;
			case	FK_BINARY	:
				printf( " \t=> Binary." );
				nfile_binary++;
				break;
			case	FK_OPENERR	:
				printf( " \t=> Open error !!" );
				nfile_openerr++;
				break;
		}
		if( fkind & FK_CONVERTED )
		{
			nfile_converted++;
			printf( " .....converted." );
		}
		printf( ".\n" );

#ifdef	WIN32
		}	/* end of loop-2 : files of same wild char *,? WIN32 */

		if( hFind != INVALID_HANDLE_VALUE ) FindClose( hFind );
#endif

	}	/* end of loop-1 : loop for args */

	/* free file path list table */
	sfiles_free();

	/* print summary */
		printf( "\n" );
		printf( "\tTotal            = %5d files\n", nfile_sum );
	if( nfile_text_pc )
		printf( "\tText ( PC )      = %5d files.\n", nfile_text_pc );
	if( nfile_text_unix )
		printf( "\tText ( UNIX )    = %5d files.\n", nfile_text_unix );
	if( nfile_text_pcunix )
		printf( "\tText ( PC+UNIX ) = %5d files.\n", nfile_text_pcunix );
	if( nfile_zerosize )
		printf( "\tZero size        = %5d files.\n", nfile_zerosize );
	if( nfile_binary )
		printf( "\tBinary           = %5d files.\n", nfile_binary );
	if( nfile_openerr )
		printf( "\tCan't open       = %5d files.\n", nfile_openerr );

	if( nfile_converted )
	{
		printf( "\n" );
		printf( "\t%d File(s) Converted", nfile_converted );
		if( opt_tounix )
			printf( " to UNIX Format.\n" );
		if( opt_topc )
			printf( " to PC Format.\n" );
		if( opt_remaintime )
		{
			printf( "\t ( without changing file access time.)\n" );
		}
	} else if( opt_topc || opt_tounix )
	{
		printf( "\n" );
		printf( "\t No File(s) Converted.\n" );
	}
	printf( "\n" );

	return(0);
}

/*  return FK_XXX */
int
#if	defined( __CB_STDC__ )
do_a_file( char *fpath )
#else
do_a_file( fpath )
char	*fpath;
#endif
{
	FILE	*sfd;
	FILE	*tfd;		/* tmp file */
	register	i;
	register linelen;	/* current length of line excluding CR,LF */
	register crappeared;	/* CR appeared after last LF */
	int	fkind;
	int	nblock, nread;
	int	ntowrite;
#ifdef WIN32
	struct	_stat		statbuf;
	struct	_utimbuf	utimes;
#else
	struct	stat	statbuf;
	struct	utimbuf utimes;
#endif

	if( opt_remaintime )
	{
#ifdef WIN32
		_stat( fpath, &statbuf );
#else
		stat( fpath, &statbuf );
#endif
	}

	if( ( sfd = fopen( fpath, "rb" ) ) == (FILE *)0 ) {
		return( FK_OPENERR );
	}

	linelen = 0;
	crappeared = 0;
	fkind = FK_UNKNOWN;
	tfd = (FILE *)0;

	for( nblock=0 ; ; nblock++ )
	{
		ntowrite = 0;

		if( nblock < 2 )nread = (int)fread( buf, 1, MAXLINELEN, sfd );
		else		nread = (int)fread( buf, 1, BUFSIZE, sfd );

		if( nread <= 0 )	/* EOF */
			break;

		for( i=0; i<nread; i++	)
		{
			if( fkind & FK_EOF )
			{
				fclose( sfd );
				if( tfd ) fclose( tfd );
				return( FK_BINARY );
			}

			if( buf[i] == 0x0d )	/* CR */
			{
				if( crappeared )	/* (LF)...CR+CR */
				{
					fclose( sfd );
					if( tfd ) fclose( tfd );
					return( FK_BINARY );
				}
				else
					crappeared = 1;

				if( opt_topc )
				{
					wbuf[ntowrite++] = 0x0d;
				}
				linelen = 0;
			}
			else if( buf[i] == 0x0a )	/* LF */
			{
				if( !crappeared )	/* (LF)...LF */
				{
					fkind |= FK_TEXT_LF;

					if( opt_topc )
						wbuf[ntowrite++] = 0x0d;
					if( opt_topc || opt_tounix )
						wbuf[ntowrite++] = 0x0a;
				}
				else		/* CR+LF */
				{
					fkind |= FK_TEXT_CRLF;

					if( opt_topc || opt_tounix )
						wbuf[ntowrite++] = 0x0a;
				}
				crappeared = 0;
				linelen = 0;
			}
			else if( buf[i] == 0x1a )	/* EOF */
			{
				if( crappeared )
				{
					fclose( sfd );
					if( tfd ) fclose( tfd );
					return( FK_BINARY );
				}
				fkind |= FK_EOF;

				if( opt_topc )
					wbuf[ntowrite++] = 0x1a;
			}
			else if( ( buf[i] == 0x00 ) ||
				/*
				 ( buf[i] == 0x07 ) ||
				 ( buf[i] == 0x08 ) ||
				 ( buf[i] == 0x0b ) ||
				 ( buf[i] == 0x0e ) ||
				 ( buf[i] == 0x0f ) ||
				*/
				 ( buf[i] == 0x7f ) )
			{
				fclose( sfd );
				return FK_BINARY;
			}
			else if( ( buf[i] == 0x09 )	/* TAB */
			      || ( buf[i] >= 0x20 ) )	/* or printable char */
			{
				if( crappeared )	/* ...CR... */
				{
					fclose( sfd );
					return FK_BINARY;
				}
				else if( ++linelen > MAXLINELEN ) /* over MAXLINELEN */
				{
					fclose( sfd );
					return( FK_BINARY );
				}

				if( opt_topc || opt_tounix )
					wbuf[ntowrite++] = buf[i];
			}
			else			/* other control char */
			{
				if( crappeared )	/* ...CR... */
				{
					fclose( sfd );
					return FK_BINARY;
				}
				else if( ++linelen > MAXLINELEN )
						/* over MAXLINELEN */
				{
					fclose( sfd );
					return( FK_BINARY );
				}
				fkind |= FK_CONTROL;

				if( opt_topc || opt_tounix )
					wbuf[ntowrite++] = buf[i];
			}
		}

		if( ntowrite )
		{
			if( !tfd )
			{
				tfd = fopen( tmppath, "wb" );
				if( tfd == (FILE *)0 ) {
					printf(
					"\nTemporary file (%s) create error !\n",
						tmppath );
					return( FK_ERR );
				}
			}
			if( (int)fwrite( wbuf, ntowrite, 1, tfd ) < 1 ) {
				printf( "%s ---> tmp file write error !\n",
					tmppath );
				fclose( tfd );
				return( FK_ERR );
			}
			if( nread != ntowrite )
				fkind |= FK_CONVERTED;
		}

	}

	fclose( sfd );
	if( tfd )	fclose( tfd );

	if( !nblock )	/* no data in file */
		return( FK_ZEROSIZE );
	else if( crappeared )	/* ...CR<EOF> */
		return( FK_BINARY );

	if( fkind & FK_CONVERTED )
	{
		unlink( fpath );
		rename( tmppath, fpath );
		if( opt_remaintime )
		{
			utimes.actime = statbuf.st_atime;
			utimes.modtime = statbuf.st_mtime;
#ifdef WIN32
			_utime( fpath, &utimes );
#else
			utime( fpath, &utimes );
#endif
		}
	}

	return( fkind );
}

#ifndef WIN32
/* if file then return 1, else (directory) then return 0 */
int
#if	defined( __CB_STDC__ )
chkiffile( char *fpath )
#else
chkiffile( fpath )
char	*fpath;
#endif
{
struct	stat	statbuf;

	stat( fpath, &statbuf );
	if( ( statbuf.st_mode & 0xF000 ) == S_IFDIR ) return(0);
	else	return(1);
}
#endif

#ifndef WIN32
/* 980428 bug patch : to avoid source-file which was already created by
	shell by redirection cmd
	ex) fchk *.c > kkk.c then kkk.c may have been already created and
	    included in argv(*.c) list */
int
#if	defined( __CB_STDC__ )
chkifredirfile( char *fpath )
#else
chkifredirfile( fpath )
char	*fpath;
#endif
{
static	struct	stat	stdout_statbuf = {0};
	struct	stat	statbuf;

	if( !stdout_statbuf.st_ino )
		fstat( fileno(stdout), &stdout_statbuf );

	stat( fpath, &statbuf );
	if( statbuf.st_ino == stdout_statbuf.st_ino ) {
		return(1);
	}
	else	return(0);
}
#endif
/*----------------------------------------------------------------------*/
/* get base filename ptr */
/*----------------------------------------------------------------------*/
char	*
#if	defined( __CB_STDC__ )
getbasename( char *fpath )
#else
getbasename( fpath )
char	*fpath;
#endif
{
	register	i;

	for( i=strlen(fpath); i>=0; i-- ) {
#ifdef	WIN32
		if( fpath[i] == '\\' || fpath[i] == ':' )
			return( (char *)( fpath+i+1 ) );
#else
		if( fpath[i] == '/' ) return( (char *)( fpath+i+1 ) );
#endif
	}
	return( fpath );
}

/*----------------------------------------------------------------------*/
/* add filepath to table to avoid duplicated filelist input */
/*----------------------------------------------------------------------*/
struct	SFLIST {
	char	fpath[255];
	struct	SFLIST *next;
} * sfiles;

int
#if	defined( __CB_STDC__ )
sfiles_add( char *fpath )
#else
sfiles_add( fpath )
char	*fpath;
#endif
{
	struct	SFLIST	*sfl;

	if( sfiles == (struct SFLIST *) 0 ) {
		sfiles = (struct SFLIST *)malloc( sizeof( *sfiles ) );
		if( sfiles == (struct SFLIST *)0 )
			return( -1 );		/* ERR */
		strcpy( sfiles->fpath, fpath );
		sfiles->next = (struct SFLIST *)0;
		return(0);		/* OK */
	}
	else {
		sfl = sfiles;
		for(;;) {
			if( !strcmp( sfl->fpath, fpath ) )	/* ALREADY EXIST */
				return(1);
			else if( sfl->next == (struct SFLIST *)0 )
				break;
			else
				sfl = sfl->next;
		}

		sfl->next = (struct SFLIST *)malloc( sizeof( *sfiles ) );
		if( sfl->next == (struct SFLIST *)0 )
			return( -1 );		/* ERR */
		sfl = sfl->next;
		strcpy( sfl->fpath, fpath );
		sfl->next = (struct SFLIST *)0;
		return(0);		/* OK */
	}
}

/* init sfiles table */
void
sfiles_init()
{
	sfiles = (struct SFLIST *)0;
}

/* free sfiles table */
void
sfiles_free()
{
	struct	SFLIST	*sfl;
	struct	SFLIST	*sfltmp;


	for(sfl = sfiles;;)
	{
		if( sfl == (struct SFLIST *)0 )
			break;
		sfltmp = sfl;
		sfl = sfl->next;
		free( sfltmp );
	}

	sfiles = (struct SFLIST *)0;
}

/*----------------------------------------------------------------------*/
