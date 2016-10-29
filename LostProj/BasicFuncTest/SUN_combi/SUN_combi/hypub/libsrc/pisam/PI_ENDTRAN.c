/* PI_ENDTRAN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : stop transaction logging					*/
/*----------------------------------------------------------------------*/


#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<iswrap.h>

#include	"pisamdef.h"

void CBD1
#if	defined( __CB_STDC__ )
PI_ENDTRAN( void )
#else
PI_ENDTRAN()
#endif
{
	if( pi_transtart > 1 )
	{
		isrollback();
		pi_transtart = 1;
	}

	if ( pi_transtart > 0 )
	{
		islogclose();
		unlink( pi_logfpath );
		pi_transtart = 0;
	}
}
