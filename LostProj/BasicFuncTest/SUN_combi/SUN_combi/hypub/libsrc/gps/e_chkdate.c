/* e_chkdate() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check date in various form (1990∼2089 사용가능)		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*datestr	source date string
		  int	form		masked form number
					  1 : YYMMDD	 (ex>'921011')
					  2 : YY.MM.DD	 (ex>'92.10.11')
					  3 : YYYYMMDD	 (ex>'19921011')
					  4 : YYYY.MM.DD (ex>'1992.10.11')
	return	: 0/-1
*/
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_chkdate( char *datestr, int form )
#else
e_chkdate( datestr, form )
char	*datestr ;
int	form ;
#endif
{
	int	year, month, date, mdate, ptr ;
static	int	maxdate[12]={ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	if( datestr == (char *)0 ||
	    form < 1 || form > 4 )
		return -1;

	year  = d_ndec2int( datestr, (form/3)*2+2 );
	month = d_ndec2int( &datestr[form+1], 2 );
	ptr   = form%2 == 1 ? form + 3 : form + 4 ;
	date  = d_ndec2int( &datestr[ptr], 2 ) ;

	if( year < 0 ||
	    month < 1 || month > 12 ||
	    date < 1 )
		return -1;

	year = e_getyear( year );

	mdate = maxdate[month-1];
	if( month == 2 && !( year % 4 ) )
	{
		if( !( year % 100 ) )
		{
			if( !(year % 400) )
				mdate += 1;
		}
		else	mdate += 1;
	}
	if( mdate < date )
		return -1;
	return 0;
}
