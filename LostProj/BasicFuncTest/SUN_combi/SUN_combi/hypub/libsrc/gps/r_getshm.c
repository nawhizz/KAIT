/* r_getshm() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get shared memory id, pointer ( for given shared memory key ) */
/*----------------------------------------------------------------------*/
/*
	input	: int   shmkey		shared memory key ( int )
		  int	size		shared memory size ( bytes )
					( must not greater than actual size )
	output	: int	*shmid		shared memory id
		  char	*shmptr 	shared memory start pointer
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
r_getshm( int shmkey, int size, int *shmid, char **shmptr )
#else
r_getshm( shmkey, size, shmid, shmptr )
int  	shmkey;
int	size;
int	*shmid;
char	**shmptr;
#endif
{
	if( ( *shmid = shmget( (key_t)shmkey, size, R_PERMS | IPC_ALLOC) ) < 0 )
		return( -1 );	/* cannot get shared memory segment */

	if( ( *shmptr = (char *)shmat( *shmid, (void *)0, 0 ) ) == (char *)-1 )
		return( -1 );	/* cannot attach shared memory segment */

	return( 0 );
}
