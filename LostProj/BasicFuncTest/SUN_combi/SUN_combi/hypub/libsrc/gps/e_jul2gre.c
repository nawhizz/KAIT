/* e_jul2gre() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert julian to gregorian date (1990бн2089 use)		*/
/*----------------------------------------------------------------------*/
/*
	input	: int  juldate		Julian date
		  int  form		form (MN/M for input, N for output)
		  char *srcdate 	source date
					  M  1 : date'92'
					     2 : date'1992'
	output	: char *dstdate 	destination date
					  N  1 : date'921011'
					     2 : date'92.10.11'
					     3 : date'19921011'
					     4 : date'1992.10.11'
	return	: 0/-1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_jul2gre( int jul, int form, char *srcdate, char *dstdate )
#else
e_jul2gre( jul, form, srcdate, dstdate )
int	jul ;
int	form ;
char	*srcdate ;
char	*dstdate ;
#endif
{
	register	i;
	int		year, month, date, even, large ;
static	int	maxdate[12]={ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	/* Check Parameter Error Check */
	if( jul < 1 ||
	    form/10 < 1 || form/10 > 2 || form%10 < 1 || form%10 > 4 ||
	    srcdate == (char *)0 || dstdate == (char *)0 )
	{
		return(-1) ;
	}

	if( ( year = d_ndec2int( srcdate, (form/10)*2 ) ) < 0 )
		return(-1) ;
	year = e_getyear( year ) ;

	date = jul ;
	for( ; ; )
	{
		maxdate[1] = 28 ;
		if( !(year % 4) )
		{
			if(!(year % 100))
			{
				if(!(year % 400))
					maxdate[1] += 1 ;
			}
			else	maxdate[1] += 1;
		}
		for( i = 0 ; i < 12 ; i++ )
		{
			if( date <= maxdate[i] )
				break ;
			date -= maxdate[i] ;
		}
		if( i < 12  )
			break;
		year += 1 ;
	}

	month =  i + 1 ;
	even  = (form%10)%2 == 1 ? 0 : 1  ;
	large = (form%10)/3 ;
	if( !large )
		year %= 100;
	large *= 2;
	d_int2ndec( year, ( 2 + large) , '0', dstdate ) ;
	d_int2ndec( month, 2, '0', &dstdate[2+large+even] ) ;
	d_int2ndec( date , 2, '0', &dstdate[4+large+even+even] ) ;
	if( even )
	{
		dstdate[2+large] = '.' ;
		dstdate[5+large] = '.' ;
	}
	return(0) ;
}
