/* OPI_TRLOGCLOSE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : close transation logging file 				*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_TRLOGCLOSE( void )
#else
OPI_TRLOGCLOSE()
#endif
{
	PI_TRLOGCLOSE() ;
}

