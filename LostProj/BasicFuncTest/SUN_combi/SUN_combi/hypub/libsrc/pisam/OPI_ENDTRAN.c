/* OPI_ENDTRAN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : stop transaction logging					*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ENDTRAN( void )
#else
OPI_ENDTRAN()
#endif
{
	PI_ENDTRAN() ;
}

