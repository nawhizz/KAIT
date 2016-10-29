/************************************************************************/
/*									*/
/*	showshm : 공유메모리의 내용을 보여준다				*/
/*									*/
/*		사용법 : showshm shmkey					*/
/*									*/
/************************************************************************/

#include	<stdio.h>

#ifdef	WIN32
#include	"ipcwrap.h"
#else
#include	<sys/types.h>
#include	<sys/ipc.h>
#include	<sys/shm.h>
#endif

#include	<errno.h>

#include	"cbuni.h"

void	disp_shmdata CBD2(( char *shmaddr, int offset, int shmsize ));
int	d_hextoint CBD2(( char *string, int nstr, int *num ));

int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	int	shmkey=-1, shmid=-1;
	int	offset = 0;
	int	size = 0;
	char	*shmaddr;
	char	tmpstr[20];
	int	shmsize;
	struct	shmid_ds	shminfo;

	if( argc < 2 )
	{
		printf(">> USAGE : showshm [ SHMKEY | -iSHMID ] <offset> <size>\n");
		printf(">>     all input argument in hexa but except SHMID in decimanl\n\n" );
		return( -1 );
	}

	if( argv[1][0] == '-' && argv[1][1] == 'i' )
	{
		strcpy( tmpstr, &argv[1][2] );
		shmid = atoi( tmpstr );
	}
	else
		d_hextoint( argv[1], strlen( argv[1] ), &shmkey );

	if( argc > 2 )
		d_hextoint( argv[2], strlen( argv[2] ), &offset );
	if( argc > 3 )
		d_hextoint( argv[3], strlen( argv[3] ), &size );
	size += offset;


	if( shmid < 0 )
		if( ( shmid = shmget( shmkey, 0, 0 ) ) == -1 )
		{
			printf(">> Cannot access shared memory(shmget:%d)\n",errno);
			return( -2 );
		}

	/* Get information of shared memory :shmsize */
	if( shmctl( shmid, IPC_STAT, &shminfo ) < 0 )
	{
		printf(">> Cannot Get the information of shared memory(shmctl:%d)\n",errno);
		return( -3 );
	}

	if( ( shmaddr = (char *) shmat( shmid, 0, 0 ) ) == (char *)-1 )
	{
		printf(">> Cannot access shared memory(shmget:%d)\n",errno);
		return( -4 );
	}

	if( offset == size )
		shmsize = shminfo.shm_segsz;
	else
		shmsize = shminfo.shm_segsz < (unsigned)size ? shminfo.shm_segsz : size;
	/* Display shm data */
	disp_shmdata( shmaddr, offset, shmsize );
	
	shmdt( shmaddr );

	return( 0 );

} /* main */

void
#if	defined( __CB_STDC__ )
disp_shmdata( char *shmaddr, int offset, int shmsize )
#else
disp_shmdata( shmaddr, offset, shmsize )
char	*shmaddr;
int	offset;
int	shmsize;
#endif
{
	int	i, j;

	printf(">> Content of Shared Memory (SIZE:%d)..............\n",
		shmsize );

	for( i=offset; i<shmsize; )
	{
		printf( "\n%08x  ", i );
		for( j=0; j<16 && (i+j)<shmsize; j++ )
		{
			if( j && !( j % 4 ) )
				printf( " " );
			printf( "%02x", (unsigned char) shmaddr[i+j] );
		}
		if( ( i + j ) == shmsize )
		{
			for( ; j<16; j++ )
			{
				if( j && !( j % 4 ) )
					printf( " " );
				printf( "  " );
			}
		}
		printf( "  " );
		for( j=0; j<16 && i<shmsize; j++, i++ )
		{
			if( (unsigned char) shmaddr[i] < ' ' )
				printf( "." );
			else
				printf( "%c", shmaddr[i] );
		}
	}
	printf("\n........................................................\n");

	return;

} /* disp_shmdata */

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
