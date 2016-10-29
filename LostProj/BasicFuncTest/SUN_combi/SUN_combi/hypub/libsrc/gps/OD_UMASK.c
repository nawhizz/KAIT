/* OD_UMASK() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : unmask data to mask						*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_UMASK (char *src, char *dest, int *destlen, char *mask, char *lfilchar, char *RETSTS )
#else
OD_UMASK (src, dest, destlen, mask, lfilchar, RETSTS )
char	*src;			/* X(40) */
char	*dest;			/* X(destlen) */
int	*destlen;		/* S9(8) COMP. */
char	*mask;			/* X(max.40) */
char	*lfilchar;		/* X(1) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( d_umask( src, dest, *destlen, l_mask, *lfilchar ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
