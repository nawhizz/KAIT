/* OD_MKSTR() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : make buffer to NULL terminated string right spaces ignored	*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_MKSTR( char *src, int *srcsize, char *dest )
#else
OD_MKSTR( src, srcsize, dest )
char	*src;			/* X(srcsize) */
int	*srcsize;		/* S9(8) COMP. */
char	*dest;			/* X(srcsize+1) */
#endif
{
	d_mkstr( src, *srcsize, dest );
}
