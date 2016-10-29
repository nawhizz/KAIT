/* OPI_RECNO() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get number of record						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_RECNO( char *retcode, int *fd, int *recno )
#else
OPI_RECNO( retcode, fd, recno )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
int	*recno ;		/* S9(8) COMP VALUE -1. */
#endif
{
	if( PI_RECNO( *fd, recno ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
