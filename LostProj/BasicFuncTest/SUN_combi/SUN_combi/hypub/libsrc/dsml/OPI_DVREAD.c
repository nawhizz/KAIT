/* OPI_DVREAD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DVREAD( int *fd, int *volno, struct DSMVFORM *vol_inf,	|
|			char *retcode )					|
|									|
|	Add new volume							|
|									|
|	input	fd		- isam open file desciptor		|
|		volno		- volume number				|
|		vol_inf		- information of volume			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DVREAD( int *fd, int *volno, struct DSMVFORM *vol_inf, char *retcode )
#else
OPI_DVREAD( fd, volno, vol_inf, retcode )
int			*fd;			/* S9(8) COMP */
int			*volno;			/* S9(8) COMP */
struct	DSMVFORM	*vol_inf;
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	int	l_volno;

	memcpy( &l_fd, fd, sizeof l_fd );
	memcpy( &l_volno, volno, sizeof l_volno );

	if( PI_DVREAD( l_fd, l_volno, vol_inf ) < 0 )
		ds_errset( retcode );
	else
	{
		int	i;

		memset( retcode, ' ', 5 );
		for( i=0; i<sizeof vol_inf->volpath; i++ )
			if( vol_inf->volpath[i] == (char)0 )
				break;
		for( ; i<sizeof vol_inf->volpath; i++ )
			vol_inf->volpath[i] = ' ';
	}
}
