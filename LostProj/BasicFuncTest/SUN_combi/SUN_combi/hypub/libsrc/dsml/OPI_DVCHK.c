/* OPI_DVCHK () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DVCHK( int *fd, int *volno, char *retcode )		|
|									|
|	Check volume information					|
|									|
|	input	fd		- isam open file desciptor		|
|		volno		- ID of document			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DVCHK( int *fd, int *volno, char *retcode )
#else
OPI_DVCHK( fd, volno, retcode )
int	*fd;			/* S9(8) COMP */
int	*volno;			/* S9(8) COMP */
char	*retcode;		/* X(5) */
#endif
{
	int	l_volno;
	int	l_fd;

	memcpy( &l_fd, fd, sizeof l_fd );
	memcpy( &l_volno, volno, sizeof l_volno );

	if( PI_DVCHK( l_fd, l_volno ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
