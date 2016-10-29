/* OPI_DIFIRST () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DIFIRST( int *fd, int *id,				|
|		struct DSMIFORM *di, char *retcode )			|
|									|
|	Read information of the first document				|
|									|
|	input	fd		- isam open file desciptor		|
|	output	id		- ID of document			|
|		di		- information of document		|
|		retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DIFIRST( int *fd, char *docid, struct DSMIFORM *di, char *retcode )
#else
OPI_DIFIRST( fd, docid, di, retcode )
int			*fd;			/* S9(8) COMP */
char			*docid;			/* 9(8) */
struct	DSMIFORM	*di;
char			*retcode;		/* X(5) */
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

	if( PI_DIFIRST( l_fd, &doc_id, di ) < 0 )
		ds_errset( retcode );
	else
	{
		memset( retcode, ' ', 5 );
		if( verno )
			d_int2ndec( doc_id, 8, '0', docid );
		else
			d_int2ndec( *(short *)(&doc_id), 5, '0', docid );
	}
}
