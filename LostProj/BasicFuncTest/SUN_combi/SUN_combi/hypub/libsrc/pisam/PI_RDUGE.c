/* PI_RDUGE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : read great or equal record for addit or update		*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_RDUGE( int fd, char *keyname, char *record )
#else
PI_RDUGE( fd, keyname, record )
int	fd;
char	*keyname;
char	*record;
#endif
{
	int	isfd;
	int	read_mode;

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
		if ( PI_START( fd, keyname, record, ISGTEQ) < 0 ) {
			return -1;
		}
		read_mode = ISCURR;
	}
	else	read_mode = ISGTEQ;

	if( pi_transtart > 1 ) read_mode += ISLCKW;

	if( isread( isfd, record, read_mode ) < 0 )  {
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	return 0;
}
