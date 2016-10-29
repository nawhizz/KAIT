/* OPI_DLFREAD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DLFREAD( int *fd, int *docid,				|
|			char *filebuf, char *filename, char *retcode )	|
|									|
|	Insert new directory to Master Volume				|
|									|
|	input	fd		- isam open file desciptor		|
|		docid		- document ID				|
|	output	filebuf		- buffer for filepath			|
|		filename	- filename of this docid		|
|		retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DLFREAD( int *fd, int *docid, char *filebuf, char *filename,  char *retcode )
#else
OPI_DLFREAD( fd, docid, filebuf, filename, retcode )
int			*fd;			/* S9(8) COMP */
int			*docid;			
char			*filebuf;			
char			*filename;
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	int	l_docid;	

	memcpy( &l_fd, fd, sizeof l_fd );
	memcpy( &l_docid, docid, sizeof l_docid );

	if( PI_DLFREAD( l_fd, l_docid, filebuf, filename ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
