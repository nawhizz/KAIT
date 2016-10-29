/* OPI_DROLLBACK () : LIB dsml */
/************************************************************************
*	Commit DSML Transaction.
************************************************************************/
#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DROLLBACK( char *retcode )
#else
OPI_DROLLBACK()
char			*retcode;		/* X(5) */
#endif
{
	int	l_ret;

	if( ( l_ret = PI_DROLLBACK() ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
