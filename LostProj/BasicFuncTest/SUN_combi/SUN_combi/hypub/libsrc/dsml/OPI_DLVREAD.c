/* OPI_DLVREAD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DLVREAD( int *fd, int *lvidx,				|
|			struct DS_DIRVINFO *lvbuf, char *retcode )	|
|									|
|	Read information of sub directory				|
|									|
|	input	fd		- isam open file desciptor		|
|		volno		- volume number				|
|		lvidx		- index of subdirectory			|
|	output	lvbuf		- structure of lv			|
|		retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DLVREAD( int *fd, int *volno, int *lvidx, struct DS_DIRVINFO *lvbuf,  char *retcode )
#else
OPI_DLVREAD( fd, volno, lvidx, lvbuf, retcode )
int			*fd;			/* S9(8) COMP */
int			*volno;
int			*lvidx;			
struct DS_DIRVINFO	*lvbuf;			
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	int	l_volno;
	int	l_lvidx;

	memcpy( &l_fd, fd, sizeof l_fd );
	memcpy( &l_volno, volno, sizeof l_volno );
	memcpy( &l_lvidx, lvidx, sizeof l_lvidx );

	if( PI_DLVREAD( l_fd, l_volno, l_lvidx, lvbuf ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
