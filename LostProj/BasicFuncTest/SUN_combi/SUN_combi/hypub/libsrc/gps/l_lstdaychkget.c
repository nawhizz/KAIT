/* l_lstdaychkget() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check and get last day					*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	"e_date.h"

int
#if	defined( __CB_STDC__ )
l_lstdaychkget( E_DATEINFO *dateinfo )
#else
l_lstdaychkget( dateinfo )
E_DATEINFO	*dateinfo;
#endif
{
	register	i;
	static	int	lastday[12] = { 	/* the last days of month */
			31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
		};


	/* check leap year */
	lastday[1] = 28;
	if ( !( dateinfo->iyear % 4 ) )
	{
		if ( !( dateinfo->iyear % 100 ) )
		{
			if ( !( dateinfo->iyear % 400 ) )
				lastday[1] = 29;
		}
		else		/* last day of Febrary + 1 */
			lastday[1] = 29;
	}

	for ( i = 0; i < 12; i++ )
		dateinfo->lastday[i] = lastday[i];

	if ( dateinfo->lastday[dateinfo->imonth - 1] < dateinfo->iday )
		return -1;

	return	0;
}
