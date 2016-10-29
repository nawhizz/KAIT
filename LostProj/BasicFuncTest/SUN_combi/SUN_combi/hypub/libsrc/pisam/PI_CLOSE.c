/* PI_CLOSE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : close opened file						*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_CLOSE( int fd )
#else
PI_CLOSE( fd )
int	fd;
#endif
{
	register	i;
	int		isfd;

	if( ( fd < 0 ) || ( fd >= PI_MAXOPEN ) ) {
		l_pisamsethyerrno( EPI_FDERR );
		return -1;
	}

	if ( !pi_fileinfo[fd].filepath_sav[0] ) {
		l_pisamsethyerrno( EPI_NOPEN );
		return -1;
	}

	isfd = pi_fileinfo[fd].isfd_sav;	/* get saved isfd */

	if( isclose( isfd ) < 0 )  {
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	pi_fileinfo[fd].filepath_sav[0] = '\0';
	pi_fileinfo[fd].infpath_sav[0] = '\0';
	pi_fileinfo[fd].isfd_sav = -1;
	pi_fileinfo[fd].keyname_sav[0] = '\0';
	for (i=0; i<PI_MAXKEY; i++)
		pi_fileinfo[fd].pi_keyinfo[i].kname[0]='\0';

	if( pi_currfd < 0 ) pi_currfd = fd;

	return 0;
}
