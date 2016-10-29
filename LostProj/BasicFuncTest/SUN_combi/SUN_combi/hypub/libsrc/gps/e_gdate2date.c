/* e_gdate2date() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculdate day from 00/01/01 to given date			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*srcdate	source date string
		  int	form		masked form number
					  1 : YYMMDD	 (ex>'921011')
					  2 : YY.MM.DD	 (ex>'92.10.11')
					  3 : YYYYMMDD	 (ex>'19921011')
					  4 : YYYY.MM.DD (ex>'1992.10.11')
	output	: long	*ldate		caluculated days
	return	: 0/-1
*/
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_gdate2date( char *srcdate, int form, long *ldate )
#else
e_gdate2date( srcdate, form, ldate )
char	*srcdate ;
int	form ;
long	*ldate ;
#endif
{
	int	jul ;
	long	date ;

	/* Parameter Error Check */
	if( form < 1 || form > 4 ||
	    srcdate == (char *)0 || ldate  == (long *)0 )
		return(-1);

	/* 주어진 날짜를 check */
	if( e_chkdate( srcdate, form ) < 0 )
		return(-1);

	/* 주어진 날짜의 전년까지의 날짜 계산 */
	if( e_gdate2year( srcdate, form, &date ) < 0 )
		return(-1) ;

	/* 주어진 날짜의 Julian date 계산 */
	if( ( jul = e_gre2jul( srcdate, form ) ) < 0 )
		return(-1) ;

	/* Julian date에 duration과 주어진 날짜 포함여부 계산 */
	*ldate = (long)( date + (long)jul );
	return(0) ;
}
