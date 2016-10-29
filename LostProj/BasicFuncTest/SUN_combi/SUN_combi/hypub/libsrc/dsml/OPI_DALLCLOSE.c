/* OPI_DALLCLOSE () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DALLCLOSE( char *retcode )				|
|									|
|	Close all opened file						|
|									|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DALLCLOSE( char *retcode )
#else
OPI_DALLCLOSE( retcode )
char	*retcode;		/* X(5) */
#endif
{
	if( PI_DALLCLOSE() < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
