/* PI_TRBEGIN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : start transaction						*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_TRBEGIN( void )
#else
PI_TRBEGIN()
#endif
{
	if ( pi_transtart < 1 ) {
		l_pisamsethyerrno( EPI_TRANNSTART );
		return -1;
	}

	if( pi_transtart < 2 )
	{
		if ( isbegin() < 0 ) {
			l_pisamsethyerrno( iserrno );
			return -1;
		}
		pi_transtart = 2;
	}

	return 0;
}
