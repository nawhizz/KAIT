/* isutil.c */
/*----------------------------------------------------------------------+
|									|
|	isutil : isam data file handling utility			|
|		 designed by HYSYS. 95. 10. 18				|
|									|
|		- compile : make ( UTIL/src/isutil )			|
|		- execution : isutil ( UTIL/ )				|
|									|
|	1. Service ane Function						|
|		- Show isamfile information.				|
|		- BackUp to SAMFile and Generate Information file	|
|		- Load SAMFile with Information file ( BUILD/APPEND )	|
|		- BUILD isam file Only.					|
|		- Data Conversion.					|
|									|
|	2. Usage							|
|	   isutil <-options> action fpath				|
|		- no option, no args	: help usage summary		|
|		- <options>						|
|			-a : append					|
|			-t : assume text data				|
|			     NULL -> SPACE Conversion			|
|			     record delimeter -> LF			|
|			     TAB -> SPACE converdion when loading	|
|			-h : help detail usage, example, descriptions	|
|			-y : if error occur, then continue		|
|			-n : if error occur, then break			|
|		- <action>						|
|			s  : show isam file information			|
|			b  : backup isam data to sam ( .sam & .isi )	|
|			l  : load sam data ( .sam & .isi ) to isam	|
|			     if no isam file then build			|
|			       if no dam then build only		|
|			       else build and add data			|
|			     else if '-a' option then append		|
|			     else error					|
|			i  : index operation only (.isi file used only) |
|			c  : make isam info ( .isi )			|
|									|
+----------------------------------------------------------------------*/

/*----------------------------------------------------------------------+
|	include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdarg.h>	/* #include <varargs.h> */

#ifdef		WIN32
#include	<io.h>
#include	<sys/timeb.h>
#define		R_OK	4
#else
#include	<sys/time.h>
#include	<unistd.h>
#endif

#include	<time.h>
#include	<ctype.h>

#include	"cbuni.h"

#include	"iswrap.h"	/* #include	<isam.h> */

/*----------------------------------------------------------------------+
|	defines								|
+----------------------------------------------------------------------*/
#define		MAXNKEY		26	/* # of indexes of a table */

/* Define control character value */
#define		CH_EOF		((unsigned char)-1)
#define		CH_NULL		'\0'

/* "isutil" Options */
#define		OPT_APP		1	/* append */
#define		OPT_TXT		2	/* text data */
#define		OPT_HLP		4
#define		OPT_YES		8	/* if error, continue & commit */
#define		OPT_NO		16	/* if error, break & rollback */

/* isam index handling options */
#define		IDX_ADD		1		/* add index */
#define		IDX_DRP		2		/* drop index */

/*----------------------------------------------------------------------+
|	Structure defines						|
+----------------------------------------------------------------------*/
struct	KEYINFOtag	{
	int	keytype;	/* ISNODUPS/ISDUPS/COMPRESS */
	int	nparts;		/* # of columns consist of index */
	int	offset[NPARTS];	/* offset of column */
	int	length[NPARTS];	/* length of column */
	int	type[NPARTS];	/* var. type of column */
	int	opt;		/* ADD/DROP */
};

struct	FILEINFOtag	{
	int	recsize;	/* size of record */
	int	keycnt;		/* # of indexes */
	struct	KEYINFOtag	key[MAXNKEY];
};

/*----------------------------------------------------------------------+
|	sub processing functions					|
+----------------------------------------------------------------------*/
/* before	SUNOS	4.X
int
FPRINTF( va_alist )
va_dcl
*/
int
FPRINTF( int kind, FILE *fd, char *format, ... )
{
/* before	SUNOS	4.X
	FILE	*fd;
	int	kind;
	char	*format;
*/
	va_list	lvar;
	int	ret;

	va_start( lvar, format );
/* before	SUNOS	4.X
	va_start( lvar );
	kind = va_arg( lvar, int );
	fd = va_arg( lvar, FILE * );
	format = va_arg( lvar, char * );
*/
	if( kind == 1 )		/* Output is file */
		ret = vfprintf( fd, format, lvar );
	else			/* Output is screen */
		ret = vprintf( format, lvar );
	va_end( lvar );

	return(ret);
}

/*---------------------------------------------------------------------*/
void
#if defined( __CB_STDC__ )
get_date_time( char *timestr )
#else
get_date_time(timestr)
char	*timestr;
#endif
{
#ifdef	WIN32
	struct	_timeb	mytime;
#else
        struct  timeval mytime;
#endif
        struct  tm	*mytm;

#ifdef	WIN32
        _ftime( &mytime );
        mytm = localtime( &mytime.time );
#else
        gettimeofday( &mytime, (void *)0 );
        mytm = localtime( &(mytime.tv_sec) );
#endif
	sprintf(timestr,"%4.4d/%2.2d/%2.2d %2.2d:%2.2d:%2.2d\n",
		1900+mytm->tm_year, mytm->tm_mon+1, mytm->tm_mday,
		mytm->tm_hour, mytm->tm_min, mytm->tm_sec);
}

/*---------------------------------------------------------------------*/
void
#if defined( __CB_STDC__ )
disp_head( int kind, FILE *inffd, char *fileid, struct dictinfo *dic )
#else
disp_head( kind, inffd, fileid, dic )
int	kind;
FILE	*inffd;
char	*fileid;
struct	dictinfo	*dic;
#endif
{
	char	timestr[22];

	FPRINTF( kind, inffd, ".ISAMINFO\n" );
	FPRINTF( kind, inffd, "\tFILE-PATH\t%s (.dat/.idx)\n", fileid );
	get_date_time( timestr );
	FPRINTF( kind, inffd, "\tWORK-DATE\t%s\n", timestr );

	FPRINTF( kind, inffd, ".RECSIZE\t%d\n", dic->di_recsize );
	FPRINTF( kind, inffd, ".NOOFDATA\t%d\n", dic->di_nrecords );
}

/*---------------------------------------------------------------------*/
char *
#if defined( __CB_STDC__ )
get_type( int type )
#else
get_type( type )
int	type;
#endif
{
	switch( type )
	{
	case	CHARTYPE	:	return( "CHARTYPE" );
#if	CHARTYPE != DECIMALTYPE
	case	DECIMALTYPE	:	return( "DECIMALTYPE" );
#endif
	case	INTTYPE		:	return( "INTTYPE" );
	case	LONGTYPE	:	return( "LONGTYPE" );
	case	DOUBLETYPE	:	return( "DOUBLETYPE" );
	case	FLOATTYPE	:	return( "FLOATTYPE" );
	default			:	return( "NOTYPE" );
	}
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
get_type_num( char *type )
#else
get_type_num( type )
char	*type;
#endif
{
	if( !strcmp( type, "CHARTYPE" ) )
		return(	CHARTYPE );
	else if( !strcmp( type, "INTTYPE" ) )
		return( INTTYPE );
	else if( !strcmp( type, "LONGTYPE" ) )
		return( LONGTYPE );
	else if( !strcmp( type, "FLOATTYPE" ) )
		return( FLOATTYPE );
	else if( !strcmp( type, "DOUBLETYPE" ) )
		return( DOUBLETYPE );
	else if( !strcmp( type, "DECIMALTYPE" ) )
		return( DECIMALTYPE );
	else
		return( -1 );
}

/*---------------------------------------------------------------------*/
void
#if defined( __CB_STDC__ )
disp_key( int kind, int level, FILE *inffd, struct keydesc *key )
#else
disp_key( kind, level, inffd, key )
int		kind;
int		level;	/* if 1 then primary key else secondary key */
FILE		*inffd;
struct	keydesc	*key;
#endif
{
	register	i;
	char		tmp[100];

	if( level == 1 )
		FPRINTF( kind, inffd, ".PKEY\n" );
	else
		FPRINTF( kind, inffd, ".SKEY\n");

	tmp[0]=0;
	if( key->k_flags & ISDUPS )
		strcat( tmp, "ISDUPS" );
	else
		strcat( tmp, "ISNODUPS" );

	if( key->k_flags & DCOMPRESS )
		strcat( tmp, " + DCOMPRESS" );

	if( key->k_flags & LCOMPRESS )
		strcat( tmp, " + LCOMPRESS" );

	if( key->k_flags & TCOMPRESS )
		strcat( tmp, " + TCOMPRESS" );

	if( key->k_flags & COMPRESS )
		strcat( tmp, " + COMPRESS" );

/* DISAM not support. 98.03.13 ******************************
	if( key->k_flags & ISCLUSTER )
		strcat( tmp, " + ISCLUSTER" );
************************************************************/

	FPRINTF( kind, inffd, "\t%s\n", tmp );

	FPRINTF( kind, inffd, "\tNKEYPARTS\t%d\n", key->k_nparts );
	for( i=0; i<key->k_nparts; i++ )
	{
		FPRINTF( kind, inffd, "\t%d\t%d\t%s\n",
			key->k_part[i].kp_start,
			key->k_part[i].kp_leng,
			get_type( key->k_part[i].kp_type ) );
	}
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
isam_data_check( unsigned char *data, int size )
#else
isam_data_check( data, size )
unsigned char	*data;
int		size;
#endif
{
	register	i;

	for( i=0; i<size; i++ )
	{
		if( data[i] == CH_NULL )	data[i] = ' ';
		else if( data[i] == CH_EOF )	return( -1 );
		else if( iscntrl( data[i] ) )	return( -2 );
	}

	for( i=size-1; i>=0; i-- )
		if( data[i] != ' ' )
			break;

	return( i+1 );
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
sam_check_data( unsigned char *data, int size )
#else
sam_check_data( data, size )
unsigned char	*data;
int		size;
#endif
{
	register	i;

	for( i=0; i<size; i++ )
	{
		if( data[i] == CH_NULL )
			data[i] = ' ';
		else if( data[i] == CH_EOF )	return( -1 );
		else if( iscntrl( data[i] ) )	return( -2 );
	}

	return( 0 );
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
GetStr( FILE *fd, char *str )
#else
GetStr( fd, str )
FILE	*fd;
char	*str;
#endif
{
static	char	tmpbuff[256];

	for( ; ; )
	{
		if( feof( fd ) )
			return( -1 );
		if( fscanf( fd, "%s", str ) != 1 )
			return( -2 );
		if( str[0] == '#' )	/* #이후는 모두 무시한다 */
		{
			if( fseek( fd, -1 * strlen(str), SEEK_CUR ) != 0 )
				return( -3 );
			if( fgets( tmpbuff, sizeof tmpbuff, fd ) == (char *)0 )
				return( -4 );
		}
		else
			return( 0 );
	}
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
rd_cur_line( FILE *fd )	/* read current line data and throw that */
#else
rd_cur_line( fd )
FILE	*fd;
#endif
{
	if( fseek( fd, -2, SEEK_CUR ) )
		return( -1 );

	while( fgetc( fd ) != '\n' )
	{
		if( feof( fd ) )
			return( -2 );
	}

	return( 0 );
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
get_fileinfo( char *fileid, struct FILEINFOtag *fileinfo )
#else
get_fileinfo( fileid, fileinfo )
char			*fileid;
struct	FILEINFOtag	*fileinfo;
#endif
{
	int	i;
	char	inffname[80];
	FILE	*inffd;
	char	str[100];
	int	pk_flg=0;

	strcpy( inffname, fileid );
	strcat( inffname, ".isi" );
	if( ( inffd = fopen ( inffname, "rb" ) ) == (FILE *)0 )
	{
		printf( ">> %s information file not exist....\n", inffname );
		return( -1 );
	}

	/* initialize fileinfo buff */
	memset( fileinfo, 0, sizeof( struct FILEINFOtag ) );

	while( !feof( inffd ) )
	{
		if( GetStr( inffd, str ) < 0 )
			break;

		/* Description */

		if( !strcmp( str, ".ISAMINFO" ) ||
		    !strcmp( str, "FILE-PATH" ) ||
		    !strcmp( str, "WORK-DATE" ) ||
		    !strcmp( str, ".NOOFDATA" ) )
		{
			if( rd_cur_line( inffd ) < 0 )
			{
			printf( ">> information file format incorrect ..\n" );
				fclose( inffd );
				return( -2 );
			}
		}
		else if( !strcmp( str, ".RECSIZE" ) )
		{
			if( GetStr( inffd, str ) < 0 )
			{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (invalid record size)\n" );
				fclose( inffd );
				return( -3 );
			}
			fileinfo->recsize = atoi( str );
		}

		else if( !strcmp( str, ".PKEY" ) || !strcmp( str, ".SKEY") )
		{
			if( !strcmp( str, ".PKEY" ) )
				pk_flg++;
			if( pk_flg > 1 )
			{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (.PKEY is more than once)\n" );
				fclose( inffd );
				return( -4 );
			}

			fileinfo->keycnt++;
		}

		/* Index handling */
		else if( !strcmp( str, "ADD" ) )
		{
			if( fileinfo->keycnt != 0 )
				fileinfo->key[fileinfo->keycnt-1].opt = IDX_ADD;
		}
		else if( !strcmp( str, "DROP" ) )
		{
			if( fileinfo->keycnt != 0 )
				fileinfo->key[fileinfo->keycnt-1].opt = IDX_DRP;
		}

		/* index flag */
		else if( !strcmp( str, "ISNODUPS" ) )
		{
			if( fileinfo->keycnt != 0 )
			fileinfo->key[fileinfo->keycnt-1].keytype += ISNODUPS;
		}
		else if( !strcmp( str, "ISDUPS" ) )
		{
			if( fileinfo->keycnt != 0 )
			fileinfo->key[fileinfo->keycnt-1].keytype += ISDUPS;
		}
		else if( !strcmp( str, "COMPRESS" ) )
		{
			if( fileinfo->keycnt != 0 )
			fileinfo->key[fileinfo->keycnt-1].keytype += COMPRESS;
		}
		else if( !strcmp( str, "LCOMPRESS" ) )
		{
			if( fileinfo->keycnt != 0 )
			fileinfo->key[fileinfo->keycnt-1].keytype += LCOMPRESS;
		}
		else if( !strcmp( str, "TCOMPRESS" ) )
		{
			if( fileinfo->keycnt != 0 )
			fileinfo->key[fileinfo->keycnt-1].keytype += TCOMPRESS;
		}
		else if( !strcmp( str, "DCOMPRESS" ) )
		{
			if( fileinfo->keycnt != 0 )
			fileinfo->key[fileinfo->keycnt-1].keytype += DCOMPRESS;
		}
		else if( !strcmp( str, "+" ) )
			continue;

		else if( !strcmp( str, "NKEYPARTS" ) )
		{
			if( fileinfo->keycnt == 0 )
			{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (invalid position : " );
			printf( "a number of key parts)\n" );
				fclose( inffd );
				return( -6 );
			}

			if( GetStr( inffd, str ) < 0 )
			{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (invalid a number of key parts)\n" );
				fclose( inffd );
				return( -5 );
			}
			fileinfo->key[fileinfo->keycnt-1].nparts = atoi(str);
			if( fileinfo->key[fileinfo->keycnt-1].nparts <= 0 ||
			    fileinfo->key[fileinfo->keycnt-1].nparts > NPARTS )
			{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (invalid a number of key parts)\n" );
				fclose( inffd );
				return( -6 );
			}

			for( i=0;
			     i<fileinfo->key[fileinfo->keycnt-1].nparts;
			     i++ )
			{
				if( GetStr( inffd, str ) < 0 )
				{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (offset of %dth column in %dth index)\n",
							i+1, fileinfo->keycnt );
					fclose( inffd );
					return( -7 );
				}
				fileinfo->key[fileinfo->keycnt-1].offset[i]
					= atoi(str);

				if( GetStr( inffd, str ) < 0 )
				{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (length of %dth column in %dth index)\n",
							i+1, fileinfo->keycnt );
					fclose( inffd );
					return( -8 );
				}
				fileinfo->key[fileinfo->keycnt-1].length[i]
					= atoi(str);

				/* Column Type */
				if( GetStr( inffd, str ) < 0 )
				{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (type of %dth column in %dth index)\n",
							i+1, fileinfo->keycnt );
					fclose( inffd );
					return( -9 );
				}

				fileinfo->key[fileinfo->keycnt-1].type[i]
					= get_type_num( str );
				if( fileinfo->key[fileinfo->keycnt-1].type[i]
					< 0 )
				{
			printf( ">> information file format incorrect ..\n" );
			printf( "   (invalid type (%s) ", str );
			printf( "of %dth column in %dth index)\n",
							i+1, fileinfo->keycnt );
					fclose( inffd );
					return( -10 );
				}
			} /* end of for ( index column ) */
		} /* end of else if ( NKEYPARTS )  */
		else
		{
			printf( ">> information file format incorrect ..\n" );
			printf( "   %s is used, but not supported!!!\n", str );
			fclose( inffd );
			return( -11 );
		}

	} /* end of while */

	fclose( inffd );

	return( 0 );
}

/*---------------------------------------------------------------------*/
void
#if defined( __CB_STDC__ )
set_keydesc( int pos, struct FILEINFOtag *fileinfo, struct keydesc *key )
#else
set_keydesc( pos, fileinfo, key )
int	pos;
struct	FILEINFOtag	*fileinfo;
struct	keydesc		*key;
#endif
{
	/* fileinfo.key[pos] --> key */
	register	i;

	key->k_flags = fileinfo->key[pos].keytype;
	key->k_nparts = fileinfo->key[pos].nparts;
	for( i=0; i<fileinfo->key[pos].nparts; i++ )
	{
		key->k_part[i].kp_start = fileinfo->key[pos].offset[i];
		key->k_part[i].kp_leng = fileinfo->key[pos].length[i];
		key->k_part[i].kp_type = fileinfo->key[pos].type[i];
	}
}

/*---------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
add_index( int isfd, struct FILEINFOtag *fileinfo )
#else
add_index( isfd, fileinfo )
int			isfd;
struct	FILEINFOtag	*fileinfo;
#endif
{
	register	i;
	struct	keydesc	key;

	for( i=1; i<fileinfo->keycnt; i++ )
	{
		set_keydesc( i, fileinfo, &key );

		if( isaddindex( isfd, &key ) < 0 )
		{
			printf( ">> Add %dth index error!!!(%d)\n",
				i+1, iserrno );
			return( -1 );
		}

		printf( ">> %dth index creation complete...\n", i+1 );
	}

	return( 0 );
}

/*---------------------------------------------------------------------*/
void
#if defined( __CB_STDC__ )
isutil_usage( void )
#else
isutil_usage()
#endif
{
	printf( "\n\n" );
	printf( ">> USAGE.\n" );
	printf( "   isutil <-options> action filepath\n" );
	printf( "\t Options\t-a : append\n" );
	printf( "\t        \t-t : assume text data\n" );
	printf( "\t        \t-h : help detail usage, example, descriptions\n" );
	printf( "\t        \t-y : if error occurs, then continue\n" );
	printf( "\t        \t-n : if error occurs, then break\n" );
	printf( "\t Action \ts : show isam file information\n" );
	printf( "\t        \tb : backup isam file to sam\n" );
	printf( "\t        \tl : load sam data to isam file\n" );
	printf( "\t        \ti : index operation only ( .isi file used only )\n" );
	printf( "\t        \tc : make isam info ( make .isi file )\n" );
	printf( "\t filepath\t:file path without extension\n" );
	printf( "\n" );
}

/*----------------------------------------------------------------------+
|	create isam index information					|
|	INPUP ISAM	: fileid					|
|	OUTPUT SAM	: fileid.isi					|
+----------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
isutil_info( char *fileid, int opt, int out)
#else
isutil_info( fileid, opt, out )
char	*fileid;
int	opt;
int	out;		/* if 1 then write in samfile else display on screen */
#endif
{
	register	i;
	char		inffname[80];
	FILE		*inffd;
	int		isfd;
	struct	dictinfo dic;
	struct	keydesc  key;

	if( ( isfd = isopen( fileid, ISINPUT+ ISAUTOLOCK ) ) < 0 )
	{
		printf( ">> isam file open error(%d) !!!\n", iserrno );
		return( -1 );
	}

	if( isindexinfo( isfd, (struct keydesc *)&dic, 0 ) < 0 )
	{
		printf( ">> isindexinfo(0 level) error(%d) !!!\n", iserrno );
		isclose( isfd );
		return( -2 );
	}

	if( out == 1 )
	{
		strcpy( inffname, fileid );
		strcat( inffname, ".isi" );

		if( ( inffd = fopen( inffname, "w" ) ) == (FILE *)0 )
		{
			printf( ">> %s file open error!!!\n", inffname );
			isclose( isfd );
			return( -4 );
		}
	}

	disp_head( out, inffd, fileid, &dic );

	for( i=1; i<=dic.di_nkeys; i++ )
	{
		if( isindexinfo( isfd, &key, i ) < 0 )
		{
			printf( ">> isindexinfo(%d key) error(%d) !!!\n",
								i, iserrno );
			break;
		}
		disp_key( out, i, inffd, &key );
	}

	if( out == 1 )
		fclose( inffd );
	isclose( isfd );

	return( 0 );
}

/*----------------------------------------------------------------------+
|	backup data from isam to sam					|
|	INPUP ISAM	: fileid					|
|	OUTPUT SAM	: fileid.sam					|
+----------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
isutil_backup( char *fileid, int opt )
#else
isutil_backup( fileid, opt )
char	*fileid;
int	opt;
#endif
{
	int			isfd;
	struct	dictinfo	dic;
	char			sampath[80];
	char			*data;
	FILE			*samfd;
	char			fmode[4];
	int			redcnt, addcnt, errcnt;
	int			recsize;

	strcpy( sampath, fileid );
	strcat( sampath, ".sam" );

	printf( "\n" );
	printf( ">> input isam file name = %s\n", fileid );
	printf( ">> output sam file name = %s\n", sampath );

	/* Generate Information file */
	if( isutil_info( fileid, opt, 1 ) < 0 )
	{
		printf( ">> Error in creating information file(%s.isi)\n",
								fileid );
		printf( ">> Make or update information file in manual...\n" );
		printf( ">> Continue data backup...\n" );
	}

	/* For Output */
	if( access( sampath, R_OK ) == 0 )      /* if isamfile exist */
	{
		if( ! ( opt & OPT_APP ) )
		{
			printf( ">> SAM File already exist !!!\n" );
			printf( ">> if you wants load samdata " );
			printf( "then use -a option!!!\n" );
			printf( ">> Job Ended...\n" );
			return( -1 );
		}
	}

	if( opt & OPT_APP )
		strcpy( fmode, "a" );
	else
		strcpy( fmode, "w" );
	if( !( opt & OPT_TXT ) )
		strcat( fmode, "b" );

	if( ( samfd = fopen( sampath, fmode ) ) == (FILE *)0 )
	{
		printf( ">> SAM File [%s] open ERROR \n", sampath );
		return( -2 );
	}

	if( ( isfd = isopen( fileid, ISINPUT+ ISAUTOLOCK ) ) < 0 )
	{
		printf( ">> isam file open error(%d)...", iserrno );
		fclose( samfd );
		return( -3 );
	}

	if( isindexinfo( isfd, (struct keydesc *)&dic, 0 ) < 0 )
	{
		printf( ">> get isam index information error(%d)...", iserrno );
		fclose( samfd );
		isclose( isfd );
		return( -4 );
	}

	printf( "\n" );
	printf( ">> isam file record size : %d bytes\n\n", dic.di_recsize );
	printf( ">> Total isam Data       : %d records.\n", dic.di_nrecords );

	printf( "\n>> Extracting data.....\n\n" );

	if( ( data = (char *) malloc( dic.di_recsize + 1 ) ) == (char *)0 )
	{
		printf( ">> memory allocation error..." );
		fclose( samfd );
		isclose( isfd );
		return( -5 );
	}

	if( isread( isfd, data, ISFIRST ) < 0 )
	{
		printf( ">> isam first read error(%d)", iserrno );
		isclose( isfd );
		fclose( samfd );
		free( data );
		return( -6 );
	}

	recsize = dic.di_recsize;
	for( redcnt=1, addcnt=0, errcnt=0; ; )
	{
		if( opt & OPT_TXT )
		if( ( recsize = isam_data_check( (unsigned char *)data,
						dic.di_recsize ) ) < 0 )
		{
			errcnt++;
			printf( ">> There are non-text character(s) " );
			printf( "in %dth record...\n", redcnt);
			break;
		}

		data[recsize] = '\n';		/* total size = recsize + 1 */

		if( (int)fwrite( data, recsize+1, 1, samfd ) < 1 )
		{
			errcnt++;
			printf(">> Can't write data in SAMFile(=%s)...\n",
				sampath);
			break;
		}
		else
			addcnt++;

		if( isread( isfd, data, ISNEXT ) < 0 )
		{
			printf("## Last isam function return code=[%d]\n",
				iserrno );
				break;
		}
		else
			redcnt++;
	}

	isclose( isfd );
	fclose( samfd );
	free( data );

	/* print_result */
	printf( ">> Total isam Data   = %d records.\n", dic.di_nrecords );
	printf( ">> Total READ Data   = %d records. \n", redcnt );
	printf( ">> Total BackUp Data = %d records. \n", addcnt );
	printf( ">> Total Error Data  = %d records. \n", errcnt );
	printf( ">> isam data backup End !!!\n" );

	return( 0 );
}

/*----------------------------------------------------------------------+
|	load data from sam to isam					|
|	INPUP SAM	: fileid.sam & fileid.isi			|
|	OUTPUT ISAM	: fileid.dat * fileid.idx ( isam data file )	|
+----------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
isutil_load( char *fileid, int opt )
#else
isutil_load( fileid, opt )
char	*fileid;
int	opt;
#endif
{
	char			samfname[20];
	char			tmp[100];
	FILE			*samfd;
	char			fmode[4];

	int			isfd;			/* For isam file */
	struct	keydesc		key;
	struct	dictinfo	dic;
	char			logfile[128];

	struct	FILEINFOtag	fileinfo;
	int			redcnt=0, addcnt=0,errcnt=0;
	int			recsize=0;			/* isam file length */
	int			redsize=0;			/* read sam data length */
	char			*data;

	printf("\n>> isam data file loading........\n\n");

	strcpy( samfname, fileid );
	strcat( samfname, ".sam" );

	printf( ">> INPUT SAM Data file name    : %s\n", samfname );
	printf( ">> INPUT information file name : %s.isi\n", fileid );
	printf( ">> OUTPUT isam Data file name  : %s\n", fileid );

	strcpy( tmp, fileid );
	strcat( tmp, ".idx" );
	if( access( tmp, R_OK ) == 0 )      /* if isam file exist */
	{
		if( ! ( opt & OPT_APP ) )	/* Option is not Append */
		{
			printf( ">> isamfile already exists!!!\n" );
			printf( ">> if you wants load samdata " );
			printf( "then use -a option!!!\n" );
			return( -1 );
		}
		
		/* open isam file for load data */
		if( ( isfd = isopen( fileid, ISINOUT+ISEXCLLOCK ) ) < 0 )
		{
			printf( ">> isam file open error!!!(%d)\n",  iserrno );
			return( -2 );
		}

		if( isindexinfo( isfd, (struct keydesc *)&dic, 0 ) < 0 )
		{
			printf( ">> Get isam information error(%d)...\n",
				iserrno );
			isclose( isfd );
			return( -3 );
		}
		recsize = dic.di_recsize;
	}
	else
	{	/* not exist isam file so create isam file */
		if( get_fileinfo( fileid, &fileinfo ) < 0 )
		{
			printf( ">> %s.isi file format incorrect!!!\n", fileid );
			return( -4 );
		}
		recsize = fileinfo.recsize;
		set_keydesc( 0, &fileinfo, &key );

		isfd = isbuild( fileid, recsize, &key, ISINOUT+ISEXCLLOCK );
		if( isfd < 0 )
		{
			printf( ">> isam file creation error!!!(%d)\n",
								iserrno );
			return( -5 );
		}
		printf( ">> isam File Careation Complete.....\n" );

		add_index( isfd, &fileinfo );
	}

	/* open sam file */
	strcpy( fmode, "r" );
	if( !( opt & OPT_TXT ) )
		strcat( fmode, "b" );
	if( ( samfd = fopen( samfname, fmode ) ) == (FILE *)0 )
	{
		isclose( isfd );
		if( opt & OPT_APP )
		{
			printf( ">> samdata(%s) not exists !!!\n", samfname );
			return( -8 );
		}
		printf( ">> isamfile(%s) creation completed!!!\n", fileid );
		return( 0 );
	}

	printf( ">> isamfile record size = %d\n", recsize );

#ifdef	WIN32
	GetTempPath( sizeof logfile, logfile );
	sprintf( &logfile[strlen(logfile)], "\\isutil_%d.log",
		GetCurrentProcessId() );
#else
	sprintf( logfile, "/tmp/isutil_%06d.log", getpid() );
#endif
	if( islogopen( logfile ) < 0 )
	{
		printf( ">> isam logging file open error!!!(%d)\n", iserrno );
		isclose( isfd );
		fclose( samfd );
		return( -9 );
	}

	if( isbegin() < 0 )
	{
		printf( ">> transactin start error!!!(%d)\n", iserrno );
		isclose( isfd );
		islogclose();
		unlink( logfile );
		fclose( samfd );
		return( -9 );
	}

	/* read sam file and insert data isam file */
	if( ( data = (char *) malloc( recsize + 10 ) ) == (char *)0 )
	{
		printf( ">> memory allocation error !!!\n" );
		isclose( isfd );
		islogclose();
		unlink( logfile );
		fclose( samfd );
		return( -9 );
	}

	for( redcnt=0,addcnt=0,errcnt=0; !feof( samfd ); )
	{
		if( opt & OPT_TXT )
		{
			/* read data size = recsize + LF + NULL */
			if( fgets( data, recsize+2, samfd ) == (char *)0 )
				break;

			/* skip data after recsize in one line */
			if( (int)strlen( data ) > recsize )
			{
				if( data[strlen(data)-1] != '\n' )
				{
					while( fgetc(samfd) != '\n' )
						if( feof(samfd) )
							break;
				}
				redsize = recsize;
			}
			else
				redsize = strlen( data ) - 1;
		}
		else
		{
			redsize = (int)fread( data, 1, recsize, samfd );
			if( redsize == 0 )
				break;
			if( redsize < recsize )
			{
				errcnt++;
				printf( ">> %th read data ", redcnt + 1 );
				printf( "less than record size\n" );
				printf( ">> FIRST 40 byte => %40.40s\n", data );
				if( opt & OPT_YES )
					continue;
				else if( opt & OPT_NO )
					break;
				printf( ">> Do you want to Stop(y)" );
				printf( "/Continue(n) ? => " );
				scanf( "%s", tmp );
				if( tmp[0] == 'Y' && tmp[0] == 'y' )
					break;
			}

			/* read LF */
			fread( &data[recsize], 1, 1, samfd );
			if( data[recsize] == '\r' )
				fread( &data[recsize+1], 1, 1, samfd );

			redsize = recsize;
		}
		redcnt++;

		if( opt & OPT_TXT )
		{
			/* 읽은 자료만큼만 검사 */
			if( sam_check_data( (unsigned char *)data, redsize )
				< 0 )
			{
				errcnt++;
				printf( ">> There are non-text character(s) " );
				printf( "in %dth record...\n", redcnt);
				break;
			}

			memset( &data[ redsize ], ' ', recsize - redsize );
		}

		if( iswrite( isfd, data ) < 0 )
		{
			errcnt++;
			printf( ">> Error in adding %dth record (%d)\n",
							redcnt, iserrno );
			printf( ">> FIRST 40 byte => %40.40s\n", data );

			if( opt & OPT_YES )
				continue;
			else if( opt & OPT_NO )
				break;
			printf( ">> Do you want to Stop(y)/Continue(n) ? => " );
			scanf( "%s", tmp );
			if( tmp[0] == 'Y' && tmp[0] == 'y' )
				break;
		}
		else
			addcnt++;
	} /* end of for */

	if( errcnt != 0 )
	{
		if( opt & OPT_YES )
			iscommit();
		else if( opt & OPT_NO )
		{
			isrollback();
			errcnt += addcnt;
			addcnt = 0;
		}
		else
		{
			printf(">> Do you want Commit(Y) or Rollback(N)? ");
			scanf( "%s", tmp );
			if( tmp[0] == 'Y' && tmp[0] == 'y' )
				iscommit();
			else
			{
				isrollback();
				errcnt += addcnt;
				addcnt=0;
			}
		}
	}
	else
		iscommit();

	/* close files */
	fclose( samfd );
	islogclose();
	isclose( isfd );
	unlink( logfile );

	/* display results */
	printf( ">> Total READ Data     = %d records. \n", redcnt );
	printf( ">> Total Inserted Data = %d records. \n", addcnt );
	printf( ">> Total Error Data    = %d records. \n", errcnt );
	printf( "\n>> SAM(%s) Data loading Ended....\n\n", fileid );

	return( 0 );
}

/*----------------------------------------------------------------------+
|	isam index handler						|
|	INPUP ISAM	: fileid					|
|	INPUT SAM	: fileid.isi					|
+----------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
isutil_index ( char *fileid, int opt )
#else
isutil_index (fileid, opt)
char	*fileid;
int	opt;
#endif
{
	int			i;
	int			ret;
	int			isfd;
	struct	keydesc		key;
	struct	FILEINFOtag	fileinfo;

	if( ( isfd = isopen (fileid, ISINOUT+ISEXCLLOCK) ) < 0 )
	{
		printf( ">> isam file open error(%d) !!!\n", iserrno );
		return( -1 );
	}

	if( get_fileinfo( fileid, &fileinfo ) < 0 )
	{
		printf( ">> get isam information error....\n" );
		printf( "   please check %s.isi file...\n", fileid );
		printf( ">> Abnormally End....\n" );
		return( -2 );
	}

	for( i=0; i<fileinfo.keycnt; i++ )
	{
		/* Primary Key */
		if( i==0 &&
		    (fileinfo.key[i].opt == IDX_ADD ||
		     fileinfo.key[i].opt == IDX_DRP) )
		{
			printf( ">> Priamary key  could't be updated!!!\n" );
			continue;
		}

		if( fileinfo.key[i].opt == IDX_ADD )
		{
			set_keydesc( i, &fileinfo, &key );
			if( ( ret = isaddindex( isfd, &key ) ) < 0 )
			{
				printf( ">> %dth index add error!!!(%d)\n",
					i+1, iserrno );
				break;
			}
			else
				printf( ">> %dth index add OK!!!\n", i+1 );
		}
		else if( fileinfo.key[i].opt == IDX_DRP )
		{
			set_keydesc( i, &fileinfo, &key );
			ret = isdelindex( isfd, &key );
			if( ret < 0 )
			{
				printf( ">> %dth index drop error!!!(%d)\n",
					i+1, iserrno );
				break;
			}
			else
				printf( ">> %dth index drop OK!!!\n", i+1 );
		}
	}

	isclose( isfd );

	printf( ">> Job End !!!\n" );
	return( 0 );
}

/*----------------------------------------------------------------------+
|	Create index information file					|
|	INPUP ISAM	: fileid					|
|	OUTPUT SAM	: fileid.isi					|
+----------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
isutil_makeinf( char *fileid, int opt )
#else
isutil_makeinf( fileid, opt )
char	*fileid;
int	opt;
#endif
{
	printf( "\n>> input isam file name = %s\n", fileid );
	printf( ">> output sam file name = %s.isi\n", fileid );

	/* Generate Information file */
	if( isutil_info( fileid, opt, 1 ) < 0 )
	{
		printf( ">> Error in creating information file(%s.isi)\n",
								fileid );
		printf( ">> Make or update information file in manual...\n" );
	}
	else
		printf( ">> information file(%s.isi) created\n", fileid );

	return(0);
}

/*----------------------------------------------------------------------+
|	isutil helper							|
+----------------------------------------------------------------------*/
void
#if defined( __CB_STDC__ )
isutil_help( void )
#else
isutil_help()
#endif
{

printf("\n\n");
printf("isam file handling utilty for backup/load/index handling.\n" );
printf("\n");
printf("1.  Functions\n");
printf("\t. isam data build information\n" );
printf("\t. backup data to sam file.\n");
printf("\t. load sam file data into isam file\n" );
printf("\t. build isam file.\n");
printf("\t. data conversion.\n");
printf("\n");
printf("2. Usage.\n");
printf("\tisutil [-options] action filename\n");
printf("\t<options>  a : add data from samfile into existing isam file.\n" );
printf("\t           t : assume only text data in isamfile.\n" );
printf("\t              (TAB,CR,LF,EOF should not be contained in isamfile.\n");
printf("\t              ( all NULLs will be replaced with SPACEs.\n" );
printf("\t           h : Show Help.\n" );
printf("\t<action>   s : Show build information.\n" );
printf("\t               ( filename, date, recsize, no of records, \n" );
printf("\t                  index information, ...\n");
printf("\t           b : backup isamfile into sam file (FILENAME.sam).\n" );
printf("\t               create FILENAME.isi also.\n" );
printf("\t               if used togethre with <-t>, all NULLs will be \n" );
printf("\t                  replaced into SPACEs.\n" );
printf("\t           l : load data from samfile into isamfile.\n" );
printf("\t               FILE.isi file should be in the same directory.\n" );
printf("\t               If no FILENAME.sam file, then only build isam.\n" );
printf("\t               if with -a option, then data will be added \n" );
printf("\t               into existing isam file. ( error if no isamfile).\n" );
printf("\t           i : Add or remove index into existing isam file.\n" );
printf("\t               Index information must be defined in FILENAME.isi.\n");
printf("\t               'DROP' to drop index, 'ADD' to add index.\n" );
printf("\n");
printf("3. File Formats.\n" );
printf("\t< SAM file >\n");
printf("\t    .  filename : FILENAME.sam\n");
printf("\t    .  format\n");
printf("\t        +---------------------------------------------------+ \n" );
printf("\t        |   RECORD + LF                                     |\n");
printf("\t        |     ......                                        |\n");
printf("\n");
printf("\t< INFO file >\n");
printf("\t    .  filename : FILENAME.isi\n");
printf("\t    .  format\n");
printf("\t        +---------------------------------------------------+\n");
printf("\t        |  .ISAMINFO                                       |\n");
printf("\t        |        FILE PATH       /home3/data/FILE          |\n");
printf("\t        |        WORK DATE       1995/11/01 13:40:20       |\n");
printf("\t        |  .RECSIZE        120             # record size   |\n");
printf("\t        |  .NOOFDATA       1875            # no of records |\n");
printf("\t        |  .PKEY                                           |\n");
printf("\t        |        ISNODUPS + COMPRESS       #               |\n");
printf("\t        |        NKEYPARTS       3         # no of columns |\n");
printf("\t        |        0       8       CHARTYPE                  |\n");
printf("\t        |        10      3       CHARTYPE                  |\n");
printf("\t        |        20      17      CHARTYPE                  |\n");
printf("\t        |  .SKEY                           #Secondary Key  |\n");
printf("\t        |        ISNODUPS                                  |\n");
printf("\t        |        NKEYPARTS       3         #no of columns  |\n");
printf("\t        |        10      3       CHARTYPE                  |\n");
printf("\t        |        0       8       CHARTYPE                  |\n");
printf("\t        |        20      17      CHARTYPE                  |\n");
printf("\t        +---------------------------------------------------+\n");
printf("\t        - .ISAMINFO : general information such as date, name..\n" );
printf("\t        - .RECSIZE  : record size in bytes.\n");
printf("\t        - .NOOFDATA : no of records in isam file.\n" );
printf("\t        - INDEX Information:\n");
printf("\t          .PKEY : Primaray Index information.\n" );
printf("\t          .SKEY : Primaray Index information.\n" );
printf("\t                  repeated by no of indexes.\n" );
printf("\t                  mark 'DROP'/'ADD' after PKEY/.SKEY to \n" );
printf("\t                       drop or add index.\n" );
printf("\t          ISNODUPS : Type of index.\n" );
printf("\t              (ISDUPS,LCOMPRESS/DCOMPRESS/TCOMPRESS/COMPRESS) \n");
printf("\t          NKEYPARTS : no of columns for index.\n" );
printf("\t          Repeat column information by NKEYPARTS :\n" );
printf("\t                  column offset, length, type.\n" );
printf("\t                  available types : CHARTYPE/INTTYPE\n");
printf("\t                       /LOGNTYPY/DOUBLETYPE/FLOATTYPE/DECIMALTYPE\n");
printf("\n");
/*--------NOT TRANSLATED YET-----
printf("4. Example\n");
printf("\t·  isutil -h\n");
printf("\t        : show usage help.\n" );
printf("\t·  isutil s  FILE\n");
printf("\t        : show isam information. similar to FILE.isi.\n" );
printf("\t·  isutil  b  FILE\n");
printf("\t        : 주어진 isam 화일 (FILE.dat/FILE.idx)의 자료를 백업 받는다.\n");
printf("\t          기존 isam 화일의 생성정보화일(FILE.isi)을 생성한다.\n");
printf("\t          FILE.sam 화일이 기존에 존재하는 경우 오류처리된다.\n");
printf("\t·  isutil -t b FILE\n");
printf("\t        : FILE명의 isam 자료를 읽어 FILE.sam 화일에 자료를 백업받\n");
printf("\t          는다. 또한 FILE.isi화일에 isam 화일의 생성정보를 생성시\n");
printf("\t          킨다. 읽은 isam 자료값중에 NULL이 들어있는 경우에는\n");
printf("\t          SPACE로 값을 바꾸어 백업한다.  자료값에 TAB, LF, CR, EOF\n");
printf("\t          등이 들어있는 경우에는 오류로서 작업을 중단한다.\n");
printf("\t·  isutil -a b FILE\n");
printf("\t        : 기존에 FILE.sam 화일이 존재하는 경우에는 isam 자료를\n");
printf("\t          APPEND 시킨다.\n");
printf("\t·  isutil -at b FILE\n");
printf("\t    isutil -a -t b FILE\n");
printf("\t        : isam 생성정보화일을 만든다 ( FILE.isi )\n");
printf("\t          isam 화일을 읽고 자료를 FILE.sam에 백업받는다. 만일 .sam\n");
printf("\t          화일이 존재하는 경우에는 기존화일에 자료를 추가한다.\n");
printf("\t          자료값에 NULL, TAB, LF, CR, EOF 등이 있는지를 검사한다.\n");
printf("\t·  isutil l FILE\n");
printf("\t        : isam 화일을 생성하고 SAM DATA를 로드한다.\n");
printf("\t          FILE.isi 화일이 반드시 있어야 한다.\n");
printf("\t          FILE.isi에 있는 모든 인덱스가 생성된다.\n");
printf("\t·  isutil -t l FILE\n");
printf("\t        : FILE.isi 화일이 반드시 있어야 한다.\n");
printf("\t          isam 화일을 생성한다. ( FILE.dat, FILE.idx 가 생성됨 )\n");
printf("\t          FILE.sam을 읽고 자료를 로드한다.  읽은 자료중에 NULL값이\n");
printf("\t          있는 경우에는 이를 SPACE로 변환시키며, TAB, LF, CR, EOF\n");
printf("\t          값인 경우에는 오류로서 작업을 중지한다.\n");
printf("\t          기존에 isam 화일이 존재하는 경우에는 오류처리된다.\n");
printf("\t·  isutil -a l FILE\n");
printf("\t        : FILE.isi 화일이 반드시 있어야 한다.\n");
printf("\t          만일 isam 화일이 존재하지 않는 경우에는 isam 화일을 생성\n");
printf("\t          한후 자료를 로드한다.\n");
printf("\t·  isutil -at l FILE\n");
printf("\t    isutil -a -t l FILE\n");
printf("\t        : sam 화일을 읽고 자료를 isam 화일에 로드한다.  만일 isam\n");
printf("\t          화일이 존재하는 경우에는 기존화일에 자료를 추가한다.\n");
printf("\t          자료값에 NULL, TAB, LF, CR, EOF 등이 있는지를 검사한다.\n");
printf("\t·  isutil i FILE\n");
printf("\t        : FILE.isi 에 있는 인덱스에 대한 변경작업을 한다.\n");
printf("\t          작업하고자 하는 isam 화일이 생성되어 있어야 한다.\n");
printf("\t          생성되어 있는 인덱스에 대한 삭제 및 새로운 인덱스의 생성\n");
printf("\t          작업이 가능하다.  사용하고자 하는 FILE.isi의 구조는 다음\n");
printf("\t          과 같다.\n");
printf("\t ┌──────────────────────────────┐\n");
printf("\t │   .ISAMINFO                       # ignored when loading   │\n");
printf("\t │           FILE PATH       /home3/data/FILE (.dat/.idx)     │\n");
printf("\t │      ......                                                │\n");
printf("\t │   .SKEY   ADD                     # ADD index              │\n");
printf("\t │           ISNODUPS                                         │\n");
printf("\t │           NKEYPARTS       3                                │\n");
printf("\t │           10      3       CHARTYPE                         │\n");
printf("\t │           0       8       CHARTYPE                         │\n");
printf("\t │           20      17      CHARTYPE                         │\n");
printf("\t │   .SKEY   DROP                    # DROP index             │\n");
printf("\t │           ISNODUPS + LCOMPRESS                             │\n");
printf("\t │           NKEYPARTS       3                                │\n");
printf("\t │           25      4       CHARTYPE                         │\n");
printf("\t │           20      17      CHARTYPE                         │\n");
printf("\t │           0       8       CHARTYPE                         │\n");
printf("\t │   .SKEY                           # REMAIN as it is        │\n");
printf("\t │           ISDUPS                                           │\n");
printf("\t │           NKEYPARTS       3                                │\n");
printf("\t │           0       8       CHARTYPE                         │\n");
printf("\t │           20      17      CHARTYPE                         │\n");
printf("\t │           10      3       CHARTYPE                         │\n");
printf("\t └──────────────────────────────┘\n");
printf("\t          이때, 두번째 인덱스( .SKEY DROP )는 삭제되고, 세번째 인\n");
printf("\t          덱스( .SKEY ADD )는 새로 생성된다.\n");
printf("\n");
printf("5. DATA CONVERSION\n");
printf("\t· isam 화일의 컬럼구조 및 인덱스 구조가 변경되었을 경우에 사용한다.\n");
printf("\t· TEXT DATA 인 경우에만 적용이 가능하다.\n");
printf("\t· 작업순서\n");
printf("\t     1. 자료를 백업받는다.\n");
printf("\t          -. isutil -t b FILE\n");
printf("\t     2. 데이타자료와 정보화일을 수정한다.\n");
printf("\t          -. 자료화일에는 추가 및 삭제된 컬럼에 대한 수정을 한다.\n");
printf("\t          -. 정보화일에는 삭제 및 새로 생성될 인덱스에 대한 변경");
printf("\t             여부를 수정한다.\n");
printf("\t     3. 새로운 자료를 로드한다.\n");
printf("\t          -. 기존에 사용하던 isam 화일은 미리 삭제한다.\n");
printf("\t          -. isutil -t l FILE\n");
printf("\t◎ 기존의 isam 화일에 인덱스 사항만 변경이 되는 경우에는 정보화일\n");
printf("\t   에 대한 수정과 함께 'isutil i FILE'을 사용한다.\n");
printf("\n");
printf("6. 기타사항\n");
printf("\t· 자료백업시 : 옵션을 사용하지 않는 경우에는 모든 데이타타입이\n");
printf("\t                가능하다. 그러나 '-t' 옵션을 사용하는 경우에는\n");
printf("\t                NULL 데이타인 경우에는 SPACE로 변경하여주며,\n");
printf("\t                TAB,CR,LF,EOF 등의 값이 있는 경우에는 오류처리\n");
printf("\t                된다.\n");
printf("\t· 자료로드시 : 옵션을 사용하지 않는 경우에는 모든 데이타타입이\n");
printf("\t                가능하다. 그러나 '-t' 옵션을 사용하는 경우에는\n");
printf("\t                NULL 데이타인 경우에는 SPACE로 값을 변경하여준다.\n");
printf("\t                그러나 TAB,CR,LF,EOF 등의 값이 있는 경우에는\n");
printf("\t                오류처리 된다.\n");
printf("\t                레코드와 레코드 사이의 구분자는 LF 한 문자이다.\n");
printf("\t· DATA CONVERSION\n");
printf("\t              : TEXT DATA TYPE인 경우에만 가능하다.\n");
printf("\t                자료 백업 및 로드시 적용되는 제한점을 참조한다.\n");
printf("\n");
--------------------------------------*/
printf("---------------------------End of HELP(isutil)---------------------------\n");


/* - HANGUL ------
printf("\n\n");
printf("isam 화일을 사용하기 위한 유틸리티로서, isam 자료의 백업, 로드, 인덱스\n");
printf("isam file handling utilty for backup/load/index handling.\n" );
printf("핸들링 및 isam화일의 생성 정보를 볼 수 있다.\n");
printf("\n");
printf("1.  용도 및 기능\n");
printf("\t· isam 자료의 생성정보를 보여준다.\n");
printf("\t· isam 화일의 자료를 SAM 화일로 백업받는다.\n");
printf("\t· SAM 화일 자료를 isam 화일로 로드한다.\n");
printf("\t· isam 화일을 생성한다.\n");
printf("\t· 자료를 변경시킨다 ( Data Conversion )\n");
printf("\n");
printf("2. 사용법\n");
printf("\tisutil [-options] action filename\n");
printf("\t<options>  a : 기존에 있던자료에 추가한다.\n");
printf("\t           t : 백업 또는 로드하고자 하는 자료가 텍스트 자료임을\n");
printf("\t               의미한다. ( 이 옵션을 사용하는 경우에는 TAB, CR\n");
printf("\t               LF, EOF 등의 자료값은 허용하지 않으며, NULL인 경");
printf("\t               우에는 SPACE로 바꾸어준다 )\n");
printf("\t           h : 유틸리티 사용에 대한 상세한 내용을 보여준다.\n");
printf("\t               ( 사용법, 예제, 제한점, 특징 등 )\n");
printf("\t<action>   s : isam 화일에 대한 생성정보를 보여준다.\n");
printf("\t               ( 화일명, 작업일자, 레코드크기, 레코드 갯수, 인\n");
printf("\t                덱스 정보 등 )\n");
printf("\t           b : isam 자료를 SAM으로 백업받는다. 이때 기존 isam\n");
printf("\t               화일의 생성정보를 FILENAME.isi로 생성한다. 만일\n");
printf("\t               <-t> 옵션을 사용한 경우에는 자료에 들어있는 NULL\n");
printf("\t               값을 SPACE로 변환하여 준다.  생성되는 SAM 화일명\n");
printf("\t               은 FILENAME.sam 이다.\n");
printf("\t           l : SAM 자료를 isam 화일에 로드한다.\n");
printf("\t               이때 isam 화일에 대한 생성정보를 참조하기 위해\n");
printf("\t               FILE.isi 화일이 반드시 같은 디렉토리에 존재해야\n");
printf("\t               한다.  만일 SAM 자료화일(FILENAME.sam) 이 존재하\n");
printf("\t               지 않는 경우에는 단순히 isam 화일만 생성시켜준다\n");
printf("\t               -a 옵션을 사용하는 경우에는 기존 isam화일에 자료\n");
printf("\t               를 추가한다.  기존 isam 화일이 존재하는 상태에서\n");
printf("\t               -a 옵션을 사용하지 않았다면 오류처리 된다.\n");
printf("\t           i : 존재하는 isam 화일에 대한 인덱스 내용을 수정한다.\n");
printf("\t               수정 가능한 내용은 인덱스의 생성 및 삭제이다.\n");
printf("\t               사용 방법은 FILENAME.isi 화일에 삭제하고자 하는\n");
printf("\t               인덱스는 'DROP'을 새로 생성하고자 하는 인덱스에\n");
printf("\t               는 'ADD'를 첨가한다.\n");
printf("\n");
printf("3. 화일의 구조\n");
printf("\t● 백업 SAM 화일\n");
printf("\t    ·  화일명 : FILENAME.sam\n");
printf("\t    ·  화일구조\n");
printf("\t        ┌─────────────────────────┐\n");
printf("\t        │  RECORD + LF                                     │\n");
printf("\t        │     ......                                       │\n");
printf("\n");
printf("\t● 정보화일\n");
printf("\t    ·  화일명 : FILENAME.isi\n");
printf("\t    ·  화일구조\n");
printf("\t        ┌─────────────────────────┐\n");
printf("\t        │  .ISAMINFO                                       │\n");
printf("\t        │        FILE PATH       /home3/data/FILE          │\n");
printf("\t        │        WORK DATE       1995/11/01 13:40:20       │\n");
printf("\t        │  .RECSIZE        120             # 레코드크기    │\n");
printf("\t        │  .NOOFDATA       1875            # 레코드갯수    │\n");
printf("\t        │  .PKEY                                           │\n");
printf("\t        │        ISNODUPS + COMPRESS       #               │\n");
printf("\t        │        NKEYPARTS       3         # 인덱스컬럼갯수│\n");
printf("\t        │        0       8       CHARTYPE                  │\n");
printf("\t        │        10      3       CHARTYPE                  │\n");
printf("\t        │        20      17      CHARTYPE                  │\n");
printf("\t        │  .SKEY                           #Secondary Key  │\n");
printf("\t        │        ISNODUPS                                  │\n");
printf("\t        │        NKEYPARTS       3         #컬럼수         │\n");
printf("\t        │        10      3       CHARTYPE                  │\n");
printf("\t        │        0       8       CHARTYPE                  │\n");
printf("\t        │        20      17      CHARTYPE                  │\n");
printf("\t        └─────────────────────────┘\n");
printf("\t        - .ISAMINFO : isam 화일에 대한 화일명과 작업날짜 및 시간등\n");
printf("\t                      을 표시한다.\n");
printf("\t        - .RECSIZE : isam 화일의 레코드 크기를 표시한다.\n");
printf("\t        - .NOOFDATA : isam 화일에 있는 레코드의 갯수를 표시한다.\n");
printf("\t        - 인덱스 정보의 표현\n");
printf("\t          .PKEY : isam의 기본인덱스에 대한 정보를 표시한다.\n");
printf("\t          .SKEY : isam의 Secondary 인덱스에 대한 정보를 표시한다.\n");
printf("\t                  Secondary 인덱스의 갯수만큼 반복된다.\n");
printf("\t                  인덱스를 생성/삭제하고자 하는경우에는\n");
printf("\t                  .PKEY/.SKEY 다음에 'DROP'/'ADD'를 첨가한다.\n");
printf("\t          ISNODUPS : 인덱스 생성타입을 지정하여 준다. ( ISDUPS,\n");
printf("\t                     LCOMPRESS/DCOMPRESS/TCOMPRESS/COMPRESS 등이\n");
printf("\t                     사용 가능하다. )\n");
printf("\t          NKEYPARTS : 인덱스를 구성하는 컬럼의 갯수를 지정한다.\n");
printf("\t          NKEYPARTS에 지정된 수만큼의 컬럼정보가 표시된다.\n");
printf("\t                  컬럼 시작위치/길이/타입 정보가 표시된다.\n");
printf("\t                  사용 가능한 컬럼타입 : CHARTYPE/INTTYPE\n");
printf("\t                       /LOGNTYPY/DOUBLETYPE/FLOATTYPE/DECIMALTYPE\n");
printf("\n");
printf("4. 사용예\n");
printf("\t·  isutil -h\n");
printf("\t        : isutil의 자세한 사용법을 보여준다.\n");
printf("\t·  isutil s  FILE\n");
printf("\t        : FILE에 대한 생성 정보를 보여준다.\n");
printf("\t          보여지는 정보는 정보화일 (FILE.isi)의 내용과 같다.\n");
printf("\t·  isutil  b  FILE\n");
printf("\t        : 주어진 isam 화일 (FILE.dat/FILE.idx)의 자료를 백업 받는다.\n");
printf("\t          기존 isam 화일의 생성정보화일(FILE.isi)을 생성한다.\n");
printf("\t          FILE.sam 화일이 기존에 존재하는 경우 오류처리된다.\n");
printf("\t·  isutil -t b FILE\n");
printf("\t        : FILE명의 isam 자료를 읽어 FILE.sam 화일에 자료를 백업받\n");
printf("\t          는다. 또한 FILE.isi화일에 isam 화일의 생성정보를 생성시\n");
printf("\t          킨다. 읽은 isam 자료값중에 NULL이 들어있는 경우에는\n");
printf("\t          SPACE로 값을 바꾸어 백업한다.  자료값에 TAB, LF, CR, EOF\n");
printf("\t          등이 들어있는 경우에는 오류로서 작업을 중단한다.\n");
printf("\t·  isutil -a b FILE\n");
printf("\t        : 기존에 FILE.sam 화일이 존재하는 경우에는 isam 자료를\n");
printf("\t          APPEND 시킨다.\n");
printf("\t·  isutil -at b FILE\n");
printf("\t    isutil -a -t b FILE\n");
printf("\t        : isam 생성정보화일을 만든다 ( FILE.isi )\n");
printf("\t          isam 화일을 읽고 자료를 FILE.sam에 백업받는다. 만일 .sam\n");
printf("\t          화일이 존재하는 경우에는 기존화일에 자료를 추가한다.\n");
printf("\t          자료값에 NULL, TAB, LF, CR, EOF 등이 있는지를 검사한다.\n");
printf("\t·  isutil l FILE\n");
printf("\t        : isam 화일을 생성하고 SAM DATA를 로드한다.\n");
printf("\t          FILE.isi 화일이 반드시 있어야 한다.\n");
printf("\t          FILE.isi에 있는 모든 인덱스가 생성된다.\n");
printf("\t·  isutil -t l FILE\n");
printf("\t        : FILE.isi 화일이 반드시 있어야 한다.\n");
printf("\t          isam 화일을 생성한다. ( FILE.dat, FILE.idx 가 생성됨 )\n");
printf("\t          FILE.sam을 읽고 자료를 로드한다.  읽은 자료중에 NULL값이\n");
printf("\t          있는 경우에는 이를 SPACE로 변환시키며, TAB, LF, CR, EOF\n");
printf("\t          값인 경우에는 오류로서 작업을 중지한다.\n");
printf("\t          기존에 isam 화일이 존재하는 경우에는 오류처리된다.\n");
printf("\t·  isutil -a l FILE\n");
printf("\t        : FILE.isi 화일이 반드시 있어야 한다.\n");
printf("\t          만일 isam 화일이 존재하지 않는 경우에는 isam 화일을 생성\n");
printf("\t          한후 자료를 로드한다.\n");
printf("\t·  isutil -at l FILE\n");
printf("\t    isutil -a -t l FILE\n");
printf("\t        : sam 화일을 읽고 자료를 isam 화일에 로드한다.  만일 isam\n");
printf("\t          화일이 존재하는 경우에는 기존화일에 자료를 추가한다.\n");
printf("\t          자료값에 NULL, TAB, LF, CR, EOF 등이 있는지를 검사한다.\n");
printf("\t·  isutil i FILE\n");
printf("\t        : FILE.isi 에 있는 인덱스에 대한 변경작업을 한다.\n");
printf("\t          작업하고자 하는 isam 화일이 생성되어 있어야 한다.\n");
printf("\t          생성되어 있는 인덱스에 대한 삭제 및 새로운 인덱스의 생성\n");
printf("\t          작업이 가능하다.  사용하고자 하는 FILE.isi의 구조는 다음\n");
printf("\t          과 같다.\n");
printf("\t ┌──────────────────────────────┐\n");
printf("\t │   .ISAMINFO                       # ignored when loading   │\n");
printf("\t │           FILE PATH       /home3/data/FILE (.dat/.idx)     │\n");
printf("\t │      ......                                                │\n");
printf("\t │   .SKEY   ADD                     # ADD index              │\n");
printf("\t │           ISNODUPS                                         │\n");
printf("\t │           NKEYPARTS       3                                │\n");
printf("\t │           10      3       CHARTYPE                         │\n");
printf("\t │           0       8       CHARTYPE                         │\n");
printf("\t │           20      17      CHARTYPE                         │\n");
printf("\t │   .SKEY   DROP                    # DROP index             │\n");
printf("\t │           ISNODUPS + LCOMPRESS                             │\n");
printf("\t │           NKEYPARTS       3                                │\n");
printf("\t │           25      4       CHARTYPE                         │\n");
printf("\t │           20      17      CHARTYPE                         │\n");
printf("\t │           0       8       CHARTYPE                         │\n");
printf("\t │   .SKEY                           # REMAIN as it is        │\n");
printf("\t │           ISDUPS                                           │\n");
printf("\t │           NKEYPARTS       3                                │\n");
printf("\t │           0       8       CHARTYPE                         │\n");
printf("\t │           20      17      CHARTYPE                         │\n");
printf("\t │           10      3       CHARTYPE                         │\n");
printf("\t └──────────────────────────────┘\n");
printf("\t          이때, 두번째 인덱스( .SKEY DROP )는 삭제되고, 세번째 인\n");
printf("\t          덱스( .SKEY ADD )는 새로 생성된다.\n");
printf("\n");
printf("5. DATA CONVERSION\n");
printf("\t· isam 화일의 컬럼구조 및 인덱스 구조가 변경되었을 경우에 사용한다.\n");
printf("\t· TEXT DATA 인 경우에만 적용이 가능하다.\n");
printf("\t· 작업순서\n");
printf("\t     1. 자료를 백업받는다.\n");
printf("\t          -. isutil -t b FILE\n");
printf("\t     2. 데이타자료와 정보화일을 수정한다.\n");
printf("\t          -. 자료화일에는 추가 및 삭제된 컬럼에 대한 수정을 한다.\n");
printf("\t          -. 정보화일에는 삭제 및 새로 생성될 인덱스에 대한 변경");
printf("\t             여부를 수정한다.\n");
printf("\t     3. 새로운 자료를 로드한다.\n");
printf("\t          -. 기존에 사용하던 isam 화일은 미리 삭제한다.\n");
printf("\t          -. isutil -t l FILE\n");
printf("\t◎ 기존의 isam 화일에 인덱스 사항만 변경이 되는 경우에는 정보화일\n");
printf("\t   에 대한 수정과 함께 'isutil i FILE'을 사용한다.\n");
printf("\n");
printf("6. 기타사항\n");
printf("\t· 자료백업시 : 옵션을 사용하지 않는 경우에는 모든 데이타타입이\n");
printf("\t                가능하다. 그러나 '-t' 옵션을 사용하는 경우에는\n");
printf("\t                NULL 데이타인 경우에는 SPACE로 변경하여주며,\n");
printf("\t                TAB,CR,LF,EOF 등의 값이 있는 경우에는 오류처리\n");
printf("\t                된다.\n");
printf("\t· 자료로드시 : 옵션을 사용하지 않는 경우에는 모든 데이타타입이\n");
printf("\t                가능하다. 그러나 '-t' 옵션을 사용하는 경우에는\n");
printf("\t                NULL 데이타인 경우에는 SPACE로 값을 변경하여준다.\n");
printf("\t                그러나 TAB,CR,LF,EOF 등의 값이 있는 경우에는\n");
printf("\t                오류처리 된다.\n");
printf("\t                레코드와 레코드 사이의 구분자는 LF 한 문자이다.\n");
printf("\t· DATA CONVERSION\n");
printf("\t              : TEXT DATA TYPE인 경우에만 가능하다.\n");
printf("\t                자료 백업 및 로드시 적용되는 제한점을 참조한다.\n");
printf("\n");
printf("---------------------------End of HELP(isutil)---------------------------\n");
*/
}

/*----------------------------------------------------------------------+
|	main								|
+----------------------------------------------------------------------*/
int
#if defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	int	i, j;
	int	opt=0;

	if( argc < 2 )
	{
		isutil_usage();
		return( 1 );
	}

	for( i=1; i < argc; i++ )
	{
		if( argv[i][0] == '-' )		/* Options */
		{
			for( j=1; argv[i][j]; j++ )
			{
				switch( argv[i][j] )
				{
				case	'a'	: opt += OPT_APP;	break;
				case	't'	: opt += OPT_TXT;	break;
				case	'h'	: opt += OPT_HLP;	break;
				case	'y'	: opt += OPT_YES;	break;
				case	'n'	: opt += OPT_NO ;	break;
				default		:
					isutil_usage();
					return( 2 );
				}
			}
		}
		else			/* Action */
		{
			/* if miss filename */
			if( i == argc - 1 )
			{
				isutil_usage();
				printf( ">> You must input isam file name.\n" );
				return( 4 );
			}

			switch( argv[i][0] )
			{
			case	's'	:
				return( isutil_info( argv[i+1], opt, 0 ) );
			case	'b'	:
				return( isutil_backup( argv[i+1], opt ) );
			case	'l'	:
				return( isutil_load( argv[i+1], opt ) );
			case	'i'	:
				return( isutil_index( argv[i+1], opt ) );
			case	'c'	:
				return( isutil_makeinf( argv[i+1], opt ) );
			default		:
				isutil_usage();
				return( 3 );
			}
		}
	} /* for(i) */

	if( opt & OPT_HLP )
		isutil_help();

	return( 0 );
}

/*---------------End of Program----------------------------------------*/
