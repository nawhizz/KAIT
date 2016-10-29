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
		if( str[0] == '#' )	/* #���Ĵ� ��� �����Ѵ� */
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
			/* ���� �ڷḸŭ�� �˻� */
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
printf("\t��  isutil -h\n");
printf("\t        : show usage help.\n" );
printf("\t��  isutil s  FILE\n");
printf("\t        : show isam information. similar to FILE.isi.\n" );
printf("\t��  isutil  b  FILE\n");
printf("\t        : �־��� isam ȭ�� (FILE.dat/FILE.idx)�� �ڷḦ ��� �޴´�.\n");
printf("\t          ���� isam ȭ���� ��������ȭ��(FILE.isi)�� �����Ѵ�.\n");
printf("\t          FILE.sam ȭ���� ������ �����ϴ� ��� ����ó���ȴ�.\n");
printf("\t��  isutil -t b FILE\n");
printf("\t        : FILE���� isam �ڷḦ �о� FILE.sam ȭ�Ͽ� �ڷḦ �����\n");
printf("\t          �´�. ���� FILE.isiȭ�Ͽ� isam ȭ���� ���������� ������\n");
printf("\t          Ų��. ���� isam �ڷᰪ�߿� NULL�� ����ִ� ��쿡��\n");
printf("\t          SPACE�� ���� �ٲپ� ����Ѵ�.  �ڷᰪ�� TAB, LF, CR, EOF\n");
printf("\t          ���� ����ִ� ��쿡�� �����μ� �۾��� �ߴ��Ѵ�.\n");
printf("\t��  isutil -a b FILE\n");
printf("\t        : ������ FILE.sam ȭ���� �����ϴ� ��쿡�� isam �ڷḦ\n");
printf("\t          APPEND ��Ų��.\n");
printf("\t��  isutil -at b FILE\n");
printf("\t    isutil -a -t b FILE\n");
printf("\t        : isam ��������ȭ���� ����� ( FILE.isi )\n");
printf("\t          isam ȭ���� �а� �ڷḦ FILE.sam�� ����޴´�. ���� .sam\n");
printf("\t          ȭ���� �����ϴ� ��쿡�� ����ȭ�Ͽ� �ڷḦ �߰��Ѵ�.\n");
printf("\t          �ڷᰪ�� NULL, TAB, LF, CR, EOF ���� �ִ����� �˻��Ѵ�.\n");
printf("\t��  isutil l FILE\n");
printf("\t        : isam ȭ���� �����ϰ� SAM DATA�� �ε��Ѵ�.\n");
printf("\t          FILE.isi ȭ���� �ݵ�� �־�� �Ѵ�.\n");
printf("\t          FILE.isi�� �ִ� ��� �ε����� �����ȴ�.\n");
printf("\t��  isutil -t l FILE\n");
printf("\t        : FILE.isi ȭ���� �ݵ�� �־�� �Ѵ�.\n");
printf("\t          isam ȭ���� �����Ѵ�. ( FILE.dat, FILE.idx �� ������ )\n");
printf("\t          FILE.sam�� �а� �ڷḦ �ε��Ѵ�.  ���� �ڷ��߿� NULL����\n");
printf("\t          �ִ� ��쿡�� �̸� SPACE�� ��ȯ��Ű��, TAB, LF, CR, EOF\n");
printf("\t          ���� ��쿡�� �����μ� �۾��� �����Ѵ�.\n");
printf("\t          ������ isam ȭ���� �����ϴ� ��쿡�� ����ó���ȴ�.\n");
printf("\t��  isutil -a l FILE\n");
printf("\t        : FILE.isi ȭ���� �ݵ�� �־�� �Ѵ�.\n");
printf("\t          ���� isam ȭ���� �������� �ʴ� ��쿡�� isam ȭ���� ����\n");
printf("\t          ���� �ڷḦ �ε��Ѵ�.\n");
printf("\t��  isutil -at l FILE\n");
printf("\t    isutil -a -t l FILE\n");
printf("\t        : sam ȭ���� �а� �ڷḦ isam ȭ�Ͽ� �ε��Ѵ�.  ���� isam\n");
printf("\t          ȭ���� �����ϴ� ��쿡�� ����ȭ�Ͽ� �ڷḦ �߰��Ѵ�.\n");
printf("\t          �ڷᰪ�� NULL, TAB, LF, CR, EOF ���� �ִ����� �˻��Ѵ�.\n");
printf("\t��  isutil i FILE\n");
printf("\t        : FILE.isi �� �ִ� �ε����� ���� �����۾��� �Ѵ�.\n");
printf("\t          �۾��ϰ��� �ϴ� isam ȭ���� �����Ǿ� �־�� �Ѵ�.\n");
printf("\t          �����Ǿ� �ִ� �ε����� ���� ���� �� ���ο� �ε����� ����\n");
printf("\t          �۾��� �����ϴ�.  ����ϰ��� �ϴ� FILE.isi�� ������ ����\n");
printf("\t          �� ����.\n");
printf("\t ����������������������������������������������������������������\n");
printf("\t ��   .ISAMINFO                       # ignored when loading   ��\n");
printf("\t ��           FILE PATH       /home3/data/FILE (.dat/.idx)     ��\n");
printf("\t ��      ......                                                ��\n");
printf("\t ��   .SKEY   ADD                     # ADD index              ��\n");
printf("\t ��           ISNODUPS                                         ��\n");
printf("\t ��           NKEYPARTS       3                                ��\n");
printf("\t ��           10      3       CHARTYPE                         ��\n");
printf("\t ��           0       8       CHARTYPE                         ��\n");
printf("\t ��           20      17      CHARTYPE                         ��\n");
printf("\t ��   .SKEY   DROP                    # DROP index             ��\n");
printf("\t ��           ISNODUPS + LCOMPRESS                             ��\n");
printf("\t ��           NKEYPARTS       3                                ��\n");
printf("\t ��           25      4       CHARTYPE                         ��\n");
printf("\t ��           20      17      CHARTYPE                         ��\n");
printf("\t ��           0       8       CHARTYPE                         ��\n");
printf("\t ��   .SKEY                           # REMAIN as it is        ��\n");
printf("\t ��           ISDUPS                                           ��\n");
printf("\t ��           NKEYPARTS       3                                ��\n");
printf("\t ��           0       8       CHARTYPE                         ��\n");
printf("\t ��           20      17      CHARTYPE                         ��\n");
printf("\t ��           10      3       CHARTYPE                         ��\n");
printf("\t ����������������������������������������������������������������\n");
printf("\t          �̶�, �ι�° �ε���( .SKEY DROP )�� �����ǰ�, ����° ��\n");
printf("\t          ����( .SKEY ADD )�� ���� �����ȴ�.\n");
printf("\n");
printf("5. DATA CONVERSION\n");
printf("\t�� isam ȭ���� �÷����� �� �ε��� ������ ����Ǿ��� ��쿡 ����Ѵ�.\n");
printf("\t�� TEXT DATA �� ��쿡�� ������ �����ϴ�.\n");
printf("\t�� �۾�����\n");
printf("\t     1. �ڷḦ ����޴´�.\n");
printf("\t          -. isutil -t b FILE\n");
printf("\t     2. ����Ÿ�ڷ�� ����ȭ���� �����Ѵ�.\n");
printf("\t          -. �ڷ�ȭ�Ͽ��� �߰� �� ������ �÷��� ���� ������ �Ѵ�.\n");
printf("\t          -. ����ȭ�Ͽ��� ���� �� ���� ������ �ε����� ���� ����");
printf("\t             ���θ� �����Ѵ�.\n");
printf("\t     3. ���ο� �ڷḦ �ε��Ѵ�.\n");
printf("\t          -. ������ ����ϴ� isam ȭ���� �̸� �����Ѵ�.\n");
printf("\t          -. isutil -t l FILE\n");
printf("\t�� ������ isam ȭ�Ͽ� �ε��� ���׸� ������ �Ǵ� ��쿡�� ����ȭ��\n");
printf("\t   �� ���� ������ �Բ� 'isutil i FILE'�� ����Ѵ�.\n");
printf("\n");
printf("6. ��Ÿ����\n");
printf("\t�� �ڷ����� : �ɼ��� ������� �ʴ� ��쿡�� ��� ����ŸŸ����\n");
printf("\t                �����ϴ�. �׷��� '-t' �ɼ��� ����ϴ� ��쿡��\n");
printf("\t                NULL ����Ÿ�� ��쿡�� SPACE�� �����Ͽ��ָ�,\n");
printf("\t                TAB,CR,LF,EOF ���� ���� �ִ� ��쿡�� ����ó��\n");
printf("\t                �ȴ�.\n");
printf("\t�� �ڷ�ε�� : �ɼ��� ������� �ʴ� ��쿡�� ��� ����ŸŸ����\n");
printf("\t                �����ϴ�. �׷��� '-t' �ɼ��� ����ϴ� ��쿡��\n");
printf("\t                NULL ����Ÿ�� ��쿡�� SPACE�� ���� �����Ͽ��ش�.\n");
printf("\t                �׷��� TAB,CR,LF,EOF ���� ���� �ִ� ��쿡��\n");
printf("\t                ����ó�� �ȴ�.\n");
printf("\t                ���ڵ�� ���ڵ� ������ �����ڴ� LF �� �����̴�.\n");
printf("\t�� DATA CONVERSION\n");
printf("\t              : TEXT DATA TYPE�� ��쿡�� �����ϴ�.\n");
printf("\t                �ڷ� ��� �� �ε�� ����Ǵ� �������� �����Ѵ�.\n");
printf("\n");
--------------------------------------*/
printf("---------------------------End of HELP(isutil)---------------------------\n");


/* - HANGUL ------
printf("\n\n");
printf("isam ȭ���� ����ϱ� ���� ��ƿ��Ƽ�μ�, isam �ڷ��� ���, �ε�, �ε���\n");
printf("isam file handling utilty for backup/load/index handling.\n" );
printf("�ڵ鸵 �� isamȭ���� ���� ������ �� �� �ִ�.\n");
printf("\n");
printf("1.  �뵵 �� ���\n");
printf("\t�� isam �ڷ��� ���������� �����ش�.\n");
printf("\t�� isam ȭ���� �ڷḦ SAM ȭ�Ϸ� ����޴´�.\n");
printf("\t�� SAM ȭ�� �ڷḦ isam ȭ�Ϸ� �ε��Ѵ�.\n");
printf("\t�� isam ȭ���� �����Ѵ�.\n");
printf("\t�� �ڷḦ �����Ų�� ( Data Conversion )\n");
printf("\n");
printf("2. ����\n");
printf("\tisutil [-options] action filename\n");
printf("\t<options>  a : ������ �ִ��ڷῡ �߰��Ѵ�.\n");
printf("\t           t : ��� �Ǵ� �ε��ϰ��� �ϴ� �ڷᰡ �ؽ�Ʈ �ڷ�����\n");
printf("\t               �ǹ��Ѵ�. ( �� �ɼ��� ����ϴ� ��쿡�� TAB, CR\n");
printf("\t               LF, EOF ���� �ڷᰪ�� ������� ������, NULL�� ��");
printf("\t               �쿡�� SPACE�� �ٲپ��ش� )\n");
printf("\t           h : ��ƿ��Ƽ ��뿡 ���� ���� ������ �����ش�.\n");
printf("\t               ( ����, ����, ������, Ư¡ �� )\n");
printf("\t<action>   s : isam ȭ�Ͽ� ���� ���������� �����ش�.\n");
printf("\t               ( ȭ�ϸ�, �۾�����, ���ڵ�ũ��, ���ڵ� ����, ��\n");
printf("\t                ���� ���� �� )\n");
printf("\t           b : isam �ڷḦ SAM���� ����޴´�. �̶� ���� isam\n");
printf("\t               ȭ���� ���������� FILENAME.isi�� �����Ѵ�. ����\n");
printf("\t               <-t> �ɼ��� ����� ��쿡�� �ڷῡ ����ִ� NULL\n");
printf("\t               ���� SPACE�� ��ȯ�Ͽ� �ش�.  �����Ǵ� SAM ȭ�ϸ�\n");
printf("\t               �� FILENAME.sam �̴�.\n");
printf("\t           l : SAM �ڷḦ isam ȭ�Ͽ� �ε��Ѵ�.\n");
printf("\t               �̶� isam ȭ�Ͽ� ���� ���������� �����ϱ� ����\n");
printf("\t               FILE.isi ȭ���� �ݵ�� ���� ���丮�� �����ؾ�\n");
printf("\t               �Ѵ�.  ���� SAM �ڷ�ȭ��(FILENAME.sam) �� ������\n");
printf("\t               �� �ʴ� ��쿡�� �ܼ��� isam ȭ�ϸ� ���������ش�\n");
printf("\t               -a �ɼ��� ����ϴ� ��쿡�� ���� isamȭ�Ͽ� �ڷ�\n");
printf("\t               �� �߰��Ѵ�.  ���� isam ȭ���� �����ϴ� ���¿���\n");
printf("\t               -a �ɼ��� ������� �ʾҴٸ� ����ó�� �ȴ�.\n");
printf("\t           i : �����ϴ� isam ȭ�Ͽ� ���� �ε��� ������ �����Ѵ�.\n");
printf("\t               ���� ������ ������ �ε����� ���� �� �����̴�.\n");
printf("\t               ��� ����� FILENAME.isi ȭ�Ͽ� �����ϰ��� �ϴ�\n");
printf("\t               �ε����� 'DROP'�� ���� �����ϰ��� �ϴ� �ε�����\n");
printf("\t               �� 'ADD'�� ÷���Ѵ�.\n");
printf("\n");
printf("3. ȭ���� ����\n");
printf("\t�� ��� SAM ȭ��\n");
printf("\t    ��  ȭ�ϸ� : FILENAME.sam\n");
printf("\t    ��  ȭ�ϱ���\n");
printf("\t        ������������������������������������������������������\n");
printf("\t        ��  RECORD + LF                                     ��\n");
printf("\t        ��     ......                                       ��\n");
printf("\n");
printf("\t�� ����ȭ��\n");
printf("\t    ��  ȭ�ϸ� : FILENAME.isi\n");
printf("\t    ��  ȭ�ϱ���\n");
printf("\t        ������������������������������������������������������\n");
printf("\t        ��  .ISAMINFO                                       ��\n");
printf("\t        ��        FILE PATH       /home3/data/FILE          ��\n");
printf("\t        ��        WORK DATE       1995/11/01 13:40:20       ��\n");
printf("\t        ��  .RECSIZE        120             # ���ڵ�ũ��    ��\n");
printf("\t        ��  .NOOFDATA       1875            # ���ڵ尹��    ��\n");
printf("\t        ��  .PKEY                                           ��\n");
printf("\t        ��        ISNODUPS + COMPRESS       #               ��\n");
printf("\t        ��        NKEYPARTS       3         # �ε����÷�������\n");
printf("\t        ��        0       8       CHARTYPE                  ��\n");
printf("\t        ��        10      3       CHARTYPE                  ��\n");
printf("\t        ��        20      17      CHARTYPE                  ��\n");
printf("\t        ��  .SKEY                           #Secondary Key  ��\n");
printf("\t        ��        ISNODUPS                                  ��\n");
printf("\t        ��        NKEYPARTS       3         #�÷���         ��\n");
printf("\t        ��        10      3       CHARTYPE                  ��\n");
printf("\t        ��        0       8       CHARTYPE                  ��\n");
printf("\t        ��        20      17      CHARTYPE                  ��\n");
printf("\t        ������������������������������������������������������\n");
printf("\t        - .ISAMINFO : isam ȭ�Ͽ� ���� ȭ�ϸ�� �۾���¥ �� �ð���\n");
printf("\t                      �� ǥ���Ѵ�.\n");
printf("\t        - .RECSIZE : isam ȭ���� ���ڵ� ũ�⸦ ǥ���Ѵ�.\n");
printf("\t        - .NOOFDATA : isam ȭ�Ͽ� �ִ� ���ڵ��� ������ ǥ���Ѵ�.\n");
printf("\t        - �ε��� ������ ǥ��\n");
printf("\t          .PKEY : isam�� �⺻�ε����� ���� ������ ǥ���Ѵ�.\n");
printf("\t          .SKEY : isam�� Secondary �ε����� ���� ������ ǥ���Ѵ�.\n");
printf("\t                  Secondary �ε����� ������ŭ �ݺ��ȴ�.\n");
printf("\t                  �ε����� ����/�����ϰ��� �ϴ°�쿡��\n");
printf("\t                  .PKEY/.SKEY ������ 'DROP'/'ADD'�� ÷���Ѵ�.\n");
printf("\t          ISNODUPS : �ε��� ����Ÿ���� �����Ͽ� �ش�. ( ISDUPS,\n");
printf("\t                     LCOMPRESS/DCOMPRESS/TCOMPRESS/COMPRESS ����\n");
printf("\t                     ��� �����ϴ�. )\n");
printf("\t          NKEYPARTS : �ε����� �����ϴ� �÷��� ������ �����Ѵ�.\n");
printf("\t          NKEYPARTS�� ������ ����ŭ�� �÷������� ǥ�õȴ�.\n");
printf("\t                  �÷� ������ġ/����/Ÿ�� ������ ǥ�õȴ�.\n");
printf("\t                  ��� ������ �÷�Ÿ�� : CHARTYPE/INTTYPE\n");
printf("\t                       /LOGNTYPY/DOUBLETYPE/FLOATTYPE/DECIMALTYPE\n");
printf("\n");
printf("4. ��뿹\n");
printf("\t��  isutil -h\n");
printf("\t        : isutil�� �ڼ��� ������ �����ش�.\n");
printf("\t��  isutil s  FILE\n");
printf("\t        : FILE�� ���� ���� ������ �����ش�.\n");
printf("\t          �������� ������ ����ȭ�� (FILE.isi)�� ����� ����.\n");
printf("\t��  isutil  b  FILE\n");
printf("\t        : �־��� isam ȭ�� (FILE.dat/FILE.idx)�� �ڷḦ ��� �޴´�.\n");
printf("\t          ���� isam ȭ���� ��������ȭ��(FILE.isi)�� �����Ѵ�.\n");
printf("\t          FILE.sam ȭ���� ������ �����ϴ� ��� ����ó���ȴ�.\n");
printf("\t��  isutil -t b FILE\n");
printf("\t        : FILE���� isam �ڷḦ �о� FILE.sam ȭ�Ͽ� �ڷḦ �����\n");
printf("\t          �´�. ���� FILE.isiȭ�Ͽ� isam ȭ���� ���������� ������\n");
printf("\t          Ų��. ���� isam �ڷᰪ�߿� NULL�� ����ִ� ��쿡��\n");
printf("\t          SPACE�� ���� �ٲپ� ����Ѵ�.  �ڷᰪ�� TAB, LF, CR, EOF\n");
printf("\t          ���� ����ִ� ��쿡�� �����μ� �۾��� �ߴ��Ѵ�.\n");
printf("\t��  isutil -a b FILE\n");
printf("\t        : ������ FILE.sam ȭ���� �����ϴ� ��쿡�� isam �ڷḦ\n");
printf("\t          APPEND ��Ų��.\n");
printf("\t��  isutil -at b FILE\n");
printf("\t    isutil -a -t b FILE\n");
printf("\t        : isam ��������ȭ���� ����� ( FILE.isi )\n");
printf("\t          isam ȭ���� �а� �ڷḦ FILE.sam�� ����޴´�. ���� .sam\n");
printf("\t          ȭ���� �����ϴ� ��쿡�� ����ȭ�Ͽ� �ڷḦ �߰��Ѵ�.\n");
printf("\t          �ڷᰪ�� NULL, TAB, LF, CR, EOF ���� �ִ����� �˻��Ѵ�.\n");
printf("\t��  isutil l FILE\n");
printf("\t        : isam ȭ���� �����ϰ� SAM DATA�� �ε��Ѵ�.\n");
printf("\t          FILE.isi ȭ���� �ݵ�� �־�� �Ѵ�.\n");
printf("\t          FILE.isi�� �ִ� ��� �ε����� �����ȴ�.\n");
printf("\t��  isutil -t l FILE\n");
printf("\t        : FILE.isi ȭ���� �ݵ�� �־�� �Ѵ�.\n");
printf("\t          isam ȭ���� �����Ѵ�. ( FILE.dat, FILE.idx �� ������ )\n");
printf("\t          FILE.sam�� �а� �ڷḦ �ε��Ѵ�.  ���� �ڷ��߿� NULL����\n");
printf("\t          �ִ� ��쿡�� �̸� SPACE�� ��ȯ��Ű��, TAB, LF, CR, EOF\n");
printf("\t          ���� ��쿡�� �����μ� �۾��� �����Ѵ�.\n");
printf("\t          ������ isam ȭ���� �����ϴ� ��쿡�� ����ó���ȴ�.\n");
printf("\t��  isutil -a l FILE\n");
printf("\t        : FILE.isi ȭ���� �ݵ�� �־�� �Ѵ�.\n");
printf("\t          ���� isam ȭ���� �������� �ʴ� ��쿡�� isam ȭ���� ����\n");
printf("\t          ���� �ڷḦ �ε��Ѵ�.\n");
printf("\t��  isutil -at l FILE\n");
printf("\t    isutil -a -t l FILE\n");
printf("\t        : sam ȭ���� �а� �ڷḦ isam ȭ�Ͽ� �ε��Ѵ�.  ���� isam\n");
printf("\t          ȭ���� �����ϴ� ��쿡�� ����ȭ�Ͽ� �ڷḦ �߰��Ѵ�.\n");
printf("\t          �ڷᰪ�� NULL, TAB, LF, CR, EOF ���� �ִ����� �˻��Ѵ�.\n");
printf("\t��  isutil i FILE\n");
printf("\t        : FILE.isi �� �ִ� �ε����� ���� �����۾��� �Ѵ�.\n");
printf("\t          �۾��ϰ��� �ϴ� isam ȭ���� �����Ǿ� �־�� �Ѵ�.\n");
printf("\t          �����Ǿ� �ִ� �ε����� ���� ���� �� ���ο� �ε����� ����\n");
printf("\t          �۾��� �����ϴ�.  ����ϰ��� �ϴ� FILE.isi�� ������ ����\n");
printf("\t          �� ����.\n");
printf("\t ����������������������������������������������������������������\n");
printf("\t ��   .ISAMINFO                       # ignored when loading   ��\n");
printf("\t ��           FILE PATH       /home3/data/FILE (.dat/.idx)     ��\n");
printf("\t ��      ......                                                ��\n");
printf("\t ��   .SKEY   ADD                     # ADD index              ��\n");
printf("\t ��           ISNODUPS                                         ��\n");
printf("\t ��           NKEYPARTS       3                                ��\n");
printf("\t ��           10      3       CHARTYPE                         ��\n");
printf("\t ��           0       8       CHARTYPE                         ��\n");
printf("\t ��           20      17      CHARTYPE                         ��\n");
printf("\t ��   .SKEY   DROP                    # DROP index             ��\n");
printf("\t ��           ISNODUPS + LCOMPRESS                             ��\n");
printf("\t ��           NKEYPARTS       3                                ��\n");
printf("\t ��           25      4       CHARTYPE                         ��\n");
printf("\t ��           20      17      CHARTYPE                         ��\n");
printf("\t ��           0       8       CHARTYPE                         ��\n");
printf("\t ��   .SKEY                           # REMAIN as it is        ��\n");
printf("\t ��           ISDUPS                                           ��\n");
printf("\t ��           NKEYPARTS       3                                ��\n");
printf("\t ��           0       8       CHARTYPE                         ��\n");
printf("\t ��           20      17      CHARTYPE                         ��\n");
printf("\t ��           10      3       CHARTYPE                         ��\n");
printf("\t ����������������������������������������������������������������\n");
printf("\t          �̶�, �ι�° �ε���( .SKEY DROP )�� �����ǰ�, ����° ��\n");
printf("\t          ����( .SKEY ADD )�� ���� �����ȴ�.\n");
printf("\n");
printf("5. DATA CONVERSION\n");
printf("\t�� isam ȭ���� �÷����� �� �ε��� ������ ����Ǿ��� ��쿡 ����Ѵ�.\n");
printf("\t�� TEXT DATA �� ��쿡�� ������ �����ϴ�.\n");
printf("\t�� �۾�����\n");
printf("\t     1. �ڷḦ ����޴´�.\n");
printf("\t          -. isutil -t b FILE\n");
printf("\t     2. ����Ÿ�ڷ�� ����ȭ���� �����Ѵ�.\n");
printf("\t          -. �ڷ�ȭ�Ͽ��� �߰� �� ������ �÷��� ���� ������ �Ѵ�.\n");
printf("\t          -. ����ȭ�Ͽ��� ���� �� ���� ������ �ε����� ���� ����");
printf("\t             ���θ� �����Ѵ�.\n");
printf("\t     3. ���ο� �ڷḦ �ε��Ѵ�.\n");
printf("\t          -. ������ ����ϴ� isam ȭ���� �̸� �����Ѵ�.\n");
printf("\t          -. isutil -t l FILE\n");
printf("\t�� ������ isam ȭ�Ͽ� �ε��� ���׸� ������ �Ǵ� ��쿡�� ����ȭ��\n");
printf("\t   �� ���� ������ �Բ� 'isutil i FILE'�� ����Ѵ�.\n");
printf("\n");
printf("6. ��Ÿ����\n");
printf("\t�� �ڷ����� : �ɼ��� ������� �ʴ� ��쿡�� ��� ����ŸŸ����\n");
printf("\t                �����ϴ�. �׷��� '-t' �ɼ��� ����ϴ� ��쿡��\n");
printf("\t                NULL ����Ÿ�� ��쿡�� SPACE�� �����Ͽ��ָ�,\n");
printf("\t                TAB,CR,LF,EOF ���� ���� �ִ� ��쿡�� ����ó��\n");
printf("\t                �ȴ�.\n");
printf("\t�� �ڷ�ε�� : �ɼ��� ������� �ʴ� ��쿡�� ��� ����ŸŸ����\n");
printf("\t                �����ϴ�. �׷��� '-t' �ɼ��� ����ϴ� ��쿡��\n");
printf("\t                NULL ����Ÿ�� ��쿡�� SPACE�� ���� �����Ͽ��ش�.\n");
printf("\t                �׷��� TAB,CR,LF,EOF ���� ���� �ִ� ��쿡��\n");
printf("\t                ����ó�� �ȴ�.\n");
printf("\t                ���ڵ�� ���ڵ� ������ �����ڴ� LF �� �����̴�.\n");
printf("\t�� DATA CONVERSION\n");
printf("\t              : TEXT DATA TYPE�� ��쿡�� �����ϴ�.\n");
printf("\t                �ڷ� ��� �� �ε�� ����Ǵ� �������� �����Ѵ�.\n");
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
