/* OPI_DBUILD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DBUILD( char *path, struct BUILDFORM *build_inf,	|
|			int *fd, char *retcode )			|
|									|
|	Build new file							|
|									|
|	input	path		- full file path of document		|
|		build_inf	- information of file			|
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
OPI_DBUILD( char *docpath, struct BUILDFORM *build_inf, int *fd, char *retcode )
#else
OPI_DBUILD( docpath, build_inf, fd, retcode )
char			*docpath;		/* X(max.128) */
struct	BUILDFORM	*build_inf;
int			*fd;			/* S9(8) COMP */
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_docpath[DS_PATHLEN];

	d_mkstr( docpath, DS_PATHLEN-1, l_docpath );

	if( ( l_fd = PI_DBUILD( l_docpath, build_inf ) ) < 0 )
		ds_errset( retcode );
	else
	{
		memcpy( fd, &l_fd, sizeof l_fd );
		memset( retcode, ' ', 5 );
	}
}
