/* OPI_SETKEY() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : restart record's index by new key                             */
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_SETKEY( char *retcode, int *fd, char *keyname )
#else
OPI_SETKEY( retcode, fd, keyname )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
char	*keyname;		/* X(2). */
#endif
{
	char	l_keyname[3];

	d_mkstr( keyname, 2, l_keyname ) ;

	if( PI_SETKEY( *fd, l_keyname ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
