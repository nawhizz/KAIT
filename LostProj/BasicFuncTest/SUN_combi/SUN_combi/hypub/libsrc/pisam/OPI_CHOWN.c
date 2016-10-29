/* OPI_CHOWN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : change owner and group of file				*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_CHOWN( char *retcode, char *filepath, char *owner )
#else
OPI_CHOWN( retcode, filepath, owner )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
char	*filepath;		/* X(max.100) followed by LOWVALUE */
char	*owner;			/* X(20) */
#endif
{
	char	l_filepath[PI_PATHLEN + 1];
	char	l_owner[20 + 1];

	d_mkstr( filepath, PI_PATHLEN, l_filepath ) ;
	d_mkstr( owner, 20, l_owner ) ;

	if( PI_CHOWN( l_filepath, l_owner ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
