/* OE_GETENV() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get ENVIRONMENT value 					*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GETENV( char *envname, char *envval, int *vallen, char *RETSTS )
#else
OE_GETENV( envname, envval, vallen, RETSTS )
char	*envname;		/* X(20) */
char	*envval;		/* X(100) */
int	*vallen;		/* S9(8) COMP */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_envname[21];

	d_mkstr( envname, 20, l_envname );

	if( e_getenv( l_envname, envval ) < 0 )
		RETSTS[0] = 'E';
	else
	{
		*vallen = (int)strlen( envval );
		RETSTS[0] = ' ';
	}
}
