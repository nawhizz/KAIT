/* PI_TRAN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : start transaction and open log file				*/
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
PI_TRAN( void )
#else
PI_TRAN()
#endif
{
	if( pi_transtart < 1 )
	{
		char	*fpath;
		FILE	*logfd;

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
		sprintf( &pi_logfpath[strlen( pi_logfpath )], "%06ld",
								getpid() );
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
	}

	if( pi_transtart < 2 )
	{
		if ( isbegin() < 0 ) {
			l_pisamsethyerrno( iserrno );
			islogclose();
			unlink( pi_logfpath );
			return -1;
		}
		pi_transtart = 2;
	}

	return 0;
}
