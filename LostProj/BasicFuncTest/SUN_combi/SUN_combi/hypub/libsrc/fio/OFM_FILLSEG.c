/* OFM_FILLSEG() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : fill data in one masked segment				*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fm_fun.h"
#include	"fio.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_FILLSEG( char *retcode, int *fd, char *segid, char *data, int *datalen,
	char *dest, int *destlen, char *maskchar, int *fillsize )
#else
OFM_FILLSEG( retcode, fd, segid, data, datalen, dest, destlen, maskchar, fillsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd, *datalen, *destlen;	/* S9(8) COMP */
char	*segid; 			/* X(20) */
char	*data, *dest;			/* X(n) */
char	*maskchar;			/* X(1) */
int	*fillsize;		      /* S9(8) COMP */
#endif
{
	char	l_segid[FM_SEGIDLEN + 1];

	d_mkstr( segid, FM_SEGIDLEN, l_segid );
	*fillsize = (int) FM_FILLSEG( (int)(*fd), l_segid, data,
		(int)(*datalen), dest, (int)(*destlen), (char)(*maskchar) );
	if( *fillsize < 0 )
		fm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
