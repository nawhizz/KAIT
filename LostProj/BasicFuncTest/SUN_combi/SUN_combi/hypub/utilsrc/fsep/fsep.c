
/* separate file to files */
/*	usage : fsep <option> srcfilepath <destdirectory>*/
/* Each files should be separated by \n+++filepath */

#include	<string.h>
#include	<stdio.h>
#include	"cbuni.h"

#ifdef	WIN32
#include	<io.h>
#define 	R_OK	04
#define 	X_OK	04
#else
#include	<unistd.h>
#endif

#define BUFSIZE 8192

char	spath[255];		/* source file path */
char	dpath[255];		/* each element file path */
char	tmppath[]= "_fsep.tmp"; /* temporary output file path */

FILE	*sfd = (FILE *)0;	/* source file FD */
FILE	*dfd = (FILE *)0;	/* each file FD - temporary if org exist */
int		nlinewrite=0;	/* no of lines written into current file */
FILE	*orgfd = (FILE *)0;	/* each file FD - original */
char	buf[BUFSIZE];		/* read line buffer */
char	buf_org[BUFSIZE];	/* read line buffer - original file */
char	destdir[255];		/* output directory */
int	noption = 0;		/* no of options */

int	nfile_tot = 0;		/* no of files separated */
int	nfile_changed = 0;	/* no of files changed */
int	nfile_unchanged = 0;	/* no of files unchanged */
int	nfile_new = 0;		/* no of files new */
int	nfile_error = 0;	/* no of files error */
int	error_occurred = 0;

int	nlines = 0;		/* no of lines of each file */
int	nlines_tot = 0; 	/* no of lines of total file */
int	nbytes = 0;		/* no of bytes of each file */
int	nbytes_tot = 0; 	/* no of bytes of total file */

int	changed=0;		/* if file contents changed then = 1 */
int	orgexist=0;		/* if original file exist then = 1 */

char	opt_ignoredirectory=0;	/* ignore directory options ON */
char	opt_backuporg=0;	/* backup original file by <fname.bak> */
char	opt_listall = 0;	/* list all files */
char	opt_viewonly = 0;	/* View contents only */

void	prt_command();
int		do_separation();
int		open_tmpfile();
int		open_orgfile();
int		open_destfile();
void	close_all();
void	prt_result();
int		endof_curelement();
char *	back_orgfile();
int		set_dpath();
void	view_listonly();
void	prt_summary();
void	disp_element();
#ifndef WIN32
int		chkiffile CBD2(( char *fpath ));
#endif
char	* getbasename CBD2(( char *fpath ));

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

	for( i=0; i<argc; i++ ) {
		if( argv[i][0] == '-' ) {
			switch( argv[i][1] ) {
				case 'i' :
					noption ++;
					opt_ignoredirectory = 1;
					break;
				case 'b' :
					noption ++;
					opt_backuporg = 1;
					break;
				case 'l' :
					noption ++;
					opt_listall = 1;
					break;
				case 'v' :
					noption ++;
					opt_viewonly = 1;
					break;
				default  :
					printf( "\nInvalid option %2.2s\n",
						argv[i] );
					prt_command();
					return(1);
			}
		}
	}

	if( argc - noption < 2 ) {
		prt_command();
		return(1);
	}

	strcpy( spath, argv[noption+1] );

	if( access( spath, R_OK ) < 0 ) {
		printf( "\nNo such file or cannot read : %s\n", spath );
		return(1);
	}

	if( argc - noption >= 3 ) {
		strcpy( destdir, argv[2+noption] );
	}
	else	destdir[0] = 0;

	if( destdir[0] ) {
		if( access( destdir, R_OK ) < 0 ) {
			printf( "\nNo such directory or cannot access : %s\n",
				destdir );
			return(1);
		}
		if( access( destdir, X_OK ) < 0 ) {
			printf( "\nCannot access directory : %s\n", destdir );
			return(1);
		}
	}

	if( ( sfd = fopen( spath, "rb" ) ) == ( FILE * )0 ) {
		printf( "\nFile Open Error : %s\n", spath );
		return(1);
	}

	if( opt_viewonly ) {
		view_listonly();
		close_all();
		prt_summary();
		return(0);
	}

/*
	if( destdir[0] )
		printf( "\nSeparating < %s > file into directory < %s > ...\n",
			spath, destdir );
	else
		printf( "\nSeparating < %s > file into current directory ...\n",
			spath );

	if( opt_ignoredirectory )
		printf( "( Ignoring directory define in file )\n" );
*/

	do_separation();

	close_all();

	prt_result();

	return(0);
}

void
prt_command()
{
	printf( "\n" );
	printf( "     +------------------------------------------------+\n" );
	printf( "     |   Text File Separation Utility                 |\n" );
	printf( "     |   ( no changed file will not be updated. )     |\n" );
	printf( "     |------------------------------------------------|\n" );
	printf( "     |   Usage : fsep <options> fpath <destdir>       |\n" );
	printf( "     |       <options>                                |\n" );
	printf( "     |          -i : ignore directory in file decript |\n" );
	printf( "     |          -b : backup file by *.bak if exist    |\n" );
	printf( "     |          -l : display full list                |\n" );
	printf( "     |          -v : View contents only               |\n" );
	printf( "     |       <destdir> : out directory( default = . ) |\n" );
	printf( "     | Each files to be desribed by 3 plus('+')s      |\n" );
	printf( "     |  followed by filepath at head of each contents.|\n" );
	printf( "     |     by S.T.Woo.  HYSYS. 1995.3                 |\n" );
	printf( "     |     V1.0                                       |\n" );
	printf( "     | Each files will be desribed \"+++filepath\"      |\n" );
	printf( "     |  at head of each contents.                     |\n" );
	printf( "     |     by S.T.Woo.  HYSYS. 1995.3                 |\n" );
	printf( "     |     updated by S.T.Woo.  HYSYS. 1998.5         |\n" );
	printf( "     +------------------------------------------------+\n" );
	printf( "\n" );
}

int
do_separation()
{
	printf( "\n" );

	while( !feof( sfd ) ) {

		if( fgets( buf, BUFSIZE, sfd ) == 0 ) {
			break;
		}

		/* if new element file appeared */
		if( !memcmp( buf, "+++", 3 ) ) {
			if( dfd ) {
				if( endof_curelement() < 0 ) {
					error_occurred = 1;
					return( -1 );
				}
			}

			/* next element start */
			orgexist = 0;
			changed = 0;
			orgfd = (FILE *)0;
			nlinewrite=0;

			if( set_dpath() < 0 ) {
				error_occurred = 1;
				return( -1 );
			}

			/* check if file already exist */
			if( access( dpath, R_OK ) == 0 ) orgexist = 1;
			else	{
				orgexist = 0;
				nfile_new++;
			}

			/* open output(tmp) file */
			if( orgexist ) {
				if( open_tmpfile() < 0 ) {
					error_occurred = 1;
					return( -1 );
				}
				if( open_orgfile() < 0 ) {
					error_occurred = 1;
					return( -1 );
				}
			} else {
				if( open_destfile() < 0 ) {
					error_occurred = 1;
					return( -1 );
				}
			}

			nfile_tot++;
			continue;
		}
		else {
			if( dfd == (FILE *)0 ) {	/* for first element */
				printf( "'+++filename' not found !\n" );
				break;
			}
			if( (int)fwrite( buf, (int)strlen(buf), 1, dfd ) < 1 ) {
				printf( "%s ---> file write error !\n", dpath );
				break;
			}
			nlinewrite++;
			if( orgexist && !changed ) {
				if( fgets( buf_org, BUFSIZE, orgfd ) == 0 ) {
					changed = 1;
				}
				else if( strcmp( buf, buf_org ) ) {
					changed = 1;
				}
			}
		}
	}

	if( dfd ) {
		if( endof_curelement() < 0 ) {
			error_occurred = 1;
			return( -1 );
		}
	}

	return( 0 );
}

int
open_tmpfile()
{
	dfd = fopen( tmppath, "wb" );
	if( dfd == (FILE *)0 ) {
		printf( "\nTemporary file (%s) create error !\n", tmppath );
		return( -1 );
	}
	return( 0 );
}

int
open_orgfile()
{
	orgfd = fopen( dpath, "rb" );
	if( orgfd == (FILE *)0 ) {
		printf( "%s ---> Original file open error !\n", dpath );
		return( -1 );
	}
	return( 0 );
}

int
open_destfile()
{
	dfd = fopen( dpath, "wb" );
	if( dfd == (FILE *)0 ) {
		printf( "%s ---> file create error !\n", dpath );
		return( -1 );
	}
	return( 0 );
}

void
close_all()
{
	if( sfd ) fclose( sfd );
	if( dfd ) fclose( dfd );
	if( orgfd ) fclose( orgfd );
	if( access( tmppath, R_OK ) == 0 ) unlink( tmppath );
}

void
prt_result()
{
	if( error_occurred )
		printf( "\nTerminated Abnormally.\n" );

	if( nfile_tot == nfile_unchanged ) {
		printf( "No files changed. ( total %d files )\n\n",
			nfile_tot );
		return;
	}

/*
	printf( "\n< %s > file separation result\n\n", spath );
*/
	printf ( "\n" );
	printf( "total      = %4d  files.\n", nfile_tot );

	if( nfile_changed )
		printf( "changed    = %4d  files.\n", nfile_changed );
	if( nfile_unchanged )
		printf( "unchanged  = %4d  files.\n", nfile_unchanged );
	if( nfile_new )
		printf( "new        = %4d  files.\n", nfile_new );
	if( nfile_error )
		printf( "error      = %4d  files.\n", nfile_error );

	printf( "\n" );
}

/* end of current file */
/* close, remove tmp, backup original for current file */
int
endof_curelement()
{
	char	*backfpath;

	fclose( dfd );
	dfd = (FILE *)0;

	if( !orgexist ) {
		printf( "%s  -> created.\n", dpath );
		return( 0 );
	}

	/* check if orginal file has more contents */
	if( !changed ) {
		if( fgets( buf_org, BUFSIZE, orgfd ) != 0 )
		changed = 1;
	}

	fclose( orgfd );
	orgfd = (FILE *)0;

	if( changed ) {
		if( nlinewrite == 0 ) { /* if output is zero file */
			if( ( backfpath = back_orgfile() ) ) {
				nfile_changed ++;
				rename( tmppath, dpath );
		printf( "%s  -> updated to NULL file. orginal saved into %s\n",
				dpath, backfpath );
			}
			else {
				nfile_error ++;
			}
		}
		else if( opt_backuporg ) {
			if( ( backfpath = back_orgfile() ) ) {
				nfile_changed ++;
				rename( tmppath, dpath );
				printf( "%s  -> updated. orginal saved into %s\n",
					dpath, backfpath );
			}
			else {
				nfile_error ++;
			}
		} else {
			nfile_changed ++;
			unlink( dpath );
			rename( tmppath, dpath );
			printf( "%s  -> updated.\n", dpath );
		}
	} else {
		nfile_unchanged ++;
		if( opt_listall )
			printf( "%s  -> no change.\n", dpath );
	}

	return( 0 );
}

char *
back_orgfile()
{
	int	i;
static	char	bpath[255];		/* each element backup file path *.bak%d */

	for( i=0; i<99; i++ ) {
		if( i==0 )	sprintf( bpath, "%s.bak", dpath );
		else		sprintf( bpath, "%s.bak%d", dpath, i );
		if( access( bpath, R_OK ) == 0 ) continue;
		rename( dpath, bpath );
		return( bpath );
	}
	printf( "%s -> Error ! ( Backup files %s.bak?? exist )\n", dpath, bpath );
	return( (char *)0 );
}

int
set_dpath()
{
    char	dpath_desc[255];
    char	eachfpath[255];

	/* set element file path */
	strcpy( dpath, destdir );
	if( (int)strlen( dpath ) ) {
#ifdef	WIN32
		if( dpath[ (int)strlen( dpath ) - 1 ] != ':' &&
			dpath[ (int)strlen( dpath ) - 1 ] != '\\' )
			strcat( dpath, "\\" );
#else
		if( dpath[ (int)strlen( dpath ) - 1 ] != '/' )
			strcat( dpath, "/" );
#endif
	}
	sscanf( &buf[3], "%s", eachfpath );
	if( opt_ignoredirectory )
		strcpy( dpath_desc, getbasename( eachfpath ) );
	else if( destdir[0] ) { /* destdir exist */
		if( (int)strcmp( eachfpath, getbasename( eachfpath ) ) ) {
			printf( "%s => directory define err !\n", eachfpath );
			printf( "Ignore directory by -i option please.\n" );
			return( -1 );
		}
		else	strcpy( dpath_desc, eachfpath );
	}
	else
		strcpy( dpath_desc, eachfpath );

	strcat( dpath, dpath_desc );
	return( 0 );
}

void
view_listonly()
{
	printf( "\n" );

	while( !feof( sfd ) ) {

		if( fgets( buf, BUFSIZE, sfd ) == 0 ) {
			break;
		}

		/* if new element file appeared */
		if( !memcmp( buf, "+++", 3 ) ) {
			if( nfile_tot )
				disp_element();
			set_dpath();
			nfile_tot++;
			nlines = 0;
			nbytes = 0;
		}
		else {
			if( nfile_tot == 0 ) {	/* for first element */
				printf( "'+++filename' not found !\n" );
				break;
			}
			nlines ++;
			nlines_tot ++;
			nbytes += strlen( buf );
			nbytes_tot += strlen( buf );
		}
	}

	if( nfile_tot ) {
		disp_element();
	}
}

void
prt_summary()
{
	if( opt_listall ) printf( "\n" );
	printf( "%d files in < %s > file.\n\n", nfile_tot, spath );
	printf( "total          %6d lines  %7d bytes\n\n",
		nlines_tot, nbytes_tot );
}

void
disp_element()
{
	if( opt_listall )
		printf( "%s     %6d lines  %7d bytes\n",
			dpath, nlines, nbytes );
}

#ifndef WIN32
#include	<sys/types.h>
#include	<sys/stat.h>

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

/*----------------------------------------------------------------------*/
/* get base filename ptr */
/*----------------------------------------------------------------------*/
char	*
#if	defined( _CB_STDC__ )
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
