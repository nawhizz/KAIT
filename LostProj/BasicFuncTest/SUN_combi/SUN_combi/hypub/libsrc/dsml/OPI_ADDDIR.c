/* OPI_ADDDIR () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_ADDDIR( int *fd, char *dirpath, char *retcode )	|
|									|
|	Insert new directory to Master Volume				|
|									|
|	input	fd		- isam open file desciptor		|
|		dirpath		- directory path to add			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ADDDIR( int *fd, char *dirpath, char *retcode )
#else
OPI_ADDDIR( fd, dirpath, retcode )
int			*fd;			/* S9(8) COMP */
char			*dirpath;		/* X(max.128) */
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_dirpath[DS_PATHLEN];

	memcpy( &l_fd, fd, sizeof l_fd );
	d_mkstr( dirpath, DS_PATHLEN-1, l_dirpath );

	if( PI_ADDDIR( l_fd, l_dirpath ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
