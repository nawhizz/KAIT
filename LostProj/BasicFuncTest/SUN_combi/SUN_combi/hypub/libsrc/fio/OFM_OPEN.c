/* OFM_OPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : open file							*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fm_fun.h"
#include	"fio.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_OPEN( char *retcode, int *fd, char *fileid )
#else
OFM_OPEN( retcode, fd, fileid )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*fileid;			/* X(8) */
#endif
{
	char	l_fileid[FM_IDLEN + 1];

	d_mkstr( fileid, FM_IDLEN, l_fileid );
	if( ( *fd = (int)FM_OPEN( l_fileid ) ) < 0 )
		fm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
