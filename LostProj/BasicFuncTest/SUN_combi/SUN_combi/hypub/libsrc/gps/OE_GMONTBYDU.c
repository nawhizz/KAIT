/* OE_GMONTBYDU() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculate new date(YYMM) from given date(YYMM) and duration	*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GMONTBYDU( int *form, char *srcdate, int *duration, int *flag, char *dstdate, char *RETSTS )
#else
OE_GMONTBYDU( form, srcdate, duration, flag, dstdate, RETSTS )
int	*form;			/* S9(8) COMP. */
char	*srcdate;		/* X(nn) */
int	*duration;		/* S9(8) COMP. */
int	*flag;			/* S9(8) COMP. */
char	*dstdate;		/* X(nn) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( e_gmontbydu( *form, srcdate, *duration, *flag, dstdate ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
