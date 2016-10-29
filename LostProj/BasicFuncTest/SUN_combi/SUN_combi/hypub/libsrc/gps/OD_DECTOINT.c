/* OD_DECTOINT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii decimal string into integer			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_DECTOINT( char *string, int *nstr, int *num, char *RETSTS )
#else
OD_DECTOINT( string, nstr, num, RETSTS )
char	*string;		/* X(nstr) */
int	*nstr;			/* S9(8) COMP. */
int	*num;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{

	if( d_dectoint( string, *nstr, num ) < 0 )	RETSTS[0] = 'E';
	else						RETSTS[0] = ' ';
}
