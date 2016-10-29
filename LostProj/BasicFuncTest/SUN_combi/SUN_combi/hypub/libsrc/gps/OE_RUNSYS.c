/* OE_RUNSYS() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : run command (no redirection, no piping allowed)		*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_RUNSYS( char *CMD, char *RETSTS )
#else
OE_RUNSYS( CMD, RETSTS )
char	*CMD;			/* X(300) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_cmd[300 + 1];

	memcpy( l_cmd, CMD, 300 );
	d_strendnull( l_cmd, 300 );
	if( e_runsys( l_cmd ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
