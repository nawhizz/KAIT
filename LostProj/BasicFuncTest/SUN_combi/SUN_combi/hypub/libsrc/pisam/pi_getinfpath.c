/* pi_getinfpath() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get infomation file 						*/
/*----------------------------------------------------------------------*/
/* PISAM internal function */

#include	<stdlib.h>
#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

#include <stdio.h>
FILE *lfd;

int	
#if	defined( __CB_STDC__ )
pi_getinfpath( char *fileid, char *infpath )
#else
pi_getinfpath( fileid, infpath )
char	*fileid;
char	*infpath;
#endif
{
	int	envptr=0, pathptr;
	char	*envval;

	if( (envval = getenv( "ISINFO" )) == (char *)0 ) {
		l_pisamsethyerrno( EPI_NOINFENV );
		return(-1);
	}
	
	for( ; ; )
	{
		for( pathptr=0; envval[envptr]!=(char)0; envptr++, pathptr++ )
		{
#ifdef	WIN32
			if( envval[envptr] == ';' )
#else
			if( envval[envptr] == ':' )
#endif
			{					/* ':' skip */
				envptr++;
				break;
			}
			infpath[pathptr] = envval[envptr];
		}
		infpath[pathptr] = 0;

		strcat( infpath, "/" );
		strcat( infpath, fileid );
		strcat( infpath, ".inf" );

#ifndef	WIN32
		if( !access( infpath, F_OK ) )
#else
		if( !access( infpath, 0 ) )
#endif
			return 0;

		if( envval[envptr] == (char)0 )
			break;
	}

	l_pisamsethyerrno( EPI_NOINFFILE );
	return(-1);
}
