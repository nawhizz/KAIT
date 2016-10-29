/* OK_GETCHAR() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input a char from std-in at current cursor position		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OK_GETCHAR(short *keyval)
#else
OK_GETCHAR(keyval)
short	*keyval;		/* S9(4) COMP. */
#endif
{
	k_getchar( keyval );
}
