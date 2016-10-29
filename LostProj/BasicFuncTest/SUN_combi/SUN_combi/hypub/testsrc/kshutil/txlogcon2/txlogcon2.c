/* txlogconv.c */
/*----------------------------------------------------------------------*
| Descrip.	txlog format 전환					|
|									|
| Project	DLTP							|
| System	DLTP							|
| Pgid		txlogconv 						|
|									|
| Date		2001.04.17						|
|									|
*-----------------------------------------------------------------------*/

/*-----	System Library Headers	---------------------------------------*/
#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<errno.h>

#ifdef	WIN32

#include	<process.h>
#include	<stdarg.h>

#else

#include	<sys/varargs.h>

#endif

/*-----	Combi Library Headers	---------------------------------------*/
#include	"cbuni.h"
#include	"gps.h"
#include	"pisam.h"

/*-----	File Layout Headers -------------------------------------------*/
#include	"usid.h"

/*-----	Declare User Function -----------------------------------------*/
static	void	errorend CBD2(( char *cmt, ... ));
#ifdef	WIN32
static	char	getopt	CBD2(( int argc, char *argv[], char *findstr ));
#endif
static	void	getstime CBD2(( char *stime, char *etime, char *dur ));

/*----------------------------------------------------------------------*/
/*	WIN32		DEFERENCE					*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	DEFINE		VARIABLES					*/
/*----------------------------------------------------------------------*/
#define	FILLSPACE(a)	memset(a,' ',sizeof(a))
#define	MOVE(a,b)	move(a,sizeof(a),b,sizeof(b))
#define	move(a,alen,b,blen)	(alen<blen? memcpy(b,a,alen),memset(b+alen,' ',blen-alen):memcpy(b,a,blen))
#define	ISSAME(a,b)	!memcmp(a,b,sizeof(a))

#define	disphelp()	{ printf( dispmsg ); exit( 1 ); }

/*----------------------------------------------------------------------*/
/*	INTERNAL	STRUCTURES	DEFINE				*/
/*----------------------------------------------------------------------*/
struct	IN_REC {
	char	termid	[8];	/* 터미널 ID		*/
	char	deli1;		/* ':' 			*/
	char	usernm	[10];	/* 사용자 명		*/
	char	deli2;		/* ':' 			*/
	char	txid	[8];	/* TXID			*/
	char	deli3;		/* '-' 			*/
	char	pgid	[8];	/* 프로그램 ID		*/
	char	deli4;		/* ' ' 			*/
	char	date	[2];	/* 일자	(DD)		*/
	char	deli5;		/* '-' 			*/
	char	time	[8];	/* 시각	(HH:MM:SS)	*/
	char	deli6;		/* ' ' 			*/
	char	timeval	[5];	/* 소요시각(초)	decimal	*/
	char	deli7;		/* ':' 			*/
	char	reason	[24];	/* 설명			*/
	char	deli8;		/* new-line 		*/
};

struct	OUT_REC {
	char	termid	[8];	/* 터미널 ID		*/
	char	deli1;		/* ':' 			*/
	char	userid	[8];	/* 사용자 ID		*/
	char	deli9;		/* '('			*/
	char	usernm	[12];	/* 사용자 명		*/
	char	deli10;		/* ')'			*/
	char	deli2;		/* ':' 			*/
	char	txid	[8];	/* TXID			*/
	char	deli3;		/* '-' 			*/
	char	pgid	[8];	/* 프로그램 ID		*/
	char	deli4;		/* ' ' 			*/
	char	date	[2];	/* 일자	(DD)		*/
	char	deli5;		/* '-' 			*/
	char	stime	[12];	/*시작시각(HH:MM:SS.SSS)*/
	char	deli11;		/* '-' 			*/
	char	etime	[12];	/*종료시각(HH:MM:SS.SSS)*/
	char	deli6;		/* ' ' 			*/
	char	timeval	[8];	/* 소요시각(초) (SSSS.SSS)*/
	char	deli7;		/* ':' 			*/
	char	reason	[24];	/* 설명			*/
	char	deli8;		/* new-line 		*/
};

/*----------------------------------------------------------------------*/
/*	EXTERN	VARIABLES						*/
/*----------------------------------------------------------------------*/
struct	usidFORM	usidrec;

int	usidFD = -1;

FILE	*infd = NULL;
FILE	*outfd = NULL;

const	char	dispmsg[] = "\
*************************************************************************\n\
* txlogconv skill 1) 2001.4.17. txlog format으로 conversion		*\n\
*									*\n\
* Usage : txlogconv [-h] input-file output-file <usid.dat 의 path>	*\n\
*									*\n\
*    -h : 사용법							*\n\
*************************************************************************\n\
";

/*----------------------------------------------------------------------*/
/*	MAIN	FUNCTIONS						*/
/*----------------------------------------------------------------------*/
void
#ifdef	__CB_STDC__
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	struct	IN_REC	*in_rec;
	struct	OUT_REC	out_rec;
	int		hour, min, sec, timedur;
	char		buf[256], temp[16], userinfo[128];

	/* 도움말 보기 */
	if( getopt( argc, argv, "h" ) == 'h' )
		disphelp();

	/* argument 체크 */
	if( argc != 4 )
	{
		printf( "argument 갯수가 틀립니다.\n" );
		disphelp();
	}

	/* input file 을 읽을 수 있는지 검사 */
	infd = fopen( argv[1], "r" );
	if( !infd )
		errorend( "%s file 이 없습니다.", argv[1] );

	/* out file 생성 여부 체크 */
	outfd = fopen( argv[2], "w" );
	if( !outfd )
		errorend( "%s file 을 생성할 수 없습니다.", argv[2] );

	/* usid open */
	strcpy( userinfo, argv[3] );
#ifdef	WIN32
	strcat( userinfo, "\\usid" );
#else
	strcat( userinfo, "/usid" );
#endif
	usidFD = PI_OPEN( userinfo, "usid" );
	if( usidFD < 0 )
		errorend( "%s file open 에러 (%d)", userinfo, hyerrno );

	/* 데이타를 conversion 한다 */
	in_rec = (struct IN_REC *)buf;

	out_rec.deli1 = ':';
	out_rec.deli2 = ':';
	out_rec.deli3 = '-';
	out_rec.deli4 = ' ';
	out_rec.deli5 = '-';
	out_rec.deli6 = ' ';
	out_rec.deli9 = '(';
	out_rec.deli10 = ')';
	out_rec.deli11 = '-';
	out_rec.deli8 = '\n';

	while( fgets( buf, sizeof(buf), infd ) )
	{
		if( strlen( buf ) == sizeof( *in_rec ) )
		{
			MOVE( in_rec->termid , out_rec.termid  );
			MOVE( in_rec->usernm , out_rec.usernm  );
			MOVE( in_rec->txid   , out_rec.txid    );
			MOVE( in_rec->pgid   , out_rec.pgid    );
			MOVE( in_rec->time   , out_rec.etime   );
			memcpy( &out_rec.etime[8], ".000", 4 );
			MOVE( in_rec->date   , out_rec.date    );
			move( &in_rec->timeval[1], 4,
				out_rec.timeval, sizeof(out_rec.timeval) );
			memcpy( &out_rec.timeval[4], ".000", 4 );
			out_rec.deli7 = in_rec->deli7;
			MOVE( in_rec->reason , out_rec.reason  );

			/* get userid */
			MOVE( out_rec.usernm , usidrec.usnm    );
			FILLSPACE( usidrec.usid );
			if( ( PI_REDGE( usidFD, "KB", (char *)&usidrec ) == 0 )
			&&  ( ISSAME( usidrec.usnm, out_rec.usernm ) ) )
				MOVE( usidrec.usid, out_rec.userid );
			else
				FILLSPACE( out_rec.userid );

			/* get start time */
			hour = d_ndec2int( in_rec->time, 2 );
			min = d_ndec2int( &in_rec->time[3], 2 );
			sec = d_ndec2int( &in_rec->time[6], 2 );
			timedur = d_ndec2int( in_rec->timeval,
					      sizeof(in_rec->timeval) );
			sec -= timedur;
			while( sec < 0 )
			{
				sec += 60;
				min--;
			}
			while( min < 0 )
			{
				min += 60;
				hour--;
			}
			/* case. hour < 0 없다고 가정 */
			if( hour < 0 )
			{
				hour = 0;
				min = 0;
				sec = 0;
			}
			sprintf( temp, "%02d:%02d:%02d.000", hour, min, sec );
			memcpy( out_rec.stime, temp, strlen( temp ) );
			
			fwrite( (char *)&out_rec, sizeof(out_rec), 1, outfd );
		}
		else if( strlen( buf ) == sizeof( out_rec ) )
		{
			memcpy( (char *)&out_rec, buf, sizeof( out_rec ) );
			if( d_isspacenstr( out_rec.userid,
					   sizeof( out_rec.userid ) ) )
			{
				/* get userid */
				MOVE( out_rec.usernm , usidrec.usnm    );
				FILLSPACE( usidrec.usid );
				if( ( PI_REDGE( usidFD, "KB", (char *)&usidrec )
				      == 0 )
				&&  ( ISSAME( usidrec.usnm, out_rec.usernm ) ) )
					MOVE( usidrec.usid, out_rec.userid );
			}
			if( d_isspacenstr( &out_rec.etime[8], 4 ) )
				memcpy( &out_rec.etime[8], ".000", 4 );
			if( d_isspacenstr( &out_rec.timeval[4], 4 ) )
				memcpy( &out_rec.timeval[4], ".000", 4 );
			/* get start time */
			if( d_isspacenstr( out_rec.stime, sizeof(out_rec.stime) ) )
			{
				hour = d_ndec2int( out_rec.etime, 2 );
				min = d_ndec2int( &out_rec.etime[3], 2 );
				sec = d_ndec2int( &out_rec.etime[6], 2 );
				timedur = d_ndec2int( out_rec.timeval,
						      sizeof(out_rec.timeval) );
				sec -= timedur;
				while( sec < 0 )
				{
					sec += 60;
					min--;
				}
				while( min < 0 )
				{
					min += 60;
					hour--;
				}
				/* case. hour < 0 없다고 가정 */
				if( hour < 0 )
				{
					hour = 0;
					min = 0;
					sec = 0;
				}
				sprintf( temp, "%02d:%02d:%02d.000", hour, min, sec );
				memcpy( out_rec.stime, temp, strlen( temp ) );
			}
			fwrite( (char *)&out_rec, sizeof(out_rec), 1, outfd );
		}
	}

	PI_CLOSE( usidFD );
	fclose( infd );
	fclose( outfd );

	exit( 0 );
}

/*---------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
errorend( char *cmt, ... )
#else
errorend( va_alist )
va_dcl
#endif
{
#ifndef	__CB_STDC__
	char	*cmt;
#endif
	va_list	vlist;

#ifdef	__CB_STDC__
	va_start( vlist, cmt );
#else
	va_start( vlist );
	cmt = va_arg( vlist, char * );
#endif
	vfprintf( stdout, cmt, vlist );
	va_end( vlist );
	if( errno )
		printf( " (errno=%d)", errno );
	printf( "\n" );
	if( usidFD >= 0 )
		PI_CLOSE( usidFD );
	if( infd )
		fclose( infd );
	if( outfd )
		fclose( outfd );
	exit( 1 );
}

/*---------------------------------------------------------------------*/
#ifdef	WIN32
static	char
getopt( int argc, char *argv[], char *findstr )
{
	char		tzero[1] = { 0 };
	static	char	**targv = (char **)-1;
	static	char	*tptr;

	if( targv == (char **)-1 )
	{
		targv = argv;
		tptr = tzero;
	}
	else
	{
		if( targv == NULL )
			return( (char)-1 );
		tptr++;
	}

	if( *tptr == (char)0 )
	{
		if( *(++targv) == 0 )
		{
			return( (char)-1 );
		}
		tptr = *targv;
		if( ( *tptr != '-' ) || ( *(++tptr) == 0 ) )
		{
			targv = NULL;
			return( (char)-1 );
		}
	}

	if( strchr( findstr, (int)*tptr ) == NULL )
		return( '?' );
	else
		return( *tptr );
}
#endif
/*----------------------------------------------------------------------*/
/* end of txlogconv.c */
/*----------------------------------------------------------------------*/
