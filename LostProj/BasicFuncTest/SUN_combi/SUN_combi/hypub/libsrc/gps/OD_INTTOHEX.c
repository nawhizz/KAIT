/* OD_INTTOHEX() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert integer to ascii hexadecimal string (null terminate)	*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_INTTOHEX( int *val, int *nstr, char *leftchar, char *string )
#else
OD_INTTOHEX( val, nstr, leftchar, string )
int	*val;			/* S9(8) COMP. */
int	*nstr;			/* S9(8) COMP. */
char	*leftchar;		/* X(1) */
char	*string;		/* X(nstr+1) */
#endif
{
	d_inttohex( *val, *nstr, *leftchar, string );
}
