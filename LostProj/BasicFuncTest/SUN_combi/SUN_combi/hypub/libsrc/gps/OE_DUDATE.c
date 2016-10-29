/* OE_DUDATE() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get duration							*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_DUDATE( int *dur, char *src, char *dest, char *mask, char *RETSTS )
#else
OE_DUDATE( dur, src, dest, mask, RETSTS )
int	*dur;			/* S9(8) COMP. */
char	*src;			/* X(max.40) */
char	*dest;			/* X(max.40) */
char	*mask;			/* X(max.40) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( e_dudate( *dur, src, dest, l_mask ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
