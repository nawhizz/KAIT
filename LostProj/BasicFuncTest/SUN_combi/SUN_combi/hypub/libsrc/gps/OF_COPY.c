/* OF_COPY() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : copy 1 file in existing directory				*/
/*		return value : ERR = 'E'				*/
/*			        OK = ' '				*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_COPY( char *spath, char *dpath, char *overwrite, char *RETSTS )
#else
OF_COPY( spath, dpath, overwrite, RETSTS )
char	*spath;			/* X(100) */
char	*dpath;			/* X(100) */
char	*overwrite;		/* X(1) 'Y':overwrite, else:not */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_spath[100 + 1];
	char	l_dpath[100 + 1];

	d_mkstr( spath, 100, l_spath );
	d_mkstr( dpath, 100, l_dpath );

	if( f_copy( l_spath, l_dpath , overwrite[0] ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
