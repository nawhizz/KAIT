/* fstr.c */
/*----------------------------------------------------------------------*
| Descrip.	File String Modification Utility			|
|									|
| Project	HYCASE							|
| System	UTIL							|
|									|
| By		stwoo							|
| Date		96.3.9							|
|									|
| 2000.12.15. ksh. digital server porting 반영				|
|-----------------------------------------------------------------------|
|									|
| Usage		fstr <options> files ...				|
|									|
|	files ...	filenames to apply string modification		|
|			wild character may be used (*,?)		|
|									|
|	<options>							|
|									|
|	-h command help and usage in details				|
|	-f specfile		: modify as described in specfile	|
|		spec file conventions					|
|		#.....        : comments after '#'			|
|		fromstr	tostr : see -s option				|
|									|
|	-tc 			: assume file is a 'C' source (default) |
|	-tb 			: assume file is a 'COBOL' source       |
|	-tx 			: assume file is a general text file    |
|	-l 			: list change history                   |
|	-p 			: dislay change spec information 	|
|	-b ext	                : backup file to <filename>.<ext>       |
|	-s fromstr tostr	: substitute all fromstr with tostr	|
|	   -s option may be multiple defined ( in future )		|
|	   fromstr to be continuous string 				|
|	    if -tc option, to start by only alpha-numeric or '_'s       |
|	    if -tb option, to start by only alpha-numeric and           |
                           expect start char.,                          |
                           all char made by alpha-numeric or '_', '-'s  |
|	   tostr to be continuous string with any characters            |
|	     '@'s in tostr will be changed by ' 's ( spaces )	        |
|	     '#' in tostr to be described as '\#'			|
|									|
|	--specfile example--						|
|	    # comments							|
|	    :CHG			# means change string 		|
|	    ABCD	ZZZZZ		# "ABCD" -> "ZZZZ" 		|
|	    PM_MAPREC	smapFORM	# "PM_MAPREC" -> "smapFORM" 	|
|									|
|	    :TOP							|
|		-- %FNAME% -		-         			|
|									|
|		Project : .................				|
|		System	: .................				|
|									|
|		By 	: .................				|
|		Date	: YYYY/MM/DD					|
|									|
|	    :BTM							|
|		-- end of %FNAME% ----					|
|									|
|		\#ifndef %UFNAME_%					|
|		\#define %UFNAME_%					|
|		\#endif  						|
|									|
*-----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*  INCLUDE FILES							*/
/*----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<string.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<fcntl.h>

#ifdef	WIN32
# include	<time.h>
# include	<direct.h>
# include	<io.h>
# include	<fcntl.h>
# ifndef		R_OK
#  define 	R_OK	04
# endif
# define		F_OK	00
#else
/* 2000.12.15. digital 추가 */
# if	defined( HYSYS_HP ) || defined( __digital__ )
#  include	<time.h>
# endif
# include	<unistd.h>
# include	<sys/uio.h>
# include	<sys/times.h>
# include	<dirent.h>
# include	<errno.h>
# include	<sys/types.h>
# include	<sys/stat.h>
#endif

#include	"cbuni.h"

/* for Process time report : times() */
#ifdef		DISP_PROCESSTIME
#include	<limits.h>
#endif

/*----------------------------------------------------------------------*/
/*	DEFINE VARIABLES						*/
/*----------------------------------------------------------------------*/

/* command group */
#define	GRP_CHG		1
#define	GRP_TOP		2
#define	GRP_BTM		3

/* commands in specfile */
#define	CMD_CHG		"CHG"		/* change string from->to */
#define	CMD_TOP		"TOP"		/* insert at top of file */
#define	CMD_BTM		"BTM"		/* append at bottom of file */

/*----------------------------------------------------------------------*/
/* TOP/BOTTOM FIELD DESCRIPTION						*/
/*----------------------------------------------------------------------*/
/* top/bottom fields in specfile */
/*
	"%FPATH%"	: filepath as input
			  ex: ../../home/src/fstr.c -> ../../home/src/fstr.c

	"%FNAME%"	: filename ( without directory )
			  ex: ../../home/src/fstr.c -> fstr.c
	"%UFNAME%"	: uppercase filename 
			  ex) ../../home/src/fstr.c -> FSTR.C

	"%FNAME_%"	: filename by changing '.'s to '_'s
			  ex) ../../home/src/fstr.h -> fstr_h
	"%UFNAME_%"	: uppercase filename by changing '.'s to '_'s
			  ex) ../../home/src/fstr.h -> FSTR_H

	"%BFNAME%"	: basefilename ( without directory, ext )
			  ex: ../../home/src/fstr.c -> fstr
	"%UBFNAME%"	: uppercase basefilename ( without directory, ext )
			  ex: ../../home/src/fstr.c.org -> FSTR

	%YYYY%		: year	1996
	%YY%		: year	96
	%MM%		: month	05
	%DD%		: day	31
	%HH%		: hour  15
	%MONTH%		: Jan - Dec
	%DATE8/%	: 96/12/03
	%DATE10/%	: 1996/12/03
	%DATE8.%	: 96.12.03
	%DATE10.%	: 1996.12.03
	%DATE8S%	: 96 12 03
	%DATE10S%	: 1996 12 03

	(example)	%YYYY%년 %MM%월%DD%일
*/

/*----------------------------------------------------------------------*/
/*	DEFINE STRUCTURES						*/
/*----------------------------------------------------------------------*/

/* change string information : linked list */
struct	CHGINF	{
	short	spclineno;		/* line no in spec file, 0=byarg */
	short	fromstrlen;
	short	tostrlen;
	char	*fromstr;		/* from string to change */
	char	*tostr;			/* to string to become */
	char	fromstrendbytext;	/* =0/1,1=fromstr[] ends by text char */
	struct	CHGINF	*next;		/* next linked CHGINF ptr */
};

/* top insert information : linked list */
struct	TOPINF	{
	char	*linestr;		/* line string with %...% fiels */
	struct	TOPINF	*next;		/* next linked TOPINF ptr */
};

/* bottom append information : linked list */
struct	BTMINF	{
	char	*linestr;		/* line string with %...% fiels */
	struct	BTMINF	*next;		/* next linked BTMINF ptr */
};

/* for analyzing file read date buffer into field info */
struct	FLDINF	{
	char	*sptr;			/* start offset of text field */
	int	len;			/* length of text field */
};

#ifndef	WIN32
struct	finfo_frm
{
	int	prelen;
	char	prestr[100];
	int	postlen;
	char	poststr[100];
};
#endif

/*----------------------------------------------------------------------*/
/*	EXTERN DATA							*/
/*----------------------------------------------------------------------*/

/* spec information */
struct	CHGINF	*chginf_start = NULL;	/* start ptr of linked CHGINF */
struct	CHGINF	*chginf_cur = NULL;	/* last(current) ptr of CHGINF */
int	chginf_depth = 0;		/* no of CHGINF */

struct	TOPINF	*topinf_start = NULL;	/* start ptr of linked TOPINF */
struct	TOPINF	*topinf_cur = NULL;	/* last(current) ptr of TOPINF */
int	topinf_depth = 0;		/* no of TOPINF */

struct	BTMINF	*btminf_start = NULL;	/* start ptr of linked BTMINF */
struct	BTMINF	*btminf_cur = NULL;	/* last(current) ptr of BTMINF */
int	btminf_depth = 0;		/* no of BTMINF */

int	nfile_total = 0;		/* no of files input */
int	nfile_valid = 0;		/* files vaild (except directory) */
int	nfile_changed = 0;		/* no of files changed */
int	nfile_unchanged = 0;		/* no of files unchanged */
int	nfile_error = 0;		/* no of files error occurred */
int	nline_changedtotal = 0;		/* total lines changed in all files */

/* argument info */
int	noptarg = 0;			/* no args for options */
int	opt_f = 0;			/* -f spec file */
int	opt_h = 0;			/* -h */
int	opt_tc = 1;			/* -tc */
int	opt_p = 0;			/* -p */
int	opt_l = 0;			/* -l */
int	opt_b = 0;			/* -b fileext */
int	opt_s = 0;			/* -s fromstr tostr */

/* file path */
char	srcfpath[200];		/* each source file path */
char	spcfpath[200];		/* spec file path */
char	tmpfpath[40];		/* temporary output file path */
char	backupext[200];		/* backup file extension */

/* various args */
char	currpath[200];		/* current directory path */
char	fname[40];		/* filename ( without directory ) */
char	ufname[40];		/* uppercase filename */
char	fname_[40];		/* filename by changing '.'s to '_'s */
char	ufname_[40];		/* uppercase filename by chang '.'s to '_'s */
char	bfname[40];		/* basefilename ( without directory, ext ) */
char	ubfname[40];		/* uppercase basefilename */
struct tm	*curtime;	/* current time value */
char	*month_str[ 13 ] = {
	"",
	"Jan", "Feb",
	"Mar", "Apr",
	"May", "Jun",
	"Jul", "Aug",
	"Sep", "Oct",
	"Nov", "Dec"
};

/* file i/o buffer. */
char	rbuf[4096+1];			/* read buffer */
char	dispbuf[4096+1];		/* disp buffer case opt_l = 1 */

struct	FLDINF	fldinf[sizeof(rbuf)/4];	/* fld info of rbuf read */
int	nfld = 0;			/* no of field in rbuf */

int	srclineno;			/* current line no in srcfpath */

/*----------------------------------------------------------------------*/
/* FUNCTION PROTOTYPES */
/*----------------------------------------------------------------------*/
int	read_spcfile();
int	add_chginf CBD2(( char *fromstr, char *tostr, int spclineno ));
int	crosschk_chg CBD2(( struct CHGINF *newitem, int spclineno ));
void	add_topinf CBD2(( char *linestr ));
void	add_btminf CBD2(( char *linestr ));
int	dochange_file();
int	do_top CBD2(( FILE *outfd ));
int	do_btm CBD2(( FILE *outfd ));
int	do_topline CBD2(( FILE *outfd, char *linestr ));
int	get_fldstr CBD2(( char *fldmask, char *outbuf ));
int	do_chgline CBD2(( FILE *outfd ));
int	istextchar CBD2(( int c ));
int	chkiffile CBD2(( char *fpath ));
void	disp_result();
void	freemem();
void	getfname CBD2(( char *fpath, char *outbuf ));
void	getufname CBD2(( char *fpath, char *outbuf ));
void	getfname_ CBD2(( char *fpath, char *outbuf ));
void	getufname_ CBD2(( char *fpath, char *outbuf ));
void	getubfname CBD2(( char *fpath, char *outbuf ));
void	getbfname CBD2(( char *fpath, char *outbuf ));
void	disp_topinf();
void	disp_btminf();
void	disp_chginf();
char	*gettimestr();
void	prt_cmdusage();
void	prt_cmdhelp();
void	prt_samplespec();
void	prt_samplesrc();
void	prt_cmderrhelp();
#ifndef	WIN32
int	sep_dir_file CBD2(( char *fpath, char *path, char *filename ));
int	anal_filename CBD2(( char *filename, struct finfo_frm *fileinfo ));
#endif

/*----------------------------------------------------------------------*/
/*	main() PROCEDURE						*/
/*----------------------------------------------------------------------*/

void
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	time_t		timeval;
	register int	i, errexit = 0;
#ifdef		DISP_PROCESSTIME
	struct	tms	proctime;		/* for process time report */
#endif
#ifndef	WIN32
	register	dirlen, anal_ret, flen, multi_fl;
	DIR		*dp;
	struct	dirent	*dirp;
	char		dirname[256], filename[256];
	struct		finfo_frm	fileinfo;
#endif

	if( argc < 2 )
	{
		prt_cmdusage();
		exit(1);
	}

	for( i=0; i<argc; i++ )
	{
		if( argv[i][0] == '-' )
		{
			switch( argv[i][1] )
			{
			case 't' : 
				switch( argv[i][2] )
				{
				case 'x' :
					opt_tc = 0; break;
				case 'b' :
					opt_tc = 2; break;
				case 'c' :
				default	:
					opt_tc = 1; break;
				}
				noptarg++;
				break;
			case 'h' : 
				noptarg++;
				opt_h = 1;
				break;
			case 'p' : 
				noptarg++;
				opt_p = 1;
				break;
			case 'l' : 
				noptarg++;
				opt_l = 1;
				break;
			case 'b' :
				if( argc <= i+1 )
				{
					printf( "\n option: -b " );
					printf( "backupfileextension\n" );
					prt_cmderrhelp();
					freemem();
					exit(1);
				}
				noptarg += 2;
				opt_b = 1;
				strcpy( backupext, argv[++i] );
				break;
			case 'f' :
				if( argc <= i+1 )
				{
					printf( "\n option: -f " );
					printf( "specfilepath\n" );
					prt_cmderrhelp();
					freemem();
					exit(1);
				}
				noptarg += 2;
				opt_f = 1;
				strcpy( spcfpath, argv[++i] );
				break;
			case 's' :
				if( argc <= i+2 )
				{
					printf( "\n option: -s " );
					printf( "fromstr tostr\n" );
					prt_cmderrhelp();
					freemem();
					exit(1);
				}
				noptarg += 3;
				opt_s = 1;
				if( add_chginf( argv[++i], argv[++i], 0 ) < 0 )
				{
					printf( "\n" );
					freemem();	
					exit(1);
				}
				break;
			default  :
				printf( "\nInvalid Option %2.2s\n", argv[i] );
				prt_cmderrhelp();
				freemem();
				exit(1);
			}
		}
	}

	if( opt_h )
	{
		prt_cmdhelp();
		prt_samplespec();
		freemem();
		exit(0);
	}

	if( !opt_f && !opt_s )
	{
		printf("\n no change method option (-f or -s) not defined!\n" );
		prt_cmderrhelp();
		freemem();
		exit(2);
	}

	if( argc - noptarg < 2 )
	{
		printf("\n files not defined!\n" );
		prt_cmderrhelp();
		freemem();
		exit(3);
	}

	nfile_total = argc - noptarg - 1;

#ifdef		DISP_PROCESSTIME
	printf( "\nStartTime = %s\n", gettimestr() );
#endif

	getcwd( currpath, sizeof currpath );

	if( opt_f )
	{
		printf( "\nAnalyzing %s ...\n", spcfpath );
		if( read_spcfile() < 0 )
		{
			freemem();
			exit(4);
		}
	}

	if( opt_p ) disp_topinf();	/* display top insert info */
	if( opt_p ) disp_chginf();	/* display change string info */
	if( opt_p ) disp_btminf();	/* display btm append info */

	/* get current time */
	time( &timeval );
	curtime = localtime( &timeval );
	curtime->tm_mon++;

	printf( "\nUpdating files.....\n\n" );

#ifdef	WIN32
	sprintf( tmpfpath, "_fstr.%d", GetCurrentProcessId() );
#else
	sprintf( tmpfpath, "_fstr.%d", getpid() );
#endif
	for( i=1+noptarg; i<nfile_total+1+noptarg; i++ )
	{
#ifdef	WIN32
	register	j;
	register	argsts; 	/* 0=startof arg, 1=nextof arg, */
					/* -1=endof arg */
	char		dirpath[256];
	HANDLE		hFind = INVALID_HANDLE_VALUE;
	WIN32_FIND_DATA w32fd;

	/* loop-2 : loop for files : WIN32 only to consider wild char *,? */
	for( argsts = 0; argsts >= 0; )
	{
		if( !argsts )			/* FIRST */
		{
			/* get directory path */
			for( j = strlen( argv[i] ) - 1; j >= 0; j-- )
			{
				if( argv[i][j] == '\\' || argv[i][j] == ':' )
					break;
			}
			if( j >= 0 )
			{
				strncpy( dirpath, argv[i], j + 1 );
				dirpath[j + 1] = '\0';
			}
			else	dirpath[0] = '\0';

			hFind = FindFirstFile( argv[i], &w32fd );
			if( hFind == INVALID_HANDLE_VALUE )
			{
				printf( "%s: Invalid path(no such file)!\n", argv[i] );
				argsts = -1;
				break;
			}
			argsts = 1;
			/* skip . and .. */
			if( !strcmp( w32fd.cFileName, "." ) || !strcmp( w32fd.cFileName, ".." ) )
				continue;
		}
		else
		{	/* NEXT */
			if( !FindNextFile( hFind, &w32fd ) )	/*NO MORE*/
			{
				argsts = -1;
				break;
			}
			/* skip . and .. */
			if( !strcmp( w32fd.cFileName, "." ) || !strcmp( w32fd.cFileName, ".." ) )
				continue;
		}
		strcpy( srcfpath, dirpath );
		strcat( srcfpath, w32fd.cFileName );
#else
	sep_dir_file( argv[i], dirname, filename );
	if( ( anal_ret = anal_filename( filename, &fileinfo ) ) )
	{
		dirlen = (int)strlen( dirname );
		if( ( dp = opendir( dirname ) ) == NULL )
		{
			printf( "opendir error. [%d]\n", errno );
			errexit = 1;
			break;;
		}
	}

	for( multi_fl = 1; multi_fl; )
	{
		if( anal_ret )
		{
			if( ( dirp = readdir( dp ) ) == NULL )
				break;

			if( fileinfo.prelen == 0 && fileinfo.postlen == 0 )
			{
				if( !strcmp( dirp->d_name, "." ) || !strcmp( dirp->d_name, ".." ) )
					continue;
			}
			else
			if( fileinfo.prelen == 0 )
			{
				flen = (int)strlen( dirp->d_name );
				if( memcmp( fileinfo.poststr, &dirp->d_name[flen - fileinfo.postlen], fileinfo.postlen ) )
					continue;
			}
			else
			if( fileinfo.postlen == 0 )
			{
				if( memcmp( fileinfo.prestr, dirp->d_name, fileinfo.prelen ) )
					continue;
			}
			else
			{
				flen = (int)strlen( dirp->d_name );
				if( memcmp( fileinfo.poststr, &dirp->d_name[flen - fileinfo.postlen], fileinfo.postlen ) || memcmp( fileinfo.prestr, dirp->d_name, fileinfo.prelen ) )
					continue;
			}

			if( strcmp( dirname, "./" ) )
			{
				strcpy( srcfpath, dirname );
				strcat( srcfpath, dirp->d_name );
			}
			else
				strcpy( srcfpath, dirp->d_name );
		}
		else
		{
			strcpy( srcfpath, argv[i] );
			multi_fl = 0;
		}
#endif
		if( dochange_file() < 0 )
		{
			freemem();
			if( !access( tmpfpath, F_OK ) )
				unlink( tmpfpath );
			exit(5);
		}
#ifdef	WIN32
	}	/* end of loop-2 : loop for files of same wild char *,? WIN32 */
	if( hFind != INVALID_HANDLE_VALUE )	FindClose( hFind );
	if( errexit )
	{
		freemem();
		exit(5);
	}
#else
	}
	if( anal_ret )	closedir( dp );
	if( errexit )
	{
		freemem();
		exit(5);
	}
#endif
	}

	printf( "\n" );
	disp_result();

	freemem();

#ifdef		DISP_PROCESSTIME
	printf( "\nEndTime = %s\n", gettimestr() );

	times( &proctime );
	printf( "\nProcess time used : User = %ld, Sys = %ld\n",
		proctime.tms_utime, proctime.tms_stime );
#endif

	if( !access( tmpfpath, F_OK ) )
		unlink( tmpfpath );
	printf( "\n" );

	exit(0);
}

/*----------------------------------------------------------------------*/
/*  read spec file and set top/chg/btm info */
/*----------------------------------------------------------------------*/
int
read_spcfile()
{
	char	fld1[500];
	char	fld2[500];
	char	fld3[500];
	register int	nitm;		/* no of items in a line */
	int	curr_grp = GRP_CHG;	/* default group */
	FILE	*spcfd;
	int	spclineno;		/* current line number in spcfpath */


	if( ( spcfd = fopen( spcfpath, "r" ) ) == ( FILE * )0 )
	{
		printf( "\n%s file open error !\n\n", spcfpath );
		return( -1 );
	}

	for( spclineno = 1; !feof( spcfd ); spclineno++ )
	{
		if( fgets( rbuf, sizeof rbuf - 1, spcfd ) == NULL )
			continue;

		nitm = sscanf( rbuf, "%s%s%s", fld1, fld2, fld3 );

		if( nitm == 0 || nitm == EOF )	/* blank line */
		{
			switch( curr_grp ) {
				case GRP_TOP : add_topinf( rbuf ); continue;
				case GRP_BTM : add_btminf( rbuf ); continue;
				case GRP_CHG :
				default : continue;
			}
		}

		switch( fld1[0] )
		{
		case '#' :		/* comment */
			break;
		case ':' :		/* group */
			if( nitm > 1 && fld2[0] != '#' )	/* group err */
			{
				printf( " Error in %s Line %d :\n",
							spcfpath, spclineno );
				printf( "%s\n", rbuf );
				fclose( spcfd );
				return(-1);
			}

			if( !strcmp( &fld1[1], CMD_CHG ) )
				curr_grp = GRP_CHG;
			else if( !strcmp( &fld1[1], CMD_TOP ) )
				curr_grp = GRP_TOP;
			else if( !strcmp( &fld1[1], CMD_BTM ) )
				curr_grp = GRP_BTM;
			else
			{
				printf( " Unknown CMD GROUP : " );
				printf( "<%s> in %s Line %d\n",
				&fld1[1], spcfpath, spclineno );
				fclose( spcfd );
				return( -1 );
			}
			break;
		default :		/* data */
			switch( curr_grp )
			{
			case GRP_CHG :
				if( nitm == 1 || nitm > 2 && fld3[0] != '#' )
				{
					printf( " Error in %s Line %d :\n",
							spcfpath, spclineno );
					printf( "%s\n", rbuf );
					fclose( spcfd );
					return(-1);
				}
				if( add_chginf( fld1, fld2, spclineno ) < 0 )
				{
					printf( "\n" );
					fclose( spcfd );
					return( -1 );
				}
				break;
			case GRP_TOP :
				add_topinf( rbuf );
				break;
			case GRP_BTM :
				add_btminf( rbuf );
				break;
			}
		}
	}

	fclose( spcfd );

	if( !chginf_depth && !topinf_depth && !btminf_depth )
	{
		printf( " No information in %s !\n", spcfpath );
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
/*  add string change info */
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
add_chginf( char *fromstr, char *tostr, int spclineno )
#else
add_chginf( fromstr, tostr, spclineno )
char	*fromstr;			/* original string to change */
char	*tostr;				/* target string to become */
int	spclineno;			/* line number in spcfpath */
#endif
{
	struct CHGINF	*newitem;
	register char	*slptr;
	register char	*dlptr;

	newitem = (struct CHGINF *)malloc( sizeof( struct CHGINF ) );

	newitem->fromstrlen = strlen( fromstr );
	newitem->fromstr = (char *)malloc( newitem->fromstrlen + 1 );
	strcpy( newitem->fromstr, fromstr );
	if( istextchar( newitem->fromstr[ newitem->fromstrlen - 1 ] ) )
		newitem->fromstrendbytext = 1;
	else
		newitem->fromstrendbytext = 0;
	newitem->spclineno = spclineno;

	newitem->tostrlen = strlen( tostr );
	newitem->tostr = (char *)malloc( newitem->tostrlen + 1 );
	/* strcpy( newitem->tostrlen, tostr ); */
	/* for '@' to ' ' conversion, and consider \?  */
	for( slptr=tostr, dlptr=newitem->tostr; *slptr; slptr++, dlptr++)
	{
		if( *slptr == '@' ) *dlptr = ' ';
		else if( *slptr == '\\' && *(slptr+1) == '#' )
		{
			newitem->tostrlen--;
			*dlptr = *(++slptr);
		}
		else	*dlptr = *slptr;
	}
	*dlptr = '\0';

	newitem->next = ( struct CHGINF *)0;

	if( crosschk_chg( newitem, spclineno ) < 0 ) return( -1 );

	if( !chginf_depth ) chginf_start = newitem;
	else chginf_cur->next = newitem;

	chginf_cur = newitem;

	chginf_depth++;

	return( 0 );
}

int
#if	defined( __CB_STDC__ )
crosschk_chg( struct CHGINF *newitem, int spclineno )
#else
crosschk_chg( newitem, spclineno )
struct CHGINF	*newitem;
int		spclineno;			/* line number in spcfpath */
#endif
{
	struct	CHGINF	*chgptr;

	if( !strcmp( newitem->fromstr, newitem->tostr ) )
	{
		if( spclineno )
		{
			printf( "\nLine %d: [%s]. target = source !\n",
				spclineno, newitem->fromstr, newitem->tostr );
		}
		else
		{
			printf( "\nInvalid option [-s %s %s] target=source !\n",
				newitem->fromstr, newitem->tostr );
		}
		return( -1 );
	}

	for( chgptr = chginf_start; chgptr; chgptr = chgptr->next )
	{
		if( !strcmp( newitem->fromstr, chgptr->fromstr ) )
		{
			if( spclineno )
			{
			printf( "\nLine %d: [%s] Duplicated with Line %d !\n",
					spclineno, newitem->fromstr,
					chgptr->spclineno );
			}
			else
			{
				printf( "\n[%s] Duplicated !\n",
					newitem->fromstr );
			}
			return( -1 );
		}
		if( !strcmp( newitem->fromstr, chgptr->tostr ) )
		{
			if( spclineno )
			{
	printf( "\nLine %d: [%s] Duplicated with target of Line %d: [%s]!\n",
					spclineno, newitem->fromstr,
					chgptr->spclineno, chgptr->fromstr );
			}
			else
			{
			printf( "\n[%s] Duplicated with target of [%s]!\n",
					newitem->fromstr, chgptr->fromstr );
			}
			return( -1 );
		}
		if( !strcmp( newitem->tostr, chgptr->fromstr ) )
		{
			if( spclineno )
			{
	printf( "\nLine %d: [%s] Duplicated with target of Line %d: [%s]!\n",
					chgptr->spclineno, chgptr->fromstr,
					spclineno, newitem->fromstr );
			}
			else
			{
			printf( "\n[%s] Duplicated with target of [%s]!\n",
					chgptr->fromstr, newitem->tostr );
			}
			return( -1 );
		}
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
/*  add top line info */
/*----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
add_topinf( char *linestr )
#else
add_topinf( linestr )
char	*linestr;			/* 1 line buffer for top to add */
#endif
{
	struct TOPINF *newitem;
	register char	*slptr;
	register char	*dlptr;

	newitem = (struct TOPINF *)malloc( sizeof( struct TOPINF ) );

	newitem->linestr = (char *)malloc( strlen( linestr ) + 1 );
	/* strcpy( newitem->linestr, linestr ); */
	/* for '@' to ' ' conversion, and consider \?  */
	for( slptr=linestr, dlptr=newitem->linestr; *slptr; slptr++, dlptr++)
	{
		if( *slptr == '@' ) *dlptr = ' ';
		else if( *slptr == '\\' && *(slptr+1) == '#' )
			*dlptr = *(++slptr);
		else	*dlptr = *slptr;
	}
	*dlptr = '\0';
	newitem->next = ( struct TOPINF *)0;

	if( !topinf_depth ) topinf_start = newitem;
	else topinf_cur->next = newitem;

	topinf_cur = newitem;

	topinf_depth++;
}

/*----------------------------------------------------------------------*/
/*  add bottom line info */
/*----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
add_btminf( char *linestr )
#else
add_btminf( linestr )
char	*linestr;			/* 1 line buffer for btm to add */
#endif
{
	struct BTMINF *newitem;
	register char	*slptr;
	register char	*dlptr;

	newitem = (struct BTMINF *)malloc( sizeof( struct BTMINF ) );

	newitem->linestr = (char *)malloc( strlen( linestr ) + 1 );
	/* strcpy( newitem->linestr, linestr ); */
	/* for '@' to ' ' conversion, and consider \?  */
	for( slptr=linestr, dlptr=newitem->linestr; *slptr; slptr++, dlptr++)
	{
		if( *slptr == '@' ) *dlptr = ' ';
		else if( *slptr == '\\' && *(slptr+1) == '#' )
			*dlptr = *(++slptr);
		else	*dlptr = *slptr;
	}
	*dlptr = '\0';
	newitem->next = ( struct BTMINF *)0;

	if( !btminf_depth ) btminf_start = newitem;
	else btminf_cur->next = newitem;

	btminf_cur = newitem;

	btminf_depth++;
}

/*----------------------------------------------------------------------*/
/* change file
   return	0 : ok
		-1: critical error
   display status
	fpath	=> top inserted. %d lines changed. btm appended.
	fpath	=> not changed.
*/
/*----------------------------------------------------------------------*/
int
dochange_file()
{
	FILE	*srcfd;
	FILE	*tmpfd;
	register int	filechanged;
	register int	nline_changed;		/* lines changed in a file */
	char	srcbackfpath[500];

	filechanged = 0;
	nline_changed = 0;			/* lines changed in a file */

	printf( "%s ->", srcfpath );
	fflush( stdout );

	if( !chkiffile( srcfpath ) )
	{
		printf( " is directory. skipped...\n" );
		return( 0 );
	}
	nfile_valid++;

	if( ( srcfd = fopen( srcfpath, "r" ) ) == (FILE *)0 )
	{
		printf( " open error !\n" );
		nfile_error++;
		return( 0 );
	}

	if( ( tmpfd = fopen( tmpfpath, "w" ) ) == (FILE *)0 )
	{
		printf( " tmpfile (%s) create error !\n", tmpfpath );
		fclose( srcfd );
		return( -1 );
 	}

	if( topinf_depth > 0 )
	{
		if( do_top( tmpfd ) < 0 )
		{
			printf( " top insert error !\n" );
			nfile_error++;
			fclose( srcfd );
			fclose( tmpfd );
			return( 0 );
		}
		filechanged = 1;
		printf( " top inserted." );
	}

	if( chginf_depth > 0 )
	{
		srclineno = 0;

		for( ; ; )
		{
			srclineno++;

			if( fgets( rbuf, sizeof rbuf - 1, srcfd ) == NULL )
				break;	/* EOF */

			switch( do_chgline( tmpfd ) )
			{
			case -1 :
				printf( "chg string error !\n");
				nfile_error++;
				fclose( srcfd );
				fclose( tmpfd );
				return( 0 );
			case 0 :
				break;
			case 1 :
				if( opt_l )
				{
					if( !nline_changed )
						printf( "\n" );
					printf( " [%d]FROM:%s",
						srclineno, rbuf);
					printf( " [%d]TO  :%s",
						srclineno, dispbuf);
				}
				nline_changed++;
				break;
			}
		}
		if( nline_changed )
		{
			printf( " %d lines changed.",
				nline_changed );
			nline_changedtotal += nline_changed;
			filechanged = 1;
		}
 	}

	if( btminf_depth > 0 )
	{
		if( do_btm( tmpfd ) < 0 )
		{
			printf( " btm insert error !\n" );
			nfile_error++;
			fclose( srcfd );
			fclose( tmpfd );
			return( 0 );
		}
		printf( " btm appended." );
		filechanged = 1;
	}

	fclose( srcfd );
	fclose( tmpfd );

	if( filechanged )
	{
		if( opt_b )
		{
			strcpy( srcbackfpath, srcfpath );
			strcat( srcbackfpath, "." );
			strcat( srcbackfpath, backupext );
			if( rename( srcfpath, srcbackfpath ) < 0 )
			{
				printf( " file backup ( %s ) error !\n",
					srcbackfpath );
				nfile_error++;
				return( 0 );
			}
			rename( tmpfpath, srcfpath );
		}
		else
		{
			if( unlink( srcfpath ) < 0 )
			{
				printf( " file update ( %s ) error !\n",
					srcfpath );
				nfile_error++;
				return( 0 );
			}
			rename( tmpfpath, srcfpath );
		}
		nfile_changed++;
		printf( "\n" );
	}
	else
	{
		nfile_unchanged++;
		printf( " not changed.\n" );
	}
	
	return( 0 );
}

/*----------------------------------------------------------------------*/
/* insert top
   return 	0 : ok, -1 : err
*/
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
do_top( FILE *outfd )
#else
do_top( outfd )
FILE	*outfd;
#endif
{
	register struct	TOPINF	*topptr;

	for( topptr=topinf_start; topptr; topptr=topptr->next )
	{
		if( do_topline( outfd, topptr->linestr ) < 0 )
			return( -1 );
	}
	return( 0 );
}

/*----------------------------------------------------------------------*/
/* append bottom
   return 	0 : ok, -1 : err
*/
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
do_btm( FILE *outfd )
#else
do_btm( outfd )
FILE	*outfd;
#endif
{
#define	do_btmline	do_topline
	register struct	BTMINF	*btmptr;

	for( btmptr=btminf_start; btmptr; btmptr=btmptr->next )
	{
		if( do_btmline( outfd, btmptr->linestr ) < 0 )
			return( -1 );
	}
	return( 0 );
}

/*----------------------------------------------------------------------*/
/* do top or btm 1 line
   return 	0 : ok, -1 : err
*/
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
do_topline( FILE *outfd, char *linestr )
#else
do_topline( outfd, linestr )
FILE	*outfd;
char	*linestr;
#endif
{
	register char	*sptr;
	register char	*wrtptr;
	register int	masklen;	/* length of fldmask "%....%" */

	for( wrtptr=sptr=linestr; *sptr; )
	{

		if( *sptr != '%' )
		{
			sptr++;
			continue;
		}

		if( ( masklen = get_fldstr( sptr, rbuf ) ) < 0 )
		{
			sptr++;
			continue;	/* not valid */
		}

		if( sptr - wrtptr )
			fwrite( wrtptr, sptr-wrtptr, 1, outfd );

		fwrite( rbuf, strlen( rbuf ), 1, outfd ); /* NULLterm. rbuf */
		sptr += masklen;
		wrtptr = sptr;
	}

	if( sptr - wrtptr )
		fwrite( wrtptr, sptr-wrtptr, 1, outfd );

	return( 0 );
}
/*----------------------------------------------------------------------*/
/*  get result string(null term) from field mask string (not null term.)
	return	 -1 : err, > 0 : length of field mask */
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
get_fldstr( char *fldmask, char *outbuf )
#else
get_fldstr( fldmask, outbuf )
char	*fldmask;		/* "%....%" */
char	*outbuf;		/* output buffer */
#endif
{
	switch( *(fldmask+1) )
	{
	case 'B' :
		if( !memcmp( fldmask, "%BFNAME%", 8 ) )
		{
			getbfname( srcfpath, outbuf );
			return( 8 );
		}
		return( -1 );
	case 'D' :
		if( !memcmp( fldmask, "%DATE10/%", 9 ) )
		{
			sprintf( outbuf, "%04d/%02d/%02d",
				(int)curtime->tm_year+1900,
				(int)curtime->tm_mon,
				(int)curtime->tm_mday );
			return( 9 );
		}
		if( !memcmp( fldmask, "%DATE10.%", 9 ) )
		{
			sprintf( outbuf, "%04d.%02d.%02d",
				(int)curtime->tm_year+1900,
				(int)curtime->tm_mon,
				(int)curtime->tm_mday );
			return( 9 );
		}
		if( !memcmp( fldmask, "%DATE10S%", 9 ) )
		{
			sprintf( outbuf, "%04d %02d %02d",
				(int)curtime->tm_year+1900,
				(int)curtime->tm_mon,
				(int)curtime->tm_mday );
			return( 9 );
		}
		if( !memcmp( fldmask, "%DATE8/%", 8 ) )
		{
			sprintf( outbuf, "%02d/%02d/%02d",
				(int)curtime->tm_year,
				(int)curtime->tm_mon,
				(int)curtime->tm_mday );
			return( 8 );
		}
		if( !memcmp( fldmask, "%DATE8.%", 8 ) )
		{
			sprintf( outbuf, "%02d.%02d.%02d",
				(int)curtime->tm_year,
				(int)curtime->tm_mon,
				(int)curtime->tm_mday );
			return( 8 );
		}
		if( !memcmp( fldmask, "%DATE8S%", 8 ) )
		{
			sprintf( outbuf, "%02d %02d %02d",
				(int)curtime->tm_year,
				(int)curtime->tm_mon,
				(int)curtime->tm_mday );
			return( 8 );
		}
		if( !memcmp( fldmask, "%DD%", 4 ) )
		{
			sprintf( outbuf, "%02d",
				(int)curtime->tm_mday );
			return( 4 );
		}
			return( -1 );
	case 'F' :
		if( !memcmp( fldmask, "%FPATH%", 7 ) )
		{
			strcpy( outbuf, srcfpath );
			return( 7 );
		}
		if( !memcmp( fldmask, "%FNAME%", 7 ) )
		{
			getfname( srcfpath, outbuf );
			return( 7 );
		}
		if( !memcmp( fldmask, "%FNAME_%", 8 ) )
		{
			getfname_( srcfpath, outbuf );
			return( 8 );
		}
		return( -1 );
	case 'H' :
		if( !memcmp( fldmask, "%HH%", 4 ) )
		{
			sprintf( outbuf, "%02d",
				(int)curtime->tm_hour );
			return( 4 );
		}
		return( -1 );
	case 'M' :
		if( !memcmp( fldmask, "%MONTH%", 7 ) )
		{
			strcpy( outbuf,month_str[(int)curtime->tm_mon]);
			return( 7 );
		}
		if( !memcmp( fldmask, "%MM%", 4 ) )
		{
			sprintf( outbuf, "%02d", (int)curtime->tm_mon);
			return( 4 );
		}
		return( -1 );
	case 'U' :
		if( !memcmp( fldmask, "%UFNAME_%", 9 ) )
		{
			getufname_( srcfpath, outbuf );
			return( 9 );
		}
		if( !memcmp( fldmask, "%UBFNAME%", 9 ) )
		{
			getubfname( srcfpath, outbuf );
			return( 9 );
		}
		if( !memcmp( fldmask, "%UFNAME%", 8 ) )
		{
			getufname( srcfpath, outbuf );
			return( 8 );
		}
		return( -1 );
	case 'Y' :
		if( !memcmp( fldmask, "%YYYY%", 6 ) )
		{
			sprintf( outbuf, "%04d", (int)curtime->tm_year+1900 );
			return( 6 );
		}
		if( !memcmp( fldmask, "%YY%", 4 ) )
		{
			sprintf( outbuf, "%02d", (int)curtime->tm_year );
			return( 4 );
		}
		return( -1 );
	default :
		return( -1 );
	}
}

/*----------------------------------------------------------------------*/
/*
   change 1 line

   return
	1	: line changed
	0  	: line unchanged
	-1	: err
*/
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
do_chgline( FILE *outfd )
#else
do_chgline( outfd )
FILE	*outfd;
#endif
{
	register char		*rptr;
	register char		*sptr;
	register char		*dptr;
	register int		i;
	register int		notsame;
	register struct	CHGINF	*chgptr;
	register struct	FLDINF	*fldptr;
	register char		*wrtptr;	/* pointer to write in rbuf[] */
	register int		dispbufoff;
	register int		changed;
	register int		retval;
	register int		fldno;
	register int		rbuflen;	/* length of data in rbuf */

	retval = 0;
	dispbufoff = 0;
	rbuflen = strlen( rbuf );

	if( !opt_tc )
	{
	    /* loop by increasing buffer ptr 1 by 1 */
	    for( wrtptr=rptr=rbuf; *rptr; )
	    {
		changed = 0;		/* reset change status */

		/* check if any fromstr exist and write to file */
		for( chgptr=chginf_start; chgptr; chgptr=chgptr->next )
		{
			/* if already checked, then skip */
			/* check if fromstr starts */
			for( notsame=1, sptr=rptr, dptr=chgptr->fromstr; ;
				sptr++, dptr++ )
			{
				if( !(*dptr) )		/* same string */
				{
					notsame=0;
					break;
				}
				else if( *dptr != *sptr )	/* notsame */
					break;
				else if( !(*sptr) )	/* notsame(line end) */
					break;
				else	continue;
			}
				
			if( notsame ) continue;

			/* write previous not changed text */
			if( rptr - wrtptr )
			{
				fwrite( wrtptr, rptr-wrtptr, 1, outfd );
				if( opt_l )
				{
					memcpy( &dispbuf[dispbufoff], wrtptr,
						rptr-wrtptr );
					dispbufoff += rptr-wrtptr;
					dispbuf[dispbufoff] = '\0';
				}
			}

			/* write tostr instead of fromstr */
			fwrite( chgptr->tostr, chgptr->tostrlen, 1, outfd );
			if( opt_l )
			{
				memcpy( &dispbuf[dispbufoff], chgptr->tostr,
					chgptr->tostrlen );
				dispbufoff += chgptr->tostrlen;
				dispbuf[dispbufoff] = '\0';
			}

			/* increase line ptr by fromstrlen */
			wrtptr = rptr + chgptr->fromstrlen;
			rptr = sptr;

			changed = 1;
			retval = 1;
			break;
		}

		if( changed ) continue;	/* case already written by tostr */
		rptr++;
	    }

	    /* write remained buffers */
	    if( rbuf+rbuflen-wrtptr )
	    {
	    	fwrite( wrtptr, rbuf+rbuflen-wrtptr, 1, outfd );
	    	if( opt_l )
		{
			memcpy( &dispbuf[dispbufoff], wrtptr,
				rbuf+rbuflen-wrtptr );
			dispbufoff += rbuf+rbuflen-wrtptr;
			dispbuf[dispbufoff] = '\0';
	    	}
	    }

	    return( retval );
	}
	else	/* if( opt_tc ) */
	{
	    /* 1. get field informations in rbuf */
	    nfld = 0;

	    /* skip first non-text chars */
	    for( rptr=rbuf; *rptr; rptr++ )
		if( istextchar( *rptr ) )
			break;

	    /* get all field info */
	    for( fldptr = &fldinf[0]; *rptr; )
	    {
		fldptr->sptr = rptr;
		rptr++;

		/* get field length */
	    	for( ; *rptr; rptr++ )
		{
			if( istextchar( *rptr ) ) continue;
			fldptr->len = (int)(rptr - fldptr->sptr);
			nfld++;
			fldptr++;
			break;
		}

		/* find next text char */
		for( ; *rptr; rptr++ )
			if( istextchar( *rptr ) )
				break;
	    }

	    /* 2. do change according to field informations set */
	    for( fldno = 0, wrtptr = rbuf, fldptr=&fldinf[0];
		fldno < nfld;
		fldno++, fldptr++  )
	    {
		/* skip fld(s) if they were already considered by multi field
			change during previous field change */
		if( wrtptr > fldptr->sptr ) continue;

		/* check if any fromstr exist and write to file */
		for( chgptr=chginf_start; chgptr; chgptr=chgptr->next )
		{
			/* if already checked, then skip */
			/* check if fromstr starts */
			for( i=0, notsame=1, sptr=fldptr->sptr,
			    dptr=chgptr->fromstr; ;
			    sptr++, dptr++, i++  )
			{
				if( !(*dptr) )		/* end dptr */
				{
					/* consider simple fromstr like "abc" */
					if( i == fldptr->len ) 
						notsame=0;	/* same */
					/* consider fromstr like "abc->" */
					else if( istextchar( *sptr ) )
					{
						if( !chgptr->fromstrendbytext )
							notsame=0; /* same */
					}
					/* consider fromstr like "abc->xyz" */
					else
					{
						if( chgptr->fromstrendbytext )
							notsame=0; /* same */
					}
					break;
				}
				else if( *dptr != *sptr ) break;/* notsame */
				else if( !(*sptr) ) break;	/* line end */
			}
				
			if( notsame ) continue;

			/* write previous not changed text */
			if( fldptr->sptr - wrtptr )
			{
				fwrite( wrtptr, fldptr->sptr-wrtptr, 1, outfd );
				if( opt_l )
				{
					memcpy( &dispbuf[dispbufoff], wrtptr,
						fldptr->sptr-wrtptr );
					dispbufoff += fldptr->sptr-wrtptr;
					dispbuf[dispbufoff] = '\0';
				}
			}

			/* write tostr instead of fromstr */
			fwrite( chgptr->tostr, chgptr->tostrlen, 1, outfd );
			if( opt_l )
			{
				memcpy( &dispbuf[dispbufoff], chgptr->tostr,
					chgptr->tostrlen );
				dispbufoff += chgptr->tostrlen;
				dispbuf[dispbufoff] = '\0';
			}

			/* ZZZZ wrtptr = fldptr->sptr + fldptr->len; */
			wrtptr = fldptr->sptr + chgptr->fromstrlen;

			retval = 1;
			break;
		}
	    }

	    /* write remained buffers */
	    if( rbuf+rbuflen-wrtptr )
	    {
	    	fwrite( wrtptr, rbuf+rbuflen-wrtptr, 1, outfd );
	    	if( opt_l )
		{
			memcpy( &dispbuf[dispbufoff], wrtptr,
				rbuf+rbuflen-wrtptr );
			dispbufoff += rbuf+rbuflen-wrtptr;
			dispbuf[dispbufoff] = '\0';
	    	}
	    }

	    return( retval );
	}
}

/*----------------------------------------------------------------------*/
/*  return	1 : is a valid text character ( '0'-'9','A'-'Z','a'-'z','_' )
		0 : is a control character ( other character )
    assume C program sources
*/
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
istextchar( int c )
#else
istextchar( c )
int	c;
#endif
{

	if( c >= '0' && c <= '9' ) return( 1 );		/* '0' - '9' */
	if( c >= 'A' && c <= 'Z' ) return( 1 );		/* 'A' - 'Z' */
	if( c >= 'a' && c <= 'z' ) return( 1 );		/* 'a' - 'z' */
	if( c == '_' )		   return( 1 );		/* '_' */
	if( opt_tc == 2 )
		if( c == '-' )     return( 1 );		/* '-' */

	return( 0 );
}

/*----------------------------------------------------------------------*/
/* check if fpath is file or directory
   return	1 : is a file
		0 : is a directory
*/
/*----------------------------------------------------------------------*/
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

/*----------------------------------------------------------------------*/
/* display results

	total : %d lines changed in %d files out of %d files.
	total : no files changed.
*/
/*----------------------------------------------------------------------*/
void
disp_result()
{
	if( nfile_changed )
	printf( "total : %d lines changed in %d files out of %d files.\n",
		nline_changedtotal, nfile_changed, nfile_valid );
	else
	printf( "total : no files changed. in %d files\n",
		nfile_valid );

	if( nfile_error )
		printf( "        error in %d files !\n", nfile_error );

	if( nfile_total > nfile_valid )
		printf( "        %d files are directory.\n",
			nfile_total - nfile_valid );
}
/*----------------------------------------------------------------------*/
/*  free all allocated memory */
/*----------------------------------------------------------------------*/
void
freemem()
{
	struct	CHGINF	*chgptr;
	struct	TOPINF	*topptr;
	struct	BTMINF	*btmptr;
	char	*savptr;

	if( chginf_start )
	{
		for( chgptr = chginf_start; chgptr; )
		{
			free( chgptr->fromstr );
			free( chgptr->tostr );
			savptr = (char *)chgptr;
			chgptr = chgptr->next;
			free( savptr );
		}
	}

	if( topinf_start )
	{
		for( topptr = topinf_start; topptr; )
		{
			free( topptr->linestr );
			savptr = (char *)topptr;
			topptr = topptr->next;
			free( savptr );
		}
	}

	if( btminf_start )
	{
		for( btmptr = btminf_start; btmptr; )
		{
			free( btmptr->linestr );
			savptr = (char *)btmptr;
			btmptr = btmptr->next;
			free( savptr );
		}
	}
}


/*----------------------------------------------------------------------*/
/* get various file name */
/*----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
getfname( char *fpath, char *outbuf )
#else
getfname( fpath, outbuf )
char	*fpath;
char	*outbuf;
#endif
{
	register char	*pathptr;

	for( pathptr = fpath+strlen(fpath); pathptr-- != fpath; )
#ifdef	WIN32
		if( *pathptr == '\\' ) break;
#else
		if( *pathptr == '/' ) break;
#endif

	for( ++pathptr; *outbuf = *pathptr; outbuf++, pathptr++ )
		;
}

void
#if	defined( __CB_STDC__ )
getufname( char *fpath, char *outbuf )
#else
getufname( fpath, outbuf )
char	*fpath;
char	*outbuf;
#endif
{
	register char	*pathptr;

	for( pathptr = fpath+strlen(fpath); pathptr-- != fpath; )
#ifdef	WIN32
		if( *pathptr == '\\' ) break;
#else
		if( *pathptr == '/' ) break;
#endif

	for( ++pathptr; *outbuf = toupper(*pathptr); outbuf++, pathptr++ )
		;
}

void
#if	defined( __CB_STDC__ )
getfname_( char *fpath, char *outbuf )
#else
getfname_( fpath, outbuf )
char	*fpath;
char	*outbuf;
#endif
{
	register char	*pathptr;

	for( pathptr = fpath+strlen(fpath); pathptr-- != fpath; )
#ifdef	WIN32
		if( *pathptr == '\\' ) break;
#else
		if( *pathptr == '/' ) break;
#endif

	for( ++pathptr; *outbuf = *pathptr; outbuf++, pathptr++ )
		if( *outbuf == '.' ) *outbuf = '_';
}

void
#if	defined( __CB_STDC__ )
getufname_( char *fpath, char *outbuf )
#else
getufname_( fpath, outbuf )
char	*fpath;
char	*outbuf;
#endif
{
	register char	*pathptr;

	for( pathptr = fpath+strlen(fpath); pathptr-- != fpath; )
#ifdef	WIN32
		if( *pathptr == '\\' ) break;
#else
		if( *pathptr == '/' ) break;
#endif

	for( ++pathptr; *outbuf = toupper(*pathptr); outbuf++, pathptr++ )
		if( *outbuf == '.' ) *outbuf = '_';
}

void
#if	defined( __CB_STDC__ )
getbfname( char *fpath, char *outbuf )
#else
getbfname( fpath, outbuf )
char	*fpath;
char	*outbuf;
#endif
{
	register char	*pathptr;

	for( pathptr = fpath+strlen(fpath); pathptr-- != fpath; )
#ifdef	WIN32
		if( *pathptr == '\\' ) break;
#else
		if( *pathptr == '/' ) break;
#endif

	for( ++pathptr; *outbuf = *pathptr; outbuf++, pathptr++ )
		if( *outbuf == '.' ) { *outbuf = '\0'; break; }
}

void
#if	defined( __CB_STDC__ )
getubfname( char *fpath, char *outbuf )
#else
getubfname( fpath, outbuf )
char	*fpath;
char	*outbuf;
#endif
{
	register char	*pathptr;

	for( pathptr = fpath+strlen(fpath); pathptr-- != fpath; )
#ifdef	WIN32
		if( *pathptr == '\\' ) break;
#else
		if( *pathptr == '/' ) break;
#endif

	for( ++pathptr; *outbuf = toupper(*pathptr); outbuf++, pathptr++ )
		if( *outbuf == '.' ) { *outbuf = '\0'; break; }
}

/*----------------------------------------------------------------------*/
/*  display TOPINF */
/*----------------------------------------------------------------------*/
void
disp_topinf()
{
	struct	TOPINF	*topptr;
	register int	i;

	printf( "\n** TOPINF INFORMATION ( %d items ) **\n", topinf_depth );
	if( topinf_depth )
	{
		for( i=1,topptr = topinf_start; topptr;
			topptr = topptr->next, i++ )
		{
			printf( "[%2d] : %s", i, topptr->linestr );
		}
	}
}

/*----------------------------------------------------------------------*/
/*  display BTMINF */
/*----------------------------------------------------------------------*/
void
disp_btminf()
{
	struct	BTMINF	*btmptr;
	register int	i;

	printf( "\n** BTMINF INFORMATION ( %d items ) **\n", btminf_depth );
	if( btminf_depth ) {
		for( i=1,btmptr = btminf_start; btmptr;
			btmptr = btmptr->next, i++ )
		{
			printf( "[%2d] : %s", i, btmptr->linestr );
		}
	}
}

/*----------------------------------------------------------------------*/
/*  display CHGINF */
/*----------------------------------------------------------------------*/
void
disp_chginf()
{
	struct	CHGINF	*chgptr;
	register int	i;

	printf( "\n** CHGINF INFORMATION ( %d items ) **\n", chginf_depth );
	if( chginf_depth )
	{
		for( i=1,chgptr = chginf_start; chgptr;
			chgptr = chgptr->next, i++ )
		{
			printf( "[%2d] : %s -> %s\n",
				i, chgptr->fromstr, chgptr->tostr );
		}
	}
}

#ifdef		DISP_PROCESSTIME
/*----------------------------------------------------------------------*/
/*  get time string of current */
/*----------------------------------------------------------------------*/
#include	<time.h>
char	*
gettimestr()
{
	time_t	timeval;
	struct	tm	*tmtime;
static	char	__time_str__[20];

	time( &timeval );

	tmtime = localtime( &timeval );
	tmtime->tm_mon ++;

	sprintf( __time_str__, "%04d/%02d/%02d %02d:%02d:%02d",
		(int)tmtime->tm_year+1900,
		(int)tmtime->tm_mon,
		(int)tmtime->tm_mday,
		(int)tmtime->tm_hour,
		(int)tmtime->tm_min,
		(int)tmtime->tm_sec );
	return( __time_str__ );
}
#endif

/*----------------------------------------------------------------------*/
#ifndef WIN32
int
#if	defined( __CB_STDC__ )
sep_dir_file( char *fpath, char *dirname, char *filename )
#else
sep_dir_file( fpath, dirname, filename )
char	*fpath;
char	*dirname;
char	*filename;
#endif
{
	register	i, fpathlen;

	fpathlen = (int)strlen( fpath );
	for( i = fpathlen - 1; i >= 0; i-- )
	{
		if( fpath[i] == '/' )
		{
			if( i == ( fpathlen - 1 ) )
			{
				strcpy( dirname, fpath );
				filename[0] = '\0';
				return( 1 );
			}

			memcpy( dirname, fpath, i + 1 );
			dirname[i + 1] = '\0';
			strcpy( filename, &fpath[i + 1] );
			break;
		}
	}

	if( i < 0 )
	{
		dirname[0] = '.';
		dirname[1] = '/';
		dirname[2] = '\0';
		strcpy( filename, fpath );
	}

	return( 0 );
}
#endif

/*----------------------------------------------------------------------*/
#ifndef WIN32
int
#if	defined( __CB_STDC__ )
anal_filename( char *filename, struct finfo_frm *fileinfo )
#else
anal_filename( filename, fileinfo )
char	*filename;
struct	finfo_frm	*fileinfo;
#endif
{
	register	i, flen;

	flen = (int)strlen( filename );
	fileinfo->prelen = 0;
	fileinfo->prestr[0] = '\0';
	fileinfo->postlen = 0;
	fileinfo->poststr[0] = '\0';
	for( i = 0; i < flen; i++ )
	{
		if( filename[i] == '*' )
		{
			if( i > 0 )
			{
				fileinfo->prelen = i;
				memcpy( fileinfo->prestr, filename, i );
				fileinfo->prestr[i] = '\0';
			}

			if( i < ( flen - 1 ) )
			{
				fileinfo->postlen = flen - i - 1;
				strcpy( fileinfo->poststr, &filename[i + 1] );
			}
			return( 1 );
		}
	}
	return( 0 );
}
#endif

/*----------------------------------------------------------------------*/
/* print command help */
/*----------------------------------------------------------------------*/
void
prt_cmdusage()
{
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |   File String Modification Utility              |\n" );
	printf( "   |-------------------------------------------------|\n" );
	printf( "   | Usage : fstr <-options> files .....             |\n" );
	printf( "   |                                                 |\n" );
  	printf( "   | <options>                                       |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |   -h          : command help in details         |\n" );
	printf( "   |   -f specfile : modify according to spec file   |\n" );
	printf( "   |   -tc         : files are 'C'source(default)    |\n" );
	printf( "   |   -tb         : files are 'COBOL'source         |\n" );
	printf( "   |   -tx         : files are general text          |\n" );
	printf( "   |   -l          : list change history             |\n" );
	printf( "   |   -p          : display change spec inform.     |\n" );
	printf( "   |   -b ext      : backup files to filename.ext    |\n" );
	printf( "   |   -s fromstr tostr : substitute all fromstr     |\n" );
	printf( "   |              with tostr( may be repeated )      |\n" );
	printf( "   |                                                 |\n" );
	printf( "   | files : files to change. ex) aaa.c tmp/*.? ...  |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |     by S.T.Woo.  HYSYS. 1996.3 V1.0             |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
}

void
prt_cmdhelp()
{
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |   File String Modification Utility              |\n" );
	printf( "   |-------------------------------------------------|\n" );
	printf( "   | Usage : fstr <-options> files .....             |\n" );
	printf( "   |                                                 |\n" );
  	printf( "   | <options>                                       |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |   -h          : command help in details         |\n" );
	printf( "   |   -f specfile : modify according to spec file   |\n" );
	printf( "   |   -tc         : files are 'C'source(default)    |\n" );
	printf( "   |   -tb         : files are 'COBOL'source         |\n" );
	printf( "   |   -tx         : files are general text          |\n" );
	printf( "   |   -l          : list change history             |\n" );
	printf( "   |   -p          : display change spec inform.     |\n" );
	printf( "   |   -b ext      : backup files to filename.ext    |\n" );
	printf( "   |   -s fromstr tostr : substitute all fromstr     |\n" );
	printf( "   |              with tostr( may be repeated )      |\n" );
	printf( "   |                                                 |\n" );
	printf( "   | files : files to change. ex) aaa.c tmp/*.? ...  |\n" );
	printf( "   |                                                 |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |                                                 |\n" );
	printf( "   |    * < -s option usage in detail >              |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      -s fromstr tostr -s fromstr tostr ...      |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      fromstr to be continuous string.           |\n" );
	printf( "   |       if -tc opt, start by alpha-num or '_'     |\n" );
	printf( "   |       if -tb opt, start by alpha-num            |\n" );
	printf( "   |                   except start char,            |\n" );
	printf( "   |                   made by al-num, '-', '_'      |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      tostr to be continuous string with any char|\n" );
	printf( "   |       '@'s in tostr will be changed by ' 's.    |\n" );
	printf( "   |       '#'s in tostr to be described as '\\#'     |\n" );
	printf( "   |                                                 |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |                                                 |\n" );
	printf( "   |    * < spec file description method >           |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      :CHG          : change string info         |\n" );
	printf( "   |      #.....        : comments after '#'         |\n" );
	printf( "   |      fromstr tostr : see -s option              |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      :TOP          : inserted at file head      |\n" );
	printf( "   |      any texts ..  : comments                   |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      :BTM          : appended at file end       |\n" );
	printf( "   |      any texts ..  : comments                   |\n" );
	printf( "   |                                                 |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |                                                 |\n" );
	printf( "   |    * < :CHG group description method detail >   |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      :CHG                                       |\n" );
	printf( "   |      fromstr tostr                              |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      fromstr to be continuous string.           |\n" );
	printf( "   |       if -tc opt, start by alpha-num or '_'     |\n" );
	printf( "   |       if -tb opt, start by alpha-num            |\n" );
	printf( "   |                   except start char,            |\n" );
	printf( "   |                   made by al-num, '-', '_'      |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      tostr to be continuous string with any char|\n" );
	printf( "   |       '@'s in tostr will be changed by ' 's.    |\n" );
	printf( "   |       '#'s in tostr to be described as '\\#'     |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |    * :CHG, :BTM, :TOP may occur more than one   |\n" );
	printf( "   |      times. position sequence not restricted.   |\n" );
	printf( "   |                                                 |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |                                                 |\n" );
	printf( "   |    * <special fields in :TOP and :BTM >         |\n" );
	printf( "   |                                                 |\n" );
	printf( "   |      %cFPATH%c  : filepath with directory         |\n", '%','%' );
	printf( "   |      %cFNAME%c  : filename excluding directory    |\n", '%','%' );
	printf( "   |      %cUFNAME%c : filename in uppercase           |\n", '%','%' );
	printf( "   |      %cFNAME_%c : filename '.' -> '_'             |\n", '%','%' );
	printf( "   |      %cUFNAME_%c: uppercase filename '.' -> '_'   |\n", '%','%' );
	printf( "   |      %cBNAME%c  : base filename without directory |\n", '%','%' );
	printf( "   |                 and any '.'s                    |\n" );
	printf( "   |      %cUBFNAME%c: uppercase base filename         |\n", '%','%' );
	printf( "   |                                                 |\n" );
	printf( "   |      %cYYYY%c   : today's year ( ex. 1996 )       |\n", '%','%' );
	printf( "   |      %cYY%c     : today's year ( ex. 96 )         |\n", '%','%' );
	printf( "   |      %cMONTH%c  : today's month ( ex. Dec, Jun )  |\n", '%','%' );
	printf( "   |      %cMM%c     : today's month ( ex. 03 )        |\n", '%','%' );
	printf( "   |      %cDD%c     : today's day   ( ex. 14 )        |\n", '%','%' );
	printf( "   |      %cHH%c     : hour now      ( ex. 17, 03 )    |\n", '%','%' );
	printf( "   |                                                 |\n" );
	printf( "   |      %cDATE8/%c : today's date ( ex. 96/12/04 )   |\n", '%','%' );
	printf( "   |      %cDATE10/%c: today's date ( ex. 1996/12/04 ) |\n", '%','%' );
	printf( "   |      %cDATE8.%c : today's date ( ex. 96.12.04 )   |\n", '%','%' );
	printf( "   |      %cDATE10.%c: today's date ( ex. 1996.12.04 ) |\n", '%','%' );
	printf( "   |      %cDATE8S%c : today's date ( ex. 96 12 04 )   |\n", '%','%' );
	printf( "   |      %cDATE10S%c: today's date ( ex. 1996 12 04 ) |\n", '%','%' );
	printf( "   |                                                 |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
}

void
prt_cmderrhelp()
{
	printf( "\n" );
	printf( "Usage : fstr <-options> files .....\n" );
  	printf( "   <options>\n" );
	printf( "      -h              : command help in details\n" );
	printf( "      -f specfile \n" );
	printf( "      -tc             : files are 'C' source (default)\n" );
	printf( "      -tb             : files are 'COBOL' source \n" );
	printf( "      -tx             : files are general text file \n" );
	printf( "      -l              : list change history\n" );
	printf( "      -p              : display change spec information.\n" );
	printf( "      -b ext          : backup files to <filename>.ext\n" );
	printf( "      -s fromstr tostr: substitute all fromstr\n" );
	printf( "   files : files to change.\n" );
	printf( "\n" );
	printf( "Examples\n" );
	printf( "    fstr -f ../chgspc -l -b org *abc.* ../tmp/*.c\n" );
	printf( "    fstr -s CLLA CALL -s DATA DATE -tb ../src/*.cob\n" );
	printf( "    fstr -s This's THIS@IS -s Whta What -tx .doc/*\n" );
	printf( "\n" );
}

void
prt_samplespec()
{
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |  SAMPLE SPEC FILE                               |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
	prt_samplesrc();
	printf( "\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "   |     by S.T.Woo.  HYSYS. 1996.3 V1.0             |\n" );
	printf( "   +-------------------------------------------------+\n" );
	printf( "\n" );
}

void
prt_samplesrc()
{
printf( ":TOP \n" );
printf( "/* %cFNAME%c */ \n", '%', '%' );
printf( "/*----------------------------------------------------------------------* \n" );
printf( "| Descrip.	File String Modification Utility			| \n" );
printf( "|									| \n" );
printf( "| Project	HYCASE							| \n" );
printf( "| System	UTIL							| \n" );
printf( "| Programid	%cUBFNAME%c						| \n", '%', '%' );
printf( "|									| \n" );
printf( "| By		stwoo							| \n" );
printf( "| Date		%cDATE8.%c						| \n", '%', '%' );
printf( "|									| \n" );
printf( "*-----------------------------------------------------------------------*/ \n" );
printf( "/* history */ \n" );
printf( "/* yymmdd : .......... */ \n" );
printf( " \n" );
printf( "\\#ifndef	%cUFNAME_%c \n", '%', '%' );
printf( "\\#define	%cUFNAME_%c \n", '%', '%' );
printf( ":TOP \n" );
printf( " \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "/*  INCLUDE FILES							*/ \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( " \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "/*	DEFINE VARIABLES						*/ \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( " \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "/*	DEFINE STRUCTURES						*/ \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( " \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "/* FUNCTION PROTOTYPES */ \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( " \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "/*	EXTERN DATA							*/ \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( " \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "/*	main() PROCEDURE						*/ \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "main() \n" );
printf( "{ \n" );
printf( "} \n" );
printf( " \n" );
printf( ":BTM \n" );
printf( "/*----------------------------------------------------------------------*/ \n" );
printf( "\\#endif	/* %cUFNAME_%c */ \n", '%', '%' );
printf( ":CHG \n" );
printf( "	PM_FLAY		UN_FILELAY		# rename only \n" );
printf( "	CHGINF		struct@UN_CHGINF	# @ means ' ' \n" );
printf( "	TOPINF		struct@UN_TOPINF	# @ means ' ' \n" );
printf( "	cntl		un_tca->cntl \n" );
printf( "	dprintf		\\#ifdef@DEBUG@printf \n" );
}

#ifdef	SAMPLE_SOURCE
:TOP
/* %FNAME% */
/*----------------------------------------------------------------------*
| Descrip.	File String Modification Utility			|
|									|
| Project	HYCASE							|
| System	UTIL							|
| Programid	%UBFNAME%						|
|									|
| By		stwoo							|
| Date		%DATE8.%						|
|									|
*-----------------------------------------------------------------------*/
/* history */
/* yymmdd : .......... */

\#ifndef	%UFNAME_%
\#define	%UFNAME_%
:TOP

/*----------------------------------------------------------------------*/
/*  INCLUDE FILES							*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	DEFINE VARIABLES						*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	DEFINE STRUCTURES						*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/* FUNCTION PROTOTYPES */
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	EXTERN DATA							*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	main() PROCEDURE						*/
/*----------------------------------------------------------------------*/
main()
{
}

:BTM
/*----------------------------------------------------------------------*/
\#endif	/* %UFNAME_% */
:CHG
	PM_FLAY		UN_FILELAY		# rename only
	CHGINF		struct@UN_CHGINF	# @ means ' '
	TOPINF		struct@UN_TOPINF	# @ means ' '
	cntl		un_tca->cntl
	dprintf		\#ifdef@DEBUG@printf
#endif
