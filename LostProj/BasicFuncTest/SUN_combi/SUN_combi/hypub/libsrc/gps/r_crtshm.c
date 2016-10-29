/* r_crtshm() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : create my shared memory id, pointer (for given shared 	*/
/*	  memory key)							*/
/*	  if already exist, than get it 				*/
/*----------------------------------------------------------------------*/
/*
	input	: int   shmkey		shared memory key ( int )
		  int	size		shared memory size to create
					(must not greater than defined if
					 already exist )
	output	: int	*shmid		shared memory id
		: char	**shmptr	shared memory start pointer
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
r_crtshm( int shmkey, int size, int *shmid, char **shmptr )
#else
r_crtshm( shmkey, size, shmid, shmptr )
int  	shmkey;
int	size;
int	*shmid;
char	**shmptr;
#endif
{
	/* cannot get shared memory segment */
	*shmid = shmget( (key_t)shmkey, size, R_PERMS | IPC_CREAT );
	if( *shmid < 0 )
		return( -1 );

	/* cannot attach shared memory segment */
	if( ( *shmptr = (char *)shmat( *shmid, (void *)0, 0 ) ) == (char *)-1 )
		return( -1 );

	return( 0 );
}
