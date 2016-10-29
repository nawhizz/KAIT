/* OE_PREVDAY() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get previous day						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_PREVDAY( char *src, char *dest, char *mask, char *RETSTS )
#else
OE_PREVDAY( src, dest, mask, RETSTS )
char	*src;			/* X(max.40) */
char	*dest;			/* X(40) */
char	*mask;			/* X(max.40) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( e_prevday( src, dest, l_mask ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
