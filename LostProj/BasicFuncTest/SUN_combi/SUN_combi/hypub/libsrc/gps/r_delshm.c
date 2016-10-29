/* r_delshm() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : delete shared memory ( regarding to shared memory key  )	*/
/*	  calling user id must have effective as super user /or/ itself */
/*----------------------------------------------------------------------*/
/*
	input	: int   shmkey		shared memory key
	return	: 0/-1
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
r_delshm( int shmkey )
#else
r_delshm( shmkey )
int  	shmkey;
#endif
{
	int	shmid;

	if( ( shmid = shmget( (key_t)shmkey, 0, R_PERMS | IPC_ALLOC ) ) < 0 )
		return( -1 );

	if( shmctl( shmid, IPC_RMID, (struct shmid_ds *)0 ) < 0 )
		return( -1 );

	return( 0 );
}
