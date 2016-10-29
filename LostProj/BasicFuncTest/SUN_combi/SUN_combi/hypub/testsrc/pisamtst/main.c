/************************************************************************
*	PISAM library testing program					*
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
extern	void	TPI_TRAN();
extern	void	TPI_ENDTRAN();
extern	void	TPI_COMMIT();
extern	void	TPI_ROLLBACK();
extern	void	TPI_BUILD();
extern	void	TPI_OPEN();
extern	void	TPI_CLOSE();
extern	void	TPI_REDGE();
extern	void	TPI_REDNX();
extern	void	TOPI_REDGE();
extern	void	TOPI_REDNX();
extern	void	TPI_ADDIT();
extern	void	TPI_KEYLENGTH();
extern	void	TOPI_KEYLENGTH();

/*----------------------------------------------------------------------+
|	Display function groups						|
+----------------------------------------------------------------------*/
void
DisplayGroups()
{
	/* screen clear */
/*
#ifndef	WIN32
	printf(   "[1;1H" );
	printf(   "[2J" );
#endif
*/
	printf( "\n" );
	printf( "*********************************************************\n" );
	printf( "*       PISAM library test program                      *\n" );
	printf( "*********************************************************\n" );
	printf( "\n" );
	printf( "*  1. PI_TRAN()        2. PI_ENDTRAN()  3. PI_COMMIT()  *\n");
	printf( "*  4. PI_ROLLBACK()    5. PI_BUILD()    6. PI_OPEN()    *\n" );
	printf( "*  7. PI_CLOSE()                                        *\n" );
	printf( "* 11. PI_READGE()     12. PI_READNX()  13. PI_ADDIT()   *\n" );
	printf( "* 21. OPI_READGE()    22. OPI_READNX()                  *\n" );
	printf( "* 31. PI_KEYLENGTH()                                    *\n" );
	printf( "* 41. OPI_KEYLENGTH()                                   *\n" );
	printf( "*********************************************************\n" );
	printf( "* 99. Exit                                              *\n" );
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

	while( 1 )
	{
		printf( "Choose testing functionp : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );

		switch( choosenum )
		{
		case	99	:	return 0;

		case	1	:	TPI_TRAN();		break;
		case	2	:	TPI_ENDTRAN();		break;
		case	3	:	TPI_COMMIT();		break;
		case	4	:	TPI_ROLLBACK();		break;
		case	5	:	TPI_BUILD();		break;
		case	6	:	TPI_OPEN();		break;
		case	7	:	TPI_CLOSE();		break;
		case	11	:	TPI_REDGE();		break;
		case	12	:	TPI_REDNX();		break;
		case	13	:	TPI_ADDIT();		break;
		case	21	:	TOPI_REDGE();		break;
		case	22	:	TOPI_REDNX();		break;
		case	31	:	TPI_KEYLENGTH();	break;
		case	41	:	TOPI_KEYLENGTH();	break;

		default		:	continue;
		}

		break;
	}

	return( 1 );

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

		if( ChooseGroups() == 0 )
			break;
	}

} /* main */

/****** End of main.c **************************************************/
