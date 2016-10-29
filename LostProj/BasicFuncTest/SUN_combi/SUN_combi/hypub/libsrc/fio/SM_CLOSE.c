/* SM_CLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close sam file						*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_CLOSE( FILE	*fp )
#else
SM_CLOSE( fp )
FILE	*fp ;
#endif
{
	if( fclose( fp ) < 0 ) {
		l_fiosethyerrno( errno );
		return( -1 );
	}
	return( 0 ) ;
}
