/* e_runsyssts() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : run command (no redirection, no piping allowed) and return	*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_runsyssts( char *cmd )
#else
e_runsyssts( cmd )
char	*cmd;
#endif
{
	int	narg;
	char	argbuf[300];
	char	*args[20];

	if( cmd == (char *)0 || cmd[0] == (char)0 )
		return( -999 );

	if( (int)strlen( cmd ) > sizeof argbuf )
		return( -888 );

	narg = e_cmdarg( cmd, args, argbuf );

	return( e_runpsts( args[0], args ) );
}
