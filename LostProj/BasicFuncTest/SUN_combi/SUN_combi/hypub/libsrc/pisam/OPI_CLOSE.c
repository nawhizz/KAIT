/* OPI_CLOSE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : close opened file						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_CLOSE( char *retcode, int *fd )
#else
OPI_CLOSE( retcode, fd )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
#endif
{
	if( PI_CLOSE( *fd ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
