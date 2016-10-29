/* OPI_TRBEGIN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : start transaction						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_TRBEGIN( char *retcode )
#else
OPI_TRBEGIN( retcode )
char	*retcode;		/* PIC X(5) VALUE SPACE. SPACE=ok */
#endif
{
	if( PI_TRBEGIN() < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
