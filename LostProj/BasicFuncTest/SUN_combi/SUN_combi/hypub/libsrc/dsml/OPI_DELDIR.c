/* OPI_DELDIR () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DELDIR( int *fd, char *deldirpath, char *retcode )	|
|									|
|	Delete directory from Master Volume				|
|									|
|	input	fd		- isam open file desciptor		|
|		deldirpath	- directory path to delete		|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DELDIR( int *fd, char *deldirpath, char *retcode )
#else
OPI_DELDIR( fd, deldirpath, retcode )
int			*fd;			/* S9(8) COMP */
char			*deldirpath;		/* X(max.128) */
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_deldirpath[DS_PATHLEN];

	memcpy( &l_fd, fd, sizeof l_fd );
	d_mkstr( deldirpath, DS_PATHLEN-1, l_deldirpath );

	if( PI_DELDIR( l_fd, l_deldirpath ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
