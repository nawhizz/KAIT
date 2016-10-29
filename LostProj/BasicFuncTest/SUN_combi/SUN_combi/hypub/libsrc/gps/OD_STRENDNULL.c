/* OD_STRENDNULL() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change ' 's  to  0 from end of string 			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_STRENDNULL( char *string, int *length, int *RESLEN )
#else
OD_STRENDNULL( string, length, RESLEN )
char	*string;		/* X(length) */
int	*length;		/* S9(8) COMP. */
int	*RESLEN;		/* S9(8) COMP. */
#endif
{
	*RESLEN = d_strendnull( string, *length );
}
