/* PI_INFPATH() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : delete file							*/
/*----------------------------------------------------------------------*/

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_INFPATH( char *fileid, char *infpath )
#else
PI_INFPATH( fileid, infpath )
char	*fileid;
char	*infpath;
#endif
{
	if( fileid == (char *)0 || infpath == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if( pi_getinfpath( fileid, infpath ) < 0 ) {
		return -1;
	}
	return	0;
}
