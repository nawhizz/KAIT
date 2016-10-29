/* OPI_TRLOGOPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : open transaction logging file 				*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_TRLOGOPEN( char *retcode )
#else
OPI_TRLOGOPEN( retcode )
char	*retcode;		/* PIC X(5) VALUE SPACE. SPACE=ok */
#endif
{
	if( PI_TRLOGOPEN() < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
