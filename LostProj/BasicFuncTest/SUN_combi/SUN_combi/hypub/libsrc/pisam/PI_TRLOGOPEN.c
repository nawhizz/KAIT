/* PI_TRLOGOPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : open transaction logging file					*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<sys/types.h>

#ifndef		WIN32
#include	<unistd.h>
#endif

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_TRLOGOPEN( void )
#else
PI_TRLOGOPEN()
#endif
{
	char	*fpath;
	FILE	*logfd;

	if( pi_transtart > 0 )
		return 0;

	if( ( fpath = getenv( "ISLOGDIR" ) ) == (char *)0 )
	{
		l_pisamsethyerrno( EPI_LOGDIRNDEF );
		return -1;
	}

	strcpy( pi_logfpath, fpath );
	strcat( pi_logfpath, "/" );
	strcat( pi_logfpath, "pilog." );
#ifdef	WIN32
	sprintf( &pi_logfpath[strlen( pi_logfpath )], "%06ld",
					(long)GetCurrentProcessId() );
#else
	sprintf( &pi_logfpath[strlen( pi_logfpath )], "%06ld", getpid() );
#endif

	if ( ( logfd = fopen( pi_logfpath, "w" ) ) == (FILE *)0 ) {
		l_pisamsethyerrno( EPI_LOGOPENERR );
		return -1;
	}
	fclose( logfd );

	if ( islogopen( pi_logfpath ) < 0 ) {
		l_pisamsethyerrno( iserrno );
		unlink( pi_logfpath );
		return -1;
	}
	pi_transtart = 1;

	return 0;
}
