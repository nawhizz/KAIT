/* PI_TRLOGCLOSE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : close transation logging file 				*/
/*----------------------------------------------------------------------*/

#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
PI_TRLOGCLOSE( void )
#else
PI_TRLOGCLOSE()
#endif
{
	PI_ENDTRAN();
}
