/* OPI_DBUILD2 () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DBUILD2( char *path, struct BUILDFORM *build_inf,	|
|			char *dirpath, int *fd, char *retcode )		|
|									|
|	Build new file							|
|									|
|	input	path		- full file path of document		|
|		build_inf	- information of file			|
|		dirpath		- directory path 			|
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
OPI_DBUILD2( char *docpath, struct BUILDFORM *build_inf, char *dirpath, int *fd, char *retcode )
#else
OPI_DBUILD2( docpath, build_inf, dirpath, fd, retcode )
char			*docpath;		/* X(max.128) */
struct	BUILDFORM	*build_inf;
char			*dirpath;		/* X(max.128) */
int			*fd;			/* S9(8) COMP */
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_docpath[DS_PATHLEN];
	char	l_dirpath[DS_PATHLEN];

	d_mkstr( docpath, DS_PATHLEN-1, l_docpath );
	d_mkstr( dirpath, DS_PATHLEN-1, l_dirpath );

	if( ( l_fd = PI_DBUILD2( l_docpath, build_inf, l_dirpath ) ) < 0 )
		ds_errset( retcode );
	else
	{
		memcpy( fd, &l_fd, sizeof l_fd );
		memset( retcode, ' ', 5 );
	}
}
