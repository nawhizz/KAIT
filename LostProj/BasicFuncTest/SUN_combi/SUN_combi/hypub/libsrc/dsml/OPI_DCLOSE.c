/* OPI_DCLOSE () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DCLOSE( int *fd, char *retcode )			|
|									|
|	Close opened file						|
|									|
|	input	fd		- isam open file desciptor		|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DCLOSE( int *fd, char *retcode )
#else
OPI_DCLOSE( fd, retcode )
int	*fd;			/* S9(8) COMP */
char	*retcode;		/* X(5) */
#endif
{
	int	l_fd;

	memcpy( &l_fd, fd, sizeof l_fd );

	if( PI_DCLOSE( l_fd ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
