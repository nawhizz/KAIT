/* OPI_EDROP() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : delete file							*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_EDROP( char *retcode, char *fileid, char *fileext )
#else
OPI_EDROP( retcode, fileid, fileext )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
char	*fileid;		/* X(8) */
char	*fileext;		/* X(max.40) followed by LOWVALUE */
#endif
{
	d_mkstr( fileid, PI_IDLEN, fileid ) ;
	d_mkstr( fileext, PI_EXTLEN, fileext ) ;

	if( PI_EDROP( fileid, fileext ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
