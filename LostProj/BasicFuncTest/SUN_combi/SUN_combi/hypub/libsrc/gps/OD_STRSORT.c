/* OD_STRSORT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : sorting string by key 					*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_STRSORT( int *keyptr, int *keyleng, int *noofrec, int *recsize, char *recbuff, char *RETSTS )
#else
OD_STRSORT( keyptr, keyleng, noofrec, recsize, recbuff, RETSTS )
int	*keyptr;		/* S9(8) COMP. */
int	*keyleng;		/* S9(8) COMP. */
int	*noofrec;		/* S9(8) COMP. */
int	*recsize;		/* S9(8) COMP. */
char	*recbuff;		/* X(recsize*noofrec) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_strsort( *keyptr, *keyleng, *noofrec, *recsize, recbuff ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
