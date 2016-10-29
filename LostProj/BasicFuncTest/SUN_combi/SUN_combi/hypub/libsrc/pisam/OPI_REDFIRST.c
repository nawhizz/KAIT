/* OPI_REDFIRST() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : read first record						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_REDFIRST( char *retcode, int *fd, char *record )
#else
OPI_REDFIRST( retcode, fd, record )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
char	*record;		/* X(nn) recurd buffer */
#endif
{
	if( PI_REDFIRST( *fd, record ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
