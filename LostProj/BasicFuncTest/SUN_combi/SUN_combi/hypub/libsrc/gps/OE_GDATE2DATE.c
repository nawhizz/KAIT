/* OE_GDATE2DATE() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculdate day from 00/01/01 to given date			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GDATE2DATE( char *srcdate, int *form, long *ldate, char *RETSTS )
#else
OE_GDATE2DATE( srcdate, form, ldate, RETSTS )
char	*srcdate;		/* X(max.40) */
int	*form;			/* S9(8) COMP. */
long	*ldate; 		/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( e_gdate2date( srcdate, *form, ldate ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
