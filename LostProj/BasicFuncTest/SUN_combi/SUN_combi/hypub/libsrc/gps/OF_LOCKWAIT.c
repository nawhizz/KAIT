/* OF_LOCKWAIT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : file lock wait mechanism for any raw file			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_LOCKWAIT ( int *fd,char *RETSTS )
#else
OF_LOCKWAIT ( fd,RETSTS )
int	*fd;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( f_lockwait( *fd ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
