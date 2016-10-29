/* OPI_TRAN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : start transaction and open log file				*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_TRAN( char *retcode )
#else
OPI_TRAN( retcode )
char	*retcode;		/* PIC X(5) VALUE SPACE. SPACE=ok */
#endif
{
	if( PI_TRAN() < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
