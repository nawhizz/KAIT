
#define dprintf if(0)printf

/* file combination utility */
/*	usage : fcom <option> file1 file2 file3 ... */
/* Each files will be desribed by "+++filepath" */

#include	<string.h>
#include	<stdio.h>
#include	"cbuni.h"

#ifdef		WIN32
#include	<io.h>
#include	<fcntl.h>
#define 	R_OK	04
#else
#include	<unistd.h>
#endif

#define BUFSIZE 64*1024

/*----------------------------------------------------------------------*/
/* extern variables */
/*----------------------------------------------------------------------*/

char	spath[255] = "";	/* source file path */
char	dpath[255] = "";	/* each element file path */
FILE	*sfd = (FILE *)0;
FILE	*dfd = (FILE *)0;
char	buf[BUFSIZE+1]; 	/* read line buffer */
int	narg = 0;		/* no of arguments */
char	**argvptr;

int	noption = 0;		/* no of options */
char	opt_ignoredirectory=0;	/* ignore directory options ON */
char	opt_appendtofile=0;	/* append files into output file */
char	opt_outputtofile=0;	/* output files into output file */
char	opt_outputtostdout=1;	/* output files into stdout */

int	nfile = 0;
struct	SFLIST {
	char	fpath[255];
	struct	SFLIST *next;
} * sfiles = {0};

/*----------------------------------------------------------------------*/
/* function declaration */
/*----------------------------------------------------------------------*/
char	* getbasename CBD2(( char *fpath ));
void	prtcommand();
int	docombine();
#ifndef WIN32
int	chkifredirfile CBD2(( char *fpath ));
int	chkiffile CBD2(( char *fpath ));
#endif
int	sfiles_add CBD2(( char *fpath ));
void	sfiles_free();

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

	narg = argc;

	for( i=0; i<argc; i++ ) {
		if( argv[i][0] == '-' ) {
			switch( argv[i][1] ) {
				case 'i' :
					noption ++;
					opt_ignoredirectory = 1;
					break;
				case 'a' :
					if( argc <= i+1 ) {
					    fprintf( stderr, "\n option: -a " );
					    fprintf( stderr,
						"filepath-to-append\n" );
					    prtcommand();
					    return(1);
					}
					noption += 2;
					opt_appendtofile = 1;
					opt_outputtostdout = 0;
					strcpy( dpath, argv[++i] );
					break;
				case 'o' :
					if( argc <= i+1 ) {
					    fprintf( stderr, "\n option: -o " );
					    fprintf( stderr,
						"output filepath\n" );
					    prtcommand();
					    return(1);
					}
					noption += 2;
					opt_outputtofile = 1;
					opt_outputtostdout = 0;
					strcpy( dpath, argv[++i] );
					break;
				default  :
					fprintf( stderr,
						"\nInvalid Option %2.2s\n",
						argv[i] );
					prtcommand();
					return(1);
			}
		}
	}

	if( argc - noption < 2 ) {
		prtcommand();
		return(1);
	}

	nfile = argc - noption - 1;
	argvptr = argv;

	if( opt_appendtofile ) {
		if( access( dpath, R_OK ) != 0 ) {
			fprintf( stderr,
				"\n%s file not exist. will be created...\n",
				dpath );
		}
		if( ( dfd = fopen( dpath, "ab" ) ) == ( FILE * )0 ) {
			fprintf( stderr, "File Open Error : %s\n", dpath );
			return(1);
		}
	} else if( opt_outputtofile ) {
		if( access( dpath, R_OK ) == 0 ) {
			fprintf( stderr,
				"\n%s file already exist. truncated...\n",
				dpath );
		}
		if( ( dfd = fopen( dpath, "wb" ) ) == ( FILE * )0 ) {
			fprintf( stderr, "File create Error : %s\n", dpath );
			return(1);
		}
	}
	else {	/* opt_outputtostdout */
		dfd = (FILE *)stdout;
#ifdef	WIN32
		_setmode( _fileno(dfd), _O_BINARY );
#endif
	}

	fprintf( stderr, "\nAdding files to < %s > .....\n\n", dpath );
	if( opt_ignoredirectory  )
		fprintf( stderr,
			"- ignoring source directory...\n\n");

	return( docombine() );

}

void
prtcommand()
{
fprintf( stderr,"\n" );
fprintf( stderr,"   +-------------------------------------------------+\n" );
fprintf( stderr,"   |   Text File Combine Utility                     |\n" );
fprintf( stderr,"   |-------------------------------------------------|\n" );
fprintf( stderr,"   | Usage : fcom <options> file1 file2 ...          |\n" );
fprintf( stderr,"   |     <options>                                   |\n" );
fprintf( stderr,"   |       -i : ignore directory in file decript     |\n" );
fprintf( stderr,"   |       -o outfpath : output files into outfpath  |\n" );
fprintf( stderr,"   |       -a outfpath : append files into outfpath  |\n" );
fprintf( stderr,"   | Each files will be desribed \"+++filepath\"       |\n" );
fprintf( stderr,"   |  at head of each contents.                      |\n" );
fprintf( stderr,"   |     by S.T.Woo.  HYSYS. 1995.3                  |\n" );
fprintf( stderr,"   |     updated by S.T.Woo.  HYSYS. 1998.5          |\n" );
fprintf( stderr,"   |     V1.1                                        |\n" );
fprintf( stderr,"   +-------------------------------------------------+\n" );
fprintf( stderr,"\n" );
}

int
docombine()
{
	int	nread, nwrite;
	int	i;
	int	errexit = 0;
	int	endbylf=0;		/* source file ends with LF(oa) */

	/* ok files */
	int	nokfile = 0;
	int	nlfplusfile=0;
	/* skip files normally */
	int	ndirfile=0;
	int	nsamefile=0;
	/* skip files abnormally */
	int	nzerofile=0;
	int	nerrfile=0;
	int	nbinaryfile=0;
	int	npppfile=0;

	char	tbuf[300];	/* +++filepath */

	/* loop-1 : loop for args */
    for( i=1+noption, nfile=0; i<narg; i++ ) {

#ifdef	WIN32
    int argsts; 	/* 0=startof arg, 1=nextof arg, -1=endof arg */
	char	dirpath[255];
	int	j;
	HANDLE	hFind = INVALID_HANDLE_VALUE;
	WIN32_FIND_DATA w32fd;

	/* loop-2 : loop for files : WIN32 only to consider wild char *,? */
    for( argsts=0 ; argsts>=0 ; ) {

		if( !argsts ) { /* FIRST */
			/* get directory path */
			for( j=strlen(argvptr[i])-1; j>=0; j-- ) {
				if( argvptr[i][j] == '\\' || argvptr[i][j] == ':' )
					break;
			}
			if( j >= 0 ) {
					strncpy( dirpath, argvptr[i], j+1 );
					dirpath[j+1] = '\0';
			}
			else		dirpath[0] = '\0';

			hFind = FindFirstFile( argvptr[i], &w32fd );
			if( hFind == INVALID_HANDLE_VALUE ) {	/* ERROR */
				fprintf( stderr, "%s", argvptr[i] );
				fprintf( stderr, " -> Invalid path(no such file)!\n" );
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
		strcpy( spath, argvptr[i] );
#endif

		switch( sfiles_add( spath ) ) {
			case -1 :	/* ERR */
				fprintf( stderr, "%s", spath );
				fprintf( stderr, " -> Insufficient memory !\n" );
				errexit = 1;	/* stop fcom */
				break;
			case 0	:	/* OK */
				break;
			case 1	:	/* ALREAY EXIST */
				fprintf( stderr, "%s", spath );
				fprintf( stderr, " -> duplicated.(alreay combined)\n");
				continue;
		}

		if( errexit ) break;
		nfile++;

		/* skip if file alreay combined by previous args */
		/* - to avoid duplication (ex) fcom aaa.c *.c => aaa.c aaa.c b.c ... */

#ifdef	WIN32
		if( w32fd.dwFileAttributes == FILE_ATTRIBUTE_DIRECTORY ) {
#else
		if( !chkiffile( spath ) ) {
#endif
			fprintf( stderr, "%s", spath );
			fprintf( stderr, " -> directory. skipped....\n" );
			ndirfile++;
			continue;
		}
#ifndef WIN32
		if( chkifredirfile( spath ) ) {
			/*
			fprintf( stderr, "%s", spath );
			fprintf( stderr, " -> same as output. skipped....\n" );
			*/
			nsamefile++;
			continue;
		}
#endif
		if( ( sfd = fopen( spath, "rb" ) ) == (FILE *)0 ) {
			fprintf( stderr, "%s", spath );
			fprintf( stderr, " -> can't open. skipped....\n" );
			nerrfile++;
			continue;
		}


		fprintf( stderr, "%s", spath );
		fflush( stderr );

		/* loop-3 : loop to EOF */
		for( nwrite=0, endbylf=0; ; ) {

			nread = (int)fread( buf, 1, BUFSIZE, sfd );

			if( nread <= 0	) {		/* EOF */
				if( nwrite > 0 )	/* file size not zero*/
				{
					if( !endbylf) { /* not term. by LF at EOF */
						fwrite( "\n", 1, 1, dfd );
						nlfplusfile++;
						fprintf( stderr, " -> LF added at EOF\n" );
						fclose( sfd );
						sfd = 0;
					} else {	/* term. by LF at EOF */
						nokfile++;
						fprintf( stderr, "\n" );
						fclose( sfd );
						sfd = 0;
					}
				}
				else		/* zero size file : skip */
				{
					fclose( sfd );
					sfd = 0;
					fprintf( stderr, " -> no data. skipped...\n" );
					nzerofile++;
				}
				break;
			}

			/* now, data was read */
			buf[nread] = '\0';
			if( nwrite == 0 )	/* if start of file */
			{
				/* if file start wiht +++filename then skip it */
				/* to avoid recursive fcom or */
				/* to skip redirection file itself(WIN32 only) */
				if( (int)strlen(buf) > 3 && !memcmp( buf, "+++", 3 ) )
				{
					fclose( sfd );
					sfd = 0;
					fprintf( stderr, " -> start with +++. skipped...\n" );
					npppfile++;
					break;
				}
				else if( (int)strlen( buf ) < nread )	/* include NULL */
				{
					fprintf( stderr,
						" -> binary. skipped....\n" );
					fclose( sfd );	/* ignore this file */
					nbinaryfile++;
					sfd = 0;
					break;
				}
				/* this strstr chk may decrease performance !!! */
				else if( strstr( buf, "\n+++" ) )	/* +++ at line head */
				{
					fprintf( stderr,
						" -> contains +++ at line head. skipped....\n" );
					fclose( sfd );	/* ignore this file */
					npppfile++;
					sfd = 0;
					break;
				}

				/* put +++sfpath before write contents */
				if( opt_ignoredirectory )
					sprintf( tbuf, "+++%s", getbasename( spath ) );
				else
					sprintf( tbuf, "+++%s", spath );
				if( (int)fprintf( dfd, "%s\n", tbuf ) < 0  ) {
					fprintf( stderr, " -> write error !\n");
					errexit = 1;
					break;
				}
			}
			else
			{
				if( (int)strlen( buf ) < nread )	/* include NULL */
				{
					fprintf( stderr,
						" -> include binary value. error !\n" );
					errexit = 1;	/* stop fcom */
					break;
				}
				/* this strstr chk may decrease performance !!! */
				else if( strstr( buf, "\n+++" ) )	/* +++ at line head */
				{
					fprintf( stderr,
						" -> contains +++ at line head. error !\n" );
					errexit = 1;	/* stop fcom */
					break;
				}
			}

			/* write contents */
			if( (int)fwrite( buf, nread, 1, dfd ) < 1  ) {
				fprintf( stderr, " -> write error !\n" );
				errexit = 1;
				break;
			}
				/* to adjust not endding with LF at EOF */
			if( buf[nread-1] == '\n' ) endbylf = 1;
			nwrite += nread;

		}	/* end of loop-3 : loop to EOF */

		if( errexit ) break;

#ifdef	WIN32
	}		/* end of loop-2 : loop for files of same wild char *,? WIN32 */
	if( hFind != INVALID_HANDLE_VALUE ) FindClose( hFind );
	if( errexit ) break;
#endif

	}		/* end of loop-1 : loop for args */

    fclose( dfd );
    if( sfd ) fclose( sfd );

	/* free file path list table */
    sfiles_free();

    if( errexit ) {
		fprintf( stderr, "\n Abnormally terminated !\n" );
		return(1);
    }

    if( !( nzerofile + nerrfile + nbinaryfile + npppfile ) ) {
		fprintf( stderr, "\n< %d > files are combined",
			nfile - ndirfile - nsamefile );
	}
    else {
		fprintf( stderr, "\n< %d > of < %d > files are combined",
			nokfile+nlfplusfile, nfile - ndirfile - nsamefile );
	}
	if( opt_outputtofile )	fprintf( stderr, " into < %s >.\n\n", dpath );
	else					fprintf( stderr, ".\n\n", dpath );

	if( nokfile )
		fprintf( stderr, "\t%d files are normally combined\n", nokfile );
	if( nlfplusfile )
		fprintf( stderr, "\t%d files are appended LF at EOF.\n",
			nlfplusfile );
	if( nzerofile + npppfile + nerrfile + nbinaryfile ) {
		fprintf( stderr, "\n" );
		fprintf( stderr, "\t%d files are skipped as follows.\n",
			nzerofile + npppfile + nerrfile + nbinaryfile );
	}

	if( nzerofile )
		fprintf( stderr, "\t\t%d files are zero size.\n",
			nzerofile );
	if( npppfile )
		fprintf( stderr, "\t\t%d files start with +++.\n",
			npppfile );
	if( nerrfile )
		fprintf( stderr, "\t\t%d files can't open.\n",
			nerrfile );
	if( nbinaryfile )
		fprintf( stderr, "\t\t%d files are binary.\n",
			nbinaryfile );

    return(0);
}

#ifndef WIN32
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<stdio.h>
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
	if( statbuf.st_mode >= (long)0x8000 ) return(1);
	else	return(0);
}
#endif

#ifndef WIN32
/* 980428 bug patch : to avoid source-file which was already created by
	shell by redirection cmd
	ex) fcom *.c > kkk.c then kkk.c may have been already created and
	    included in argv(*.c) list */
int
#if	defined( __CB_STDC__ )
chkifredirfile( char *fpath )
#else
chkifredirfile( fpath )
char	*fpath;
#endif
{
static	struct	stat	dfd_statbuf = {0};
	struct	stat	statbuf;

	if( !dfd_statbuf.st_ino )
		fstat( fileno(dfd), &dfd_statbuf );

	stat( fpath, &statbuf );
	if( statbuf.st_ino == dfd_statbuf.st_ino ) {
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

/*----------------------------------------------------------------------*/
/* free memory for sfiles table */
/*----------------------------------------------------------------------*/
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
