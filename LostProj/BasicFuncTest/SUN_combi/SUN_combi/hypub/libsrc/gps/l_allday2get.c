/* l_allday2get() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get all days from 01/01/01					*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	"e_date.h"

int
#if	defined( __CB_STDC__ )
l_allday2get( E_DATEINFO *dateinfo )
#else
l_allday2get( dateinfo )
E_DATEINFO	*dateinfo;
#endif
{
	int	i;
	int	preyear;
	int	allday;

	preyear = dateinfo->iyear - 1;
	allday = preyear * 365 + preyear / 4 - preyear / 100 + preyear / 400;

	for ( i = 0; i < dateinfo->imonth - 1; i++ )
		allday += dateinfo->lastday[i];

	allday += dateinfo->iday;

	return( allday );
}
