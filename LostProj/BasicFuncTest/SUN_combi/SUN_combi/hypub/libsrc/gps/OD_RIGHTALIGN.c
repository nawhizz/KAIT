/* OD_RIGHTALIGN() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : align data right						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_RIGHTALIGN( char *src, int *srclen, char *dest, char *lfilchar,
								char *RETSTS )
#else
OD_RIGHTALIGN( src, srclen, dest, lfilchar, RETSTS )
char	*src;			/* X(srclen) */
int	*srclen;		/* S9(8) COMP. */
char	*dest;			/* X(srclen) */
char	*lfilchar;		/* X(1) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_rightalign( src, *srclen, dest, *lfilchar ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
