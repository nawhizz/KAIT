/* OFM_GETSIZE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get size of formatted file					*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_GETSIZE( char *retcode, int	*fd, int *formsize )
#else
OFM_GETSIZE( retcode, fd, formsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd, *formsize; 		/* S9(8) COMP */
#endif
{
	if( ( *formsize = FM_GETSIZE( *fd ) ) < 0 )
		fm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
