/* e_gdatebydu() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculdate new date from given date and duration		*/
/*----------------------------------------------------------------------*/
/*
	input	: int	form		masked form number
					  1 : YYMMDD	 (ex>'921011')
					  2 : YY.MM.DD	 (ex>'92.10.11')
					  3 : YYYYMMDD	 (ex>'19921011')
					  4 : YYYY.MM.DD (ex>'1992.10.11')
		  char	*srcdate	source date string
		  int	duration	duration
		  int	flag		whether given date include (0/-1)
	output	: char	*dstdate	new date string
	return	: >0 (new year)
		  -1

  2001.1.4. ksh. src와 dest가 금년이 아닌 경우에 에러 발생하여 보완
*/

#include	<string.h>
#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));
extern	int	l_allday2get CBD2(( E_DATEINFO *dateinfo ));
extern	void	l_allday2date CBD2(( int allday, char *dest, char *mask ));

int CBD1
#if	defined( __CB_STDC__ )
e_gdatebydu( int form, char *srcdate, int duration, int flag, char *dstdate )
#else
e_gdatebydu( form, srcdate, duration, flag, dstdate )
int	form ;
char	*srcdate ;
int	duration ;
int	flag ;
char	*dstdate ;
#endif
{
/*2001.1.4. change--------------------------------------------------------------
	int	jul, choice ;
------------------------------------------------------------------------------*/
	E_DATEINFO	dateinfo;
	char	buff[20], mask[5][11];
	int	allday;
/*end of 2001.1.4-------------------------------------------------------------*/

	/* Parameter Error Check */
	if( form/10 < 1 || form/10 > 4 ||
	    form%10 < 1 || form%10 > 4 ||
	    srcdate == (char *)0 || dstdate == ( char *)0 ||
/*	    duration < 0 || duration > 10000 ||    */
	    flag < -1 || flag > 0 )
		return(-1) ;

/*2001.1.4. change--------------------------------------------------------------
	* 주어진 날짜를 Julian date로 변환 *
	if( ( jul = e_gre2jul( srcdate, form/10 ) ) < 0 )
		return(-1) ;

	* Julian date에 duration과 주어진 날짜 포함여부 계산 *
	if( duration > 0 )
		jul = jul + duration + flag ;
	else
		jul = jul + duration - flag ;

	* Julian Date를 Gregorian Date 로 변환 *
	choice = ( (form/10)/3 + 1 )* 10 + (form%10 ) ;
	return( e_jul2gre( jul, choice, srcdate, dstdate ) ) ;
------------------------------------------------------------------------------*/
	strcpy( mask[0], "" );
	strcpy( mask[1], "YYMMDD" );
	strcpy( mask[2], "YY.MM.DD" );
	strcpy( mask[3], "YYYYMMDD" );
	strcpy( mask[4], "YYYY.MM.DD" );

	if ( l_datechkconv( srcdate, mask[form/10], &dateinfo ) < 0 )
		return -1;

	if ( l_lstdaychkget( &dateinfo ) < 0 )
		return -1;

	if( duration > 0 )
		duration += flag ;
	else
		duration -= flag ;

	allday = l_allday2get( &dateinfo );
	allday += duration;

	l_allday2date( allday, buff, mask[form%10] );

	memcpy( dstdate, buff, strlen(mask[form%10]) );
	return 0;
/*end of 2001.1.4-------------------------------------------------------------*/
}
