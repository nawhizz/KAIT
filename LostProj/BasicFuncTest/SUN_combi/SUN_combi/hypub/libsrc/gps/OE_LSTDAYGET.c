/* OE_LSTDAYGET() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get last day of each month					*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_LSTDAYGET( char *src, char *lstday, char *mask, int *LDAY, char *RETSTS )
#else
OE_LSTDAYGET( src, lstday, mask, LDAY, RETSTS )
char	*src;			/* X(nn) */
char	*lstday;		/* X(3) */
char	*mask;			/* X(max.40) */
int	*LDAY;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( (*LDAY=e_lstdayget( src, lstday, l_mask )) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
