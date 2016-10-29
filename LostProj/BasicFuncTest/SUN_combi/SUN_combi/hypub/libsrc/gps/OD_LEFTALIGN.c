/* OD_LEFTALIGN() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : align data left						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_LEFTALIGN( char *src, int *srclen, char *dest, char *rfilchar, char *RETSTS )
#else
OD_LEFTALIGN( src, srclen, dest, rfilchar, RETSTS )
char	*src;			/* X(srclen) */
int	*srclen;		/* S9(8) COMP. */
char	*dest;			/* X(srclen) */
char	*rfilchar;		/* X(1) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_leftalign( src, *srclen, dest, *rfilchar ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
