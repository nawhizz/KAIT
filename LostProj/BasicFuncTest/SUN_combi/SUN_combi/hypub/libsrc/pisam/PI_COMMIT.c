/* PI_COMMIT() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : update all changed record and release all lock		*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"pisamdef.h"

void CBD1
#if	defined( __CB_STDC__ )
PI_COMMIT( void )
#else
PI_COMMIT()
#endif
{
	if ( pi_transtart < 2 )
		return;

	iscommit();

	pi_transtart = 1;
}
