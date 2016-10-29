/* OF_CHOWN() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change owner and group of file or directory			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_CHOWN( char *filepath, char *owner, char *RETSTS )
#else
OF_CHOWN( filepath, owner, RETSTS )
char	*filepath;		/* X(100) */
char	*owner;			/* X(20) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_filepath[100 + 1];
	char	l_owner[20 + 1];

	d_mkstr( filepath, 100, l_filepath );
	d_mkstr( owner, 20, l_owner );

	if( f_chown( l_filepath, l_owner ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
