/* OE_GETSYSTIME() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get system date & time in form of options followed		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GETSYSTIME( int *choice, char *datestr, char *timestr, char *RETSTS )
#else
OE_GETSYSTIME( choice, datestr, timestr, RETSTS )
int	*choice;		/* S9(8) COMP. */
char	*datestr;		/* X(n) */
char	*timestr;		/* X(n) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( e_getsysdate( *choice, datestr, timestr ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
