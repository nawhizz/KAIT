/* e_sleep0001() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : wait 0.001 * msec mili second 				*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
e_sleep0001( int msec )
#else
e_sleep0001( msec )
int	msec;
#endif
{
	E_TIMESEC	startt,endt,gapt;
	int	msecpassed=0;

	e_gettime(&startt);
	while(msecpassed<msec)
	{
		e_gettime(&endt);
		e_timegap(&startt,&endt,&gapt);
		msecpassed=gapt.sec*1000+gapt.micro/1000;
	}
}
