/* OF_UNLINK() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change permission mode of file or directory			*/
/*----------------------------------------------------------------------*/

#ifdef		WIN32
#include	<stdio.h>
#include	<io.h>
#endif

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_UNLINK( char *filepath, char *RETSTS )
#else
OF_UNLINK( filepath, RETSTS )
char	*filepath;		/* X(100) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_filepath[100 + 1];

	d_mkstr( filepath, 100, l_filepath );

	if( unlink( l_filepath ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
