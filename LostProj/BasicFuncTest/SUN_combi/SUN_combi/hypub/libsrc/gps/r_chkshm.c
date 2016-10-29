/* r_chkshm() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check if shared memory exist ( for given shared memory key )	*/
/*----------------------------------------------------------------------*/
/*
	input	: int 	shmkey		shared memory key ( int )
		: int	size		shared memory size ( bytes )
					( must not greater than actual size )
	return	: 0 (exist)
		  -1 (none)
*/

#include	<sys/types.h>

#ifndef		WIN32
#include	<sys/ipc.h>
#include	<sys/shm.h>
#else
#include	"ipcwrap.h"
#endif

#include	"gps.h"

#define 	R_PERMS 	0666	/* permision=rw(own)/rw(grp)/rw(oth) */

int CBD1
#if	defined( __CB_STDC__ )
r_chkshm( int shmkey )
#else
r_chkshm( shmkey )
int	shmkey;
#endif
{
	if( shmget( (key_t)shmkey, 0, R_PERMS | IPC_ALLOC ) < 0 )
		return(-1);

	return(0);
}
