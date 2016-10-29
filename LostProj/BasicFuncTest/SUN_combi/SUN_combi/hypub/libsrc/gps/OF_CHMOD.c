/* OF_CHMOD() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change permission mode of file or directory			*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_CHMOD( char *filepath, int *mode, char *RETSTS )
#else
OF_CHMOD( filepath, mode, RETSTS )
char	*filepath;		/* X(100) */
int	*mode;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_filepath[100 + 1];

	d_mkstr( filepath, 100, l_filepath );

	if( f_chmod( l_filepath, *mode ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
