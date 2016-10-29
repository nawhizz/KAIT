/* OPI_REDGE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : read great or equal record					*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_REDGE( char *retcode, int *fd, char *keyname, char *record )
#else
OPI_REDGE( retcode, fd, keyname, record )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
char	*keyname;		/* X(2). */
char	*record;		/* X(nn) recurd buffer */
#endif
{
	char	l_keyname[3];

	d_mkstr( keyname, 2, l_keyname ) ;

	if( PI_REDGE( *fd, l_keyname, record ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
