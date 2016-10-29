/* OPI_DCOMMIT () : LIB dsml */
/************************************************************************
*	Commit DSML Transaction.
************************************************************************/
#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DCOMMIT( char *retcode )
#else
OPI_DCOMMIT()
char			*retcode;		/* X(5) */
#endif
{
	int	l_ret;

	if( ( l_ret = PI_DCOMMIT() ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
