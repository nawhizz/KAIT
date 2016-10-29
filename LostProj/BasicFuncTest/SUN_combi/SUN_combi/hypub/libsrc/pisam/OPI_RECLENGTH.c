/* OPI_RECLENGTH() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get length of record						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_RECLENGTH( char *retcode, int *fd, int *recsize )
#else
OPI_RECLENGTH( retcode, fd, recsize )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd;			/* S9(8) COMP VALUE -1. */
int	*recsize;		/* S9(8) COMP. */
#endif
{

	if( ( *recsize = PI_RECLENGTH( *fd ) ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}

