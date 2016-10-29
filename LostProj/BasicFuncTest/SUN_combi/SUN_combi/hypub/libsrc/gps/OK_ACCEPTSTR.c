/* OK_ACCEPTSTR() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input n-string from std-in at current cursor position 	*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OK_ACCEPTSTR(char *string,int *len)
#else
OK_ACCEPTSTR(string,len)
char	*string;		/* X(len) */
int	*len;			/* S9(8) COMP. */
#endif
{
	k_acceptstr( string, *len );
}
