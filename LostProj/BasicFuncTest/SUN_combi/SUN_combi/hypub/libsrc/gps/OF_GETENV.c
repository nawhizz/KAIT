/* OF_GETENV() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get ENVIRONMENT value in CFG file				*/
/*----------------------------------------------------------------------*/
#include	<string.h>

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_GETENV( char *cfgfpath, char *envname, char *envval, int *vallen, char *RETSTS )
#else
OF_GETENV( cfgfpath, envname, envval, vallen, RETSTS )
char	*cfgfpath;		/* X(100) */
char	*envname;		/* X(20) */
char	*envval;		/* X(100) */
int	*vallen;		/* S9(8) COMP */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_cfgfpath[101];
	char	l_envname[21];

	d_mkstr( cfgfpath, 100, l_cfgfpath );
	d_mkstr( envname, 20, l_envname );

	if( f_getenv( l_cfgfpath, l_envname, envval ) < 0 )
		RETSTS[0] = 'E';
	else
	{
		*vallen = strlen( envval );
		RETSTS[0] = ' ';
	}
}
