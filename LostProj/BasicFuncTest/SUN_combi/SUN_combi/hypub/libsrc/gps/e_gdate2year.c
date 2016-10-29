/* e_gdate2year() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculdate day from 00/01/01 to last year of given date	*/
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
e_gdate2year( char *srcdate, int form, long *ldate )
#else
e_gdate2year( srcdate, form, ldate )
char	*srcdate ;
int	form ;
long	*ldate ;
#endif
{
	int	year , year4, year100, year400 ;

	/* Parameter Error Check */
	if( form < 1 || form > 4 ||
	    srcdate == (char *)0 || ldate == (long *)0 )
		return(-1);

	if( e_chkdate( srcdate, form ) < 0 )
		return(-1);

	(*ldate) = 0L;

	year  = d_ndec2int( srcdate, (form/3)*2+2 );
	year = e_getyear( year ) - 1;

	year4 = year/4 ;
	year100 = year/100 ;
	year400 = year/400 ;
	*ldate=(long)((long)year*365L+(long)year4-(long)year100+(long)year400);

	return(0);
}

