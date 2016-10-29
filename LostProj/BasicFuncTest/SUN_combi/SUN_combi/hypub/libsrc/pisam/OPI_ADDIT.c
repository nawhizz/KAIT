/* OPI_ADDIT() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : addit record to isam file					*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ADDIT( char *retcode, int *fd, char *record )
#else
OPI_ADDIT( retcode, fd, record )
char	*retcode;		/* X(5) VALUE SPACE, SPACE=OK */
int	*fd;
char	*record;
#endif
{
	if( PI_ADDIT( *fd, record ) < 0 )
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
