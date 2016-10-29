/* OFM_CLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close formatted form file					*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_CLOSE( char	*retcode, int *fd )
#else
OFM_CLOSE( retcode, fd )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
#endif
{
	if( FM_CLOSE( *fd ) < 0 )
		fm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
