/* OPI_DHCHK () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DHCHK( int *fd, char *retcode )			|
|									|
|	Check DSML header						|
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
OPI_DHCHK( int *fd, char *retcode )
#else
OPI_DHCHK( fd, retcode )
int	*fd;			/* S9(8) COMP */
char	*retcode;		/* X(5) */
#endif
{
	int	l_fd;

	memcpy( &l_fd, fd, sizeof l_fd );

	if( PI_DHCHK( l_fd ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
