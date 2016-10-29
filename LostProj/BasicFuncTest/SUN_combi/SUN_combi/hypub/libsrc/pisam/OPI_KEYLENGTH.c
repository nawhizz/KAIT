/* OPI_KEYLENGTH() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get length of key						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_KEYLENGTH( char *retcode, int *fd, char *keyname, int *keysize )
#else
OPI_KEYLENGTH( retcode, fd, keyname, keysize )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd;			/* S9(8) COMP VALUE -1. */
char	*keyname;		/* X(2) */
int	*keysize;		/* S9(8) COMP. */
#endif
{
	if( ( *keysize = PI_KEYLENGTH( *fd, keyname ) ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
