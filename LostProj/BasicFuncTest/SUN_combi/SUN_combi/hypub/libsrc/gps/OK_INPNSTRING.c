/* OK_INPNSTRING() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input string from std-in at current cursor position		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OK_INPNSTRING(char *str,int *len)
#else
OK_INPNSTRING(str,len)
char	*str;			/* X(len) */
int	*len;			/* S9(8) COMP. */
#endif
{
	k_inpnstring( str, *len );
}
