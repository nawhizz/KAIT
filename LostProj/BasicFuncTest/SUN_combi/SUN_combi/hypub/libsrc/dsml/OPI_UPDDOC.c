/* OPI_UPDDOC () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_UPDDOC( int *fd, char *id, char *path,			|
|		struct DSMLFORM *desc, char *retcode )			|
|									|
|	Insert new document from sam file				|
|									|
|	input	fd		- isam open file desciptor		|
|		id		- ID of document			|
|		path		- full file path of document		|
|		desc		- information of document		|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_UPDDOC( int *fd, char *docid, char *docpath, struct DSMLFORM *docdesc,
								char *retcode )
#else
OPI_UPDDOC( fd, docid, docpath, docdesc, retcode )
int			*fd;			/* S9(8) COMP */
char			*docid;			/* 9(8) */
char			*docpath;		/* X(max.128) */
struct	DSMLFORM	*docdesc;
char			*retcode;		/* X(5) */
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

	if( PI_UPDDOC( l_fd, doc_id, l_docpath, docdesc ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
