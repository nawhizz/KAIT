/* OE_RUNSYSSTS() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : run command (no redirection, no piping allowed) and return	*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_RUNSYSSTS( char *CMD, char *RETSTS, char *STATUS )
#else
OE_RUNSYSSTS( CMD, RETSTS, STATUS )
char	*CMD;			/* X(300) */
char	*RETSTS;		/* X(1) */
char	*STATUS;		/* X(5) */
#endif
{
	char	l_cmd[300 + 1];
	int	sts;

	memcpy( l_cmd, CMD, 300 );
	d_strendnull( l_cmd, 300 );
	if( ( sts = e_runsyssts( l_cmd ) ) < 0 )
		RETSTS[0] = 'E';
	else
	{
		RETSTS[0] = ' ';
		d_int2ndec( sts, 5, '0', STATUS );
	}
}
