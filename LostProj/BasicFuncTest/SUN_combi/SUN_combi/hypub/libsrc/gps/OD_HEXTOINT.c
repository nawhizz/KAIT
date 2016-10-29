/* OD_HEXTOINT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii hexadecimal string into integer 		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_HEXTOINT( char *string, int *nstr, int *num, char *RETSTS )
#else
OD_HEXTOINT( string, nstr, num, RETSTS )
char	*string;		/* X(nstr) */
int	*nstr;			/* S9(8) COMP. */
int	*num;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_hextoint( string, *nstr, num ) < 0 )	RETSTS[0] = 'E';
	else						RETSTS[0] = ' ';
}
