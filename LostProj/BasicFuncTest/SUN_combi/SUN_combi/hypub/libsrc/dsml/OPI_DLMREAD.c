/* OPI_DLMREAD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DLMREAD( int *fd, int *lmidx,				|
|			struct DS_DIRMINFO *lmbuf, char *retcode )	|
|									|
|	Read master directory information				|
|									|
|	input	fd		- isam open file desciptor		|
|		lmidx		- index of lm				|
|	output	lmbuf		- buffer for lm				|	
|		retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DLMREAD( int *fd, int *lmidx, struct DS_DIRMINFO *lmbuf,  char *retcode )
#else
OPI_DLMREAD( fd, lmidx, lmbuf, retcode )
int			*fd;			/* S9(8) COMP */
int			*lmidx;			
struct DS_DIRMINFO	*lmbuf;			
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	int	l_lmidx;	

	memcpy( &l_fd, fd, sizeof l_fd );
	memcpy( &l_lmidx, lmidx, sizeof l_lmidx );

	if( PI_DLMREAD( l_fd, l_lmidx, lmbuf ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
