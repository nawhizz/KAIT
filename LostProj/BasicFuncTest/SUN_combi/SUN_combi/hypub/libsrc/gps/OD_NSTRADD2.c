/* OD_NSTRADD2() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 서로다른 길이의 decimal string을 더함 			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_NSTRADD2( char *s1, int *s1len, char *s2, int *s2len, char *d, int *dlen, char *RETSTS )
#else
OD_NSTRADD2( s1, s1len, s2, s2len, d, dlen, RETSTS )
char	*s1;			/* X(s1len) */
int	*s1len; 		/* S9(8) COMP. */
char	*s2;			/* X(s2len) */
int	*s2len; 		/* S9(8) COMP. */
char	*d;			/* X(dlen) */
int	*dlen;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_nstradd2( s1, *s1len, s2, *s2len, d, *dlen ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
