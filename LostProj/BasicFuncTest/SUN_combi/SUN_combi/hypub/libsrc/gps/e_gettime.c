/* e_gettime() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get time of data into E_TIMESEC structure			*/
/*----------------------------------------------------------------------*/
/*
	output	: E_TIMESEC	*tsc	null terminated string
*/

#ifndef		WIN32
#include	<sys/time.h>
#else
#include	<sys/types.h>
#include	<sys/timeb.h>
#endif
#include	<time.h>
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
e_gettime( E_TIMESEC *tsc )
#else
e_gettime( tsc )
E_TIMESEC *tsc;
#endif
{
#ifndef	WIN32
	struct	timeval tp;

	gettimeofday( &tp, (struct timezone *)0 );
	tsc->sec = tp.tv_sec;		/* seconds from 1970.1.1 */
	tsc->micro = tp.tv_usec;	/* remained micro sec */
#else
	struct _timeb timebuffer;
	
	_ftime( &timebuffer );
	tsc->sec = (long)timebuffer.time;
	tsc->micro = (long)(timebuffer.millitm * 1000);
#endif
}
