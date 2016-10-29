/************************************************************************
*	GPS library testing program ( shared memory )			*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>
#include	<errno.h>

#include	"cbuni.h"

#ifdef	WIN32
#include	"ipcwrap.h"
#else
#include	<sys/types.h>
#include	<sys/ipc.h>
#include	<sys/shm.h>
#endif

#include	"gps.h"

/*---------------------------------------------------------------------*/
void
R_CHKSHM()
{
	char	tmpstr[80];
	int	shmkey;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_chkshm( int shmkey(i) )                       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " shmkey : " );
	scanf( "%s", tmpstr );
	if( ( shmkey = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid shmkey ......\n" );
		return;
	}

	if( r_chkshm( shmkey ) < 0 )
	{
		printf( "r_chkshm error .....\n" );
		return;
	}

	printf( " Result success\n" );

} /* R_CHKSHM */

/*---------------------------------------------------------------------*/
void
R_CRTSHM()
{
	char	tmpstr[80];
	int	shmkey;
	int	size;
	int	shmid;
	char	*shmptr;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_crtshm( int shmkey(i), int size(i),           |\n" );
	printf( "|                 int *shmid(o), char **shmptr(o) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " shmkey        : " );
	scanf( "%s", tmpstr );
	if( ( shmkey = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid shmkey ......\n" );
		return;
	}
	printf( " size          : " );
	scanf( "%s", tmpstr );
	if( ( size = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid size ......\n" );
		return;
	}

	if( r_crtshm( shmkey, size, &shmid, &shmptr ) < 0 )
	{
		printf( "r_crtshm error .....(%d)\n", errno );
		return;
	}

	printf( " Result shmid  : [%d]\n", shmid );
	printf( " Result shmptr : [%x]\n", shmptr );

	shmdt( shmptr );

} /* R_CRTSHM */

/*---------------------------------------------------------------------*/
void
R_DELSHM()
{
	char	tmpstr[80];
	int	shmkey;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_delshm( int shmkey(i) )                       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " shmkey : " );
	scanf( "%s", tmpstr );
	if( ( shmkey = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid shmkey ......\n" );
		return;
	}

	if( r_delshm( shmkey ) < 0 )
	{
		printf( "r_delshm error .....\n" );
		return;
	}

	printf( " Result success\n" );

} /* R_DELSHM */

/*---------------------------------------------------------------------*/
void
R_GETSHM()
{
	char	tmpstr[80];
	int	shmkey;
	int	size;
	int	shmid;
	char	*shmptr;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_getshm( int shmkey(i), int size(i),           |\n" );
	printf( "|                 int *shmid(o), char **shmptr(o) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " shmkey        : " );
	scanf( "%s", tmpstr );
	if( ( shmkey = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid shmkey ......\n" );
		return;
	}
	printf( " size          : " );
	scanf( "%s", tmpstr );
	if( ( size = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid size ......\n" );
		return;
	}

	if( r_getshm( shmkey, size, &shmid, &shmptr ) < 0 )
	{
		printf( "r_getshm error .....\n" );
		return;
	}

	printf( " Result shmid  : [%d]\n", shmid );
	printf( " Result shmptr : [%x]\n", shmptr );

	shmdt( shmptr );

} /* R_GETSHM */

/*----------------------------------------------------------------------+
|	Display function for shared memory				|
+----------------------------------------------------------------------*/
void
DisplaySHMF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( shared memory )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. r_chkshm  2. r_crtshm  3. r_delshm  4. r_getshm\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplaySHMF */

/*----------------------------------------------------------------------+
|	Choose function for shared memory				|
+----------------------------------------------------------------------*/
int
ChooseSHMF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 9 && ( choosenum < 1 || choosenum > 4 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseSHMF */

/*----------------------------------------------------------------------+
|	Main function for shared memory					|
+----------------------------------------------------------------------*/
void
SHMF()
{
	for( ; ; )
	{
		DisplaySHMF();
		switch( ChooseSHMF() )
		{
		case	1	:	R_CHKSHM();	break;
		case	2	:	R_CRTSHM();	break;
		case	3	:	R_DELSHM();	break;
		case	4	:	R_GETSHM();	break;
		default		:			return;
		}
	}

} /* SHMF */

/****** End of shm.c ***************************************************/
