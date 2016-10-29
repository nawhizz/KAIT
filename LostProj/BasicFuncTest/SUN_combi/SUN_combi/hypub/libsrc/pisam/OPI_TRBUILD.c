/* OPI_TRBUILD() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : build file by exclusive lock and trans			*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_TRBUILD( char *retcode, int *fd, char *filepath, char *fileid )
#else
OPI_TRBUILD( retcode, fd, filepath, fileid )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
char	*filepath;		/* X(max.100) followed by LOWVALUE */
char	*fileid;		/* X(8) */
#endif
{
	char	l_filepath[PI_PATHLEN + 1];
	char	l_fileid[PI_IDLEN + 1];

	d_mkstr( filepath, PI_PATHLEN, l_filepath ) ;
	d_mkstr( fileid, PI_IDLEN, l_fileid ) ;

	if( ( *fd = PI_TRBUILD( l_filepath, l_fileid ) ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
