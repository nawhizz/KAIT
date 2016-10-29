/* e_gre2jul() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert gregorian date to julian (1990бн2089 use)		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*srcdate	source date string
		  int	form		masked form number
					  1 : YYMMDD	 (ex>'921011')
					  2 : YY.MM.DD	 (ex>'92.10.11')
					  3 : YYYYMMDD	 (ex>'19921011')
					  4 : YYYY.MM.DD (ex>'1992.10.11')
	return	: >0 (julian date)
		  -1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_gre2jul( char *datestr, int form )
#else
e_gre2jul( datestr, form )
char	*datestr ;
int	form ;
#endif
{
	int	i, year, month, date, mdate, ptr ;
	int	ret = 0 ;
static	int	maxdate[12]={ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	if( datestr == (char *)0 ||
	    form < 1 || form > 4 )
	{
		return(-1) ;
	}

	year  = d_ndec2int( datestr, (form/3)*2 + 2 ) ;
	month = d_ndec2int( &datestr[form+1], 2 ) ;
	ptr = (form%2==1)?(form+3):(form+4);
	date  = d_ndec2int( &datestr[ptr], 2 ) ;

	if( year < 0 ||
	    month < 1 || month > 12 ||
	    date < 1 )
		return(-1) ;

	year = e_getyear( year ) ;

	maxdate[1] = 28 ;
	if( month >= 2 && !( year % 4 ) )
	{
		if(!(year % 100))
		{
			if(!(year % 400))
				maxdate[1] += 1 ;
		}
		else
			maxdate[1] += 1 ;
	}
	mdate = maxdate[month-1] ;

	if( mdate < date )
		return(-1) ;

	for( i = 0 ; i < month - 1 ; i++ )
		ret += maxdate[i] ;
	ret+=date ;
	return(ret) ;
}
