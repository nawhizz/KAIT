/* OF_UNLOCK() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : file unlock mechanism for any raw file			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_UNLOCK ( int *fd, char *RETSTS )
#else
OF_UNLOCK ( fd, RETSTS )
int	*fd;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( f_unlock( *fd ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
