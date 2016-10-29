/* OD_HANADJT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : adjust HANGUL data						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_HANADJT( char *src, int *len, char *dest, char *RETSTS )
#else
OD_HANADJT( src, len, dest, RETSTS )
char	*src;			/* X(len) */
int	*len;			/* S9(8) COMP. */
char	*dest;			/* X(nn) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_hanadjt( src, *len, dest ) < 0 )	RETSTS[0] = 'E';
	else					RETSTS[0] = ' ';
}
