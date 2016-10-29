/* e_cmdarg() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : seperate argument from command				*/
/*----------------------------------------------------------------------*/
/*
	first argument = program name
	return : >0 ( number of arg including program name)
*/

#include	<string.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_cmdarg( char *cmd, char *args[], char *argbuf )
#else
e_cmdarg( cmd, args, argbuf )
char	*cmd;
char	*args[];
char	*argbuf;
#endif
{
	int		narg = 0;
	int		bufptr = 0;
	register	cmdptr;

	/* get arguments */
	for( cmdptr=0; cmd[cmdptr] ; cmdptr++ ) {
		/* get args[narg] start ptr */
		if( cmd[cmdptr] != ' ' )
		{
			args[narg++] = &argbuf[bufptr];
			for( ; cmd[cmdptr] && cmd[cmdptr]!=' '; cmdptr++ )
				argbuf[bufptr++] = cmd[cmdptr];
			argbuf[bufptr++] = '\0';
		}
	}
	args[narg++] = (char *)0;
	args[narg--] = (char *)0;
	return( narg );
}
