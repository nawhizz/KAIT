/* OPI_CHMOD() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : change permission mode of file				*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_CHMOD( char *retcode, char *filepath, int *mode )
#else
OPI_CHMOD( retcode, filepath, mode )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
char	*filepath;		/* X(max.100) followed by LOWVALUE */
int	*mode;			/* S9(8) COMP. */
#endif
{
	char	l_filepath[PI_PATHLEN + 1];

	d_mkstr( filepath, PI_PATHLEN, l_filepath ) ;

	if( PI_CHMOD( l_filepath, *mode ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
