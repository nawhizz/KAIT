/* OPI_RECSIZE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get size of record						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_RECSIZE( char *retcode, char *fileid, int *recsize )
#else
OPI_RECSIZE( retcode, fileid, recsize )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
char	*fileid;		/* X(8) */
int	*recsize;		/* S9(8) COMP. */
#endif
{
	char	l_fileid[PI_IDLEN + 1];

	d_mkstr( fileid, PI_IDLEN, l_fileid ) ;

	if( ( *recsize = PI_RECSIZE( l_fileid ) ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}

