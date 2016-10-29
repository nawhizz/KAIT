/* PI_REDLE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : read lesser or equal record					*/
/*----------------------------------------------------------------------*/

#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_REDLE( int fd, char *keyname, char *record )
#else
PI_REDLE( fd, keyname, record )
int	fd;
char	*keyname;
char	*record;
#endif
{
	int	isfd;

	if( fd < 0 || fd >= PI_MAXOPEN ) {
		l_pisamsethyerrno( EPI_FDERR );
		return -1;
	}

	if( keyname == (char *)0 || record == (char *)0 )
	{
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if ( !pi_fileinfo[fd].filepath_sav[0] ) {
		l_pisamsethyerrno( EPI_NOPEN );
		return -1;
	}

	isfd = pi_fileinfo[fd].isfd_sav;	/* get saved isfd */

	if ( strcmp( keyname, pi_fileinfo[fd].keyname_sav ) ) {
		if ( PI_START( fd, keyname, record, ISFIRST) < 0 ) {
			return -1;
		}
	}

	if( isread( isfd, record, ISEQUAL ) >= 0 ) {
		return 0;
	}

	if( isread( isfd, record, ISGREAT ) < 0 ) {
		if( isread( isfd, record, ISLAST ) < 0 ) {
			l_pisamsethyerrno( iserrno );
			return -1;
		}
	}
	else {
		if( isread( isfd, record, ISPREV ) < 0 ) {
			l_pisamsethyerrno( iserrno );
			return -1;
		}
	}

	return 0;
}
