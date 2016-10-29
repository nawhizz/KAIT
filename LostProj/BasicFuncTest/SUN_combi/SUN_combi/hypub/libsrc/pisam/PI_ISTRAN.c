/* PI_ISTRAN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : return transaction status					*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_ISTRAN( void )
#else
PI_ISTRAN()
#endif
{
	return( pi_transtart );
}
