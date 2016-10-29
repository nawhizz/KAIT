/* OSM_DROP() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : drop(remove) sam file 					*/
/*	  if nofile then ok						*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_DROP( char *retcode, char *fpath )
#else
OSM_DROP( retcode, fpath )
char	*retcode;		/* X(5) SPACE=ok */
char	*fpath; 		/* X(80) file path */
#endif
{
	char	l_fpath[81];

	d_mkstr( fpath, 80, l_fpath );
	if( SM_DROP( l_fpath ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
