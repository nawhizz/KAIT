/************************************************************************
*	GPS library testing program					*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>

#include	"cbuni.h"

/*----------------------------------------------------------------------+
|	Function proto-types						|
+----------------------------------------------------------------------*/
void	DataManF();
void	RingF();
void	FIOF();
void	KIOF();
void	NetWorkF();
void	ProcessF();
void	DateManF();
void	SHMF();
void	FIFOF();
void	CFGF();
void	EtcF();
void	CobolF();

/*----------------------------------------------------------------------+
|	Display function groups						|
+----------------------------------------------------------------------*/
void
DisplayGroups()
{
	printf( "\n" );
	printf( "*********************************************************\n" );
	printf( "*       GPS library test program                        *\n" );
	printf( "*********************************************************\n" );
	printf( "\n" );
	printf( "  1. Test functions for data maniplation\n" );
	printf( "  2. Test functions for ring buffer\n" );
	printf( "  3. Test functions for file I/O\n" );
	printf( "  4. Test functions for keyboard I/O\n" );
	printf( "  5. Test functions for network interface\n" );
	printf( "  6. Test functions for process interface\n" );
	printf( "  7. Test functions for date maniplation\n" );
	printf( "  8. Test functions for shared memory\n" );
	printf( "  9. Test functions for rotational FIFO\n" );
	printf( " 10. Test functions for configuration file\n" );
	printf( " 11. Test functions for etc..\n" );
	printf( " 12. Test functions for cobol only\n" );
	printf( " 99. Exit\n" );
	printf( "\n" );
	printf( "*********************************************************\n" );
	printf( "\n" );

} /* DisplayGroups */

/*----------------------------------------------------------------------+
|	Choose function group						|
+----------------------------------------------------------------------*/
int
ChooseGroups()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 99 && ( choosenum < 1 || choosenum > 12 ) )
	{
		printf( "Choose testing group : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseGroups */

/*----------------------------------------------------------------------+
|	Main function							|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
main( int argc, char argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	for( ; ; )
	{
		DisplayGroups();
		switch( ChooseGroups() )
		{
		case	 1	:	DataManF();	break;
		case	 2	:	RingF();	break;
		case	 3	:	FIOF();		break;
		case	 4	:	KIOF();		break;
		case	 5	:	NetWorkF();	break;
		case	 6	:	ProcessF();	break;
		case	 7	:	DateManF();	break;
		case	 8	:	SHMF();		break;
		case	 9	:	FIFOF();	break;
		case	10	:	CFGF();		break;
		case	11	:	EtcF();		break;
		case	12	:	CobolF();	break;
		default		:			return;
		}
	}

} /* main */

/****** End of main.c **************************************************/
