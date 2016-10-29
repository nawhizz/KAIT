/* OE_SLEEP0001() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : wait 0.001 * msec mili second 				*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_SLEEP0001( int *msec )
#else
OE_SLEEP0001( msec )
int *msec;		/* S9(8) COMP */
#endif
{
	e_sleep0001( *msec );
}
