/* OPI_DVREN () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DVREN( int *fd, char *svolpath, char *dvolpath,	|
|			char *retcode )					|
|									|
|	Rename volume path						|
|									|
|	input	fd		- isam open file desciptor		|
|		svolpath	- path of from volume			|
|		dvolpath	- path of to volume			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DVREN( int *fd, char *svolpath, char *dvolpath, char *retcode )
#else
OPI_DVREN( fd, svolpath, dvolpath, retcode );
int	*fd;			/* S9(8) COMP */
char	*svolpath;		/* X(max.128) */
char	*dvolpath;		/* X(max.128) */
char	*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_svolpath[DS_PATHLEN];
	char	l_dvolpath[DS_PATHLEN];

	memcpy( &l_fd, fd, sizeof l_fd );
	d_mkstr( svolpath, DS_PATHLEN-1, l_svolpath );
	d_mkstr( dvolpath, DS_PATHLEN-1, l_dvolpath );

	if( PI_DVREN( l_fd, l_svolpath, l_dvolpath ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
