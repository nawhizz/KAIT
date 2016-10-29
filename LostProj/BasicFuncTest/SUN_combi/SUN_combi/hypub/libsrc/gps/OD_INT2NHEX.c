/* OD_INT2NHEX() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert integer to ascii hexadecimal string (not null terminate)*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_INT2NHEX( int *val, int *nstr, char *leftchar, char *string )
#else
OD_INT2NHEX( val, nstr, leftchar, string )
int	*val;			/* S9(8) COMP. */
int	*nstr;			/* S9(8) COMP. */
char	*leftchar;		/* X(1) */
char	*string;		/* X(nstr+1) */
#endif
{
	d_int2nhex( *val, *nstr, *leftchar, string );
}
