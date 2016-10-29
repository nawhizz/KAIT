/* OPI_ROLLBACK() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : roll back record						*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ROLLBACK( void )
#else
OPI_ROLLBACK()
#endif
{
	PI_ROLLBACK() ;
}
