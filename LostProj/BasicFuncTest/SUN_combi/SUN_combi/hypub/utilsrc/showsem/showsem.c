#include	<stdio.h>
#include	<string.h>

#ifdef	WIN32
#include	"ipcwrap.h"
#else
#include	<sys/types.h>
#include	<sys/ipc.h>
#include	<sys/sem.h>
#endif

#include	<errno.h>

#include	"cbuni.h"

int	d_hextoint CBD2(( char *string, int nstr, int *num ));

int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc
char	*argv[];
#endif
{
	int	semkey = -1;
	int	semid = -1;
	int	i;
	char	tmpstr[20];

	struct	semid_ds semsts;

	union	semun	{
		int	val;
		struct	semid_ds *buf;
		ushort	*array;
	} ctl_arg;

	ctl_arg.buf = &semsts;

	if( argc < 2 )
	{
		printf( "USAGE : %s [SEMKEY | -iSEMID]\n", argv[0] );
		printf( "        SEMKEY is hexadecimal.\n" );
		return( 1 );
	}

	if( argv[1][0] == '-' && argv[1][1] == 'i' )
	{
		strcpy( tmpstr, &argv[1][2] );
		semid = atoi( tmpstr );
	}
	else
		d_hextoint( argv[1], strlen( argv[1] ), &semkey );

	if( semid < 0 )
		if( ( semid = semget( semkey, 0, 0 ) ) < 0 )
		{
			printf( "semget error %d\n", errno );
			return( errno );
		}

	if( semctl( semid, 0, IPC_STAT, ctl_arg ) < 0 )
	{
		printf( "semctl error %d\n", errno );
		return( errno );
	}

	for( i=0; i<(int)ctl_arg.buf->sem_nsems; i++ )
	{
		printf( "[%3dth:%d] ", i, semctl( semid, i, GETVAL, 1 ) );
		if( i % 8 == 7 )
			printf( "\n" );
	}
	printf( "\n" );

	return( 0 );
}

/* d_hextoint() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii hexadecimal string into integer 		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	string[nstr]
		  int	nstr		string length ( not null term. )
	output	: int	*num
	return	: 0
	example :
		  [  9f],[009a],[009A],[0000],[   0]
		    159,   154,   154,	   0,	  0
*/

int
#if	defined( __CB_STDC__ )
d_hextoint( char *string, int nstr, int *num )
#else
d_hextoint( string, nstr, num )
char	*string;
int	nstr;
int	*num;
#endif
{
	register	i;
	int		nn;

	*num = 0;
	for( i=0; i<nstr; i++ )
	{
		if( string[i] == ' ' && *num )		break;
		else if( string[i] == ' ' & ! *num )	nn = 0;
		else if( string[i] > 0x60 )		nn = string[i] - 0x57;
		else if( string[i] > 0x40 )		nn = string[i] - 0x37;
		else					nn = string[i] - 0x30;
		*num = 16 * *num + nn;
	}
	return 0;
}
