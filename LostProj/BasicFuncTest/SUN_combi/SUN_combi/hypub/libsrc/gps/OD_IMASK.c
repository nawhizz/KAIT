/* OD_IMASK() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : mask input data						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_IMASK(char *src, int *srclen, char *dest, char *mask, char *lfilchar, char *RETSTS)
#else
OD_IMASK(src, srclen, dest, mask, lfilchar, RETSTS)
char	*src;			/* X(srclen) */
int	*srclen;		/* S9(8) COMP. */
char	*dest;			/* X(nn) */
char	*mask;			/* X(max.40) */
char	*lfilchar;		/* X(1) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( d_imask( src, *srclen, dest, l_mask, *lfilchar ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
