/* OK_INPNNUMERIC() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input numeric string from std-in at current cursor position	*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OK_INPNNUMERIC(char *string,int *len)
#else
OK_INPNNUMERIC(string,len)
char	*string;		/* X(len) */
int	*len;			/* S9(8) COMP. */
#endif
{
	k_inpnnumeric( string, *len );
}
