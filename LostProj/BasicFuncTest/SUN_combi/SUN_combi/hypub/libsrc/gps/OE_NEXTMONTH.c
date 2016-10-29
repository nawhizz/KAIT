/* OE_NEXTMONTH() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get next month						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_NEXTMONTH( char *src, char *dest, char *mask, char *RETSTS )
#else
OE_NEXTMONTH( src, dest, mask, RETSTS )
char	*src;			/* X(max.40) */
char	*dest;			/* X(40) */
char	*mask;			/* X(max.40) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( e_nextmonth( src, dest, l_mask ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
