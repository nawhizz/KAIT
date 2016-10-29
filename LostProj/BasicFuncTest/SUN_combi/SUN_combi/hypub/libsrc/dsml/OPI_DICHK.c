/* OPI_DICHK () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DICHK( int *fd, int *id, char *retcode )		|
|									|
|	Check information of the document				|
|									|
|	input	fd		- isam open file desciptor		|
|		id		- ID of document			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DICHK( int *fd, char *docid, char *retcode )
#else
OPI_DICHK( fd, docid, retcode )
int	*fd;			/* S9(8) COMP */
char	*docid;			/* 9(8) */
char	*retcode;		/* X(5) */
#endif
{
	int	doc_id;
	int	verno;
	int	l_fd;

	memcpy( &l_fd, fd, sizeof l_fd );

	if( ds_getver( l_fd, &verno ) < 0 )
	{
		ds_errset( retcode );
		return;
	}

	if( verno )
		doc_id = d_ndec2int( docid, 8 );
	else
		*(short *)(&doc_id) = d_ndec2int( docid, 5 );

	if( PI_DICHK( l_fd, doc_id ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
