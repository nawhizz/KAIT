/* PI_DELET() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : delete record in file						*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_DELET( int fd, char *record )
#else
PI_DELET( fd, record )
int	fd;
char	*record;
#endif
{
	int	isfd;

	if( fd < 0 || fd >= PI_MAXOPEN ) {
		l_pisamsethyerrno( EPI_FDERR );
		return -1;
	}

	if( record == (char *)0 )
	{
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if ( !pi_fileinfo[fd].filepath_sav[0] ) {
		l_pisamsethyerrno( EPI_NOPEN );
		return -1;
	}

	isfd = pi_fileinfo[fd].isfd_sav;	/* get saved isfd */

	if( isdelete( isfd, record ) < 0 )	{
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	return 0;
}
