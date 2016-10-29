/* e_timegap() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get time gap between start and end				*/
/*----------------------------------------------------------------------*/
/*
	input	: E_TIMESEC	*start	start time structure
		  E_TIMESEC	*endt	end time structure
	output	: E_TIMESEC	*gap	gap time structure
*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
e_timegap( E_TIMESEC *start, E_TIMESEC *endt, E_TIMESEC *gap )
#else
e_timegap( start, endt, gap )
E_TIMESEC	*start;
E_TIMESEC	*endt;
E_TIMESEC	*gap;
#endif
{
	gap->sec = endt->sec - start->sec;
	gap->micro = endt->micro - start->micro;
	if(gap->micro < 0)
	{
		gap->sec--;
		gap->micro += 1000000;
	}
}
