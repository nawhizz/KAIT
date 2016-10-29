/* OPI_REDDOC () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_REDDOC( int *fd, char *id, char *path, char *retcode )	|
|									|
|	Read a document to sam file					|
|									|
|	input	fd		- isam open file desciptor		|
|		id		- ID of document			|
|		path		- full file path of document		|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_REDDOC( int *fd, char *docid, char *docpath, char *retcode )
#else
OPI_REDDOC( fd, docid, docpath, retcode )
int	*fd;			/* S9(8) COMP */
char	*docid;			/* 9(8) */
char	*docpath;		/* X(max.128) */
char	*retcode;		/* X(5) */
#endif
{
	int	doc_id;
	int	verno;
	int	l_fd;
	char	l_docpath[DS_PATHLEN];

	memcpy( &l_fd, fd, sizeof l_fd );

	if( ds_getver( l_fd, &verno ) < 0 )
	{
		ds_errset( retcode );
		return;
	}

	doc_id = d_ndec2int( docid, verno ? 8 : 5 );
	d_mkstr( docpath, DS_PATHLEN-1, l_docpath );

	if( PI_REDDOC( l_fd, doc_id, l_docpath ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
