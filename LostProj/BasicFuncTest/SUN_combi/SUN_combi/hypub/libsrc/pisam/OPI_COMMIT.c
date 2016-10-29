/* OPI_COMMIT() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : update all changed record and release all lock		*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_COMMIT( void )
#else
OPI_COMMIT()
#endif
{
	PI_COMMIT() ;
}
