/* OPI_DHREAD () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DHREAD( int *fd, struct DSMMFORM *dm, char *retcode )	|
|									|
|	Read DSML header						|
|									|
|	input	fd		- isam open file desciptor		|
|	output	dm		- information of DSML header		|
|		retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DHREAD( int *fd, struct DSMMFORM *dm, char *retcode )
#else
OPI_DHREAD( fd, dm, retcode )
int			*fd;			/* S9(8) COMP */
struct	DSMMFORM	*dm;
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;

	memcpy( &l_fd, fd, sizeof l_fd );

	if( PI_DHREAD( l_fd, dm ) < 0 )
		ds_errset( retcode );
	else
	{
		int	i;

		memset( retcode, ' ', 5 );
		for( i=0; i<sizeof dm->version; i++ )
			if( dm->version[i] == (char)0 )
				break;
		for( ; i<sizeof dm->version; i++ )
			dm->version[i] = ' ';
	}
}
