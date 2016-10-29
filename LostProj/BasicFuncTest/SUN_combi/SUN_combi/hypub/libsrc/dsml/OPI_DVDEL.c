/* OPI_DVDEL () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DVDEL( int *fd, char *volpath, char *retcode )		|
|									|
|	delete a volume							|
|									|
|	input	fd		- isam open file desciptor		|
|		volpath		- path of volume			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DVDEL( int *fd, char *volpath, char *retcode )
#else
OPI_DVDEL( fd, volpath, retcode );
int	*fd;			/* S9(8) COMP */
char	*volpath;		/* X(max.128) */
char	*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_volpath[DS_PATHLEN];

	memcpy( &l_fd, fd, sizeof l_fd );
	d_mkstr( volpath, DS_PATHLEN-1, l_volpath );

	if( PI_DVDEL( l_fd, l_volpath ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
