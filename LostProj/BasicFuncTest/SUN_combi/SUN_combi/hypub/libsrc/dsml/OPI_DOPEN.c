/* OPI_DOPEN () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DOPEN( char *path, int *fd, char *retcode )		|
|									|
|	Open a file read only						|
|									|
|	input	path		- full file path of document		|
|	output	fd		- isam open file desciptor		|
|		retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DOPEN( char *docpath, int *fd, char *retcode )
#else
OPI_DOPEN( docpath, fd, retcode )
char	*docpath;		/* X(max.128) */
int	*fd;			/* S9(8) COMP */
char	*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_docpath[DS_PATHLEN];

	d_mkstr( docpath, DS_PATHLEN-1, l_docpath );

	if( ( l_fd = PI_DOPEN( l_docpath ) ) < 0 )
		ds_errset( retcode );
	else
	{
		memcpy( fd, &l_fd, sizeof l_fd );
		memset( retcode, ' ', 5 );
	}
}
