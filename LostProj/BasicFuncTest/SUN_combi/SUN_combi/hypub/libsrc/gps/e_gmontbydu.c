/* e_gmontbydu() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculate new date(YYMM) from given date(YYMM) and duration	*/
/*----------------------------------------------------------------------*/
/*
	input	: int	form		masked form number
					  1 : YYMM	 (ex>'9210')
					  2 : YY.MM	 (ex>'92.10')
					  3 : YYYYMM	 (ex>'199210')
					  4 : YYYY.MM    (ex>'1992.10')
		  char	*srcdate	source date string
		  int	duration	duration (increase count of month)
		  int	flag		whether given date include (0/-1)
	output	: char	*dstdate	new date
	return	: >0 (new year)
		  -1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_gmontbydu( int form, char *srcdate, int duration, int flag, char *dstdate )
#else
e_gmontbydu( form, srcdate, duration, flag, dstdate )
int	form ;
char	*srcdate ;
int	duration ;
int	flag ;
char	*dstdate ;
#endif
{
	int	syear, smonth, dyear, dmonth ;
	int	form10, form1 ;

	/* Parameter Error Check */
	if( form/10 < 1 || form/10 > 4 || form%10 < 1 || form%10 > 4 ||
	    srcdate == (char *)0 ||
/*	    duration < 0 || duration > 10000 ||   */
	    flag < -1 || flag > 0 ||
	    dstdate == (char *)0 )
	{
		return( -1 );
	}

	form10 = form/10 ;
	form1  = form%10 ;

	/* 연월을 개월로 전환 */
	syear  = d_ndec2int( srcdate, (form10/3)*2+2 ) ;
	smonth = d_ndec2int( &srcdate[form10+1], 2 ) ;
	if( duration > 0 )
		smonth += ( syear - 1 ) * 12 + duration + flag ;
	else
		smonth += ( syear - 1 ) * 12 + duration - flag ;

       	/* 개월을 연월로 전환 */
	dyear = smonth / 12 + 1 ;
	if( ( dmonth = smonth % 12 ) == 0 )
	{
		dyear--;
		dmonth = 12 ;
	}
	d_int2ndec( dyear, ( (form1/3)+1 )*2, '0', dstdate );
	d_int2ndec( dmonth, 2, '0', &dstdate[form1+1] );
	if( form1%2 == 0 )
		dstdate[form1] = '.' ;
	return( 0 ) ;
}
