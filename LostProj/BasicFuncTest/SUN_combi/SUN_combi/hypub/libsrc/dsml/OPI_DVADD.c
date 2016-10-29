/* OPI_DVADD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DVADD( int *fd, struct VOLFORM *vol_inf,		|
|			char *retcode )					|
|									|
|	Add new volume							|
|									|
|	input	fd		- isam open file desciptor		|
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
OPI_DVADD( int *fd, struct VOLFORM *vol_inf, char *retcode )
#else
OPI_DVADD( fd, vol_inf, retcode )
int		*fd;			/* S9(8) COMP */
struct	VOLFORM	*vol_inf;
char		*retcode;		/* X(5) */
#endif
{
	int		l_fd;
	struct	VOLFORM	l_vol;

	memcpy( &l_fd, fd, sizeof l_fd );
	memcpy( &l_vol, vol_inf, sizeof l_vol );
	d_mkstr( l_vol.volpath, DS_PATHLEN-1, l_vol.volpath );

	if( PI_DVADD( l_fd, &l_vol ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
