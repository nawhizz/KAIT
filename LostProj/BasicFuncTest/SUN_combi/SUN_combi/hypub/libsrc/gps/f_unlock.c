/* f_unlock() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : file unlock mechanism for any raw file			*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/

#ifndef		WIN32
#include	<sys/types.h>
#include	<fcntl.h>
#else
#include	<io.h>
#include	<stdio.h>
#include	<sys/locking.h>
#endif

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
f_unlock ( int fd )
#else
f_unlock ( fd )
int	fd;
#endif
{
#ifndef	WIN32
	struct flock linfo;

	linfo.l_type = F_UNLCK;
	linfo.l_whence = 0;
	linfo.l_start = 0L;
	linfo.l_len = 0L;

	if( fcntl(fd, F_SETLK, (int)&linfo) < 0 )
		return( -1 );
#else
        long    curpos;

        if( ( curpos = tell( fd ) ) < 0 )
                return( -1 );
        if( lseek( fd, 0L, SEEK_SET ) < 0 )
                return( -1 );
        if( locking( fd, _LK_UNLCK, 1 ) < 0 )
                return( -1 );
        if( lseek( fd, curpos, SEEK_SET ) < 0 )
                return( -1 );
#endif
	return( 0 );
}
