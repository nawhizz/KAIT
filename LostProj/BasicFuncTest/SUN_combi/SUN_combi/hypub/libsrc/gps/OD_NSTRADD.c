/* OD_NSTRADD() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 두개의 decimal string을 더함 (3개의 string의 길이는 같아야함) */
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_NSTRADD( char *src11, char *src22, char *dest, int *len, char *RETSTS )
#else
OD_NSTRADD( src11, src22, dest, len, RETSTS )
char	*src11; 		/* X(len) */
char	*src22; 		/* X(len) */
char	*dest;			/* X(len+1) */
int	*len;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_nstradd( src11, src22, dest, *len ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
