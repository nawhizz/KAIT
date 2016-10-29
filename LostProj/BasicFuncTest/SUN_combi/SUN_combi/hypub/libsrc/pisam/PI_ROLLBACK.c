/* PI_ROLLBACK() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : roll back record						*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"pisamdef.h"

void CBD1
#if	defined( __CB_STDC__ )
PI_ROLLBACK( void )
#else
PI_ROLLBACK()
#endif
{
	if ( pi_transtart < 2 )
		return;

	isrollback();

	pi_transtart = 1;
}
