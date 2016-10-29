/************************************************************************
*	GPS library testing program ( others )				*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>

#include	"cbuni.h"

#include	"gps.h"

/*---------------------------------------------------------------------*/
void
TRACELOG()
{
	return;
} /* TRACELOG */

/*---------------------------------------------------------------------*/
void
E_ADDSIGACT()
{
	return;
} /* E_ADDSIGACT */

/*---------------------------------------------------------------------*/
void
E_DELENV()
{
	char	envname[128];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_delenv( char *envname(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " envname : " );
	scanf( "%s", envname );

	if( e_delenv( envname ) < 0 )
	{
		printf( "e_delenv error ....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* E_DELENV */

/*---------------------------------------------------------------------*/
void
E_GETENV()
{
	char	envname[128];
	char	envvalue[1024];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_getenv( char *envname(i), char *envvalue(o) ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " envname         : " );
	scanf( "%s", envname );

	if( e_getenv( envname, envvalue ) < 0 )
	{
		printf( "e_getenv error ....\n" );
		return;
	}

	printf( " Result envvalue : [%s]\n", envvalue );

} /* E_GETENV */

/*---------------------------------------------------------------------*/
void
E_SETENV()
{
	char	envname[128];
	char	envvalue[1024];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_setenv( char *envname(i), char *envvalue(i) ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " envname  : " );
	scanf( "%s", envname );
	printf( " envvalue : " );
	gets( envvalue );
	gets( envvalue );


	if( e_setenv( envname, envvalue ) < 0 )
	{
		printf( "e_setenv error ....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* E_SETENV */

/*---------------------------------------------------------------------*/
void
E_SLEEP0001()
{
	char	tmpstr[80];
	int	msec;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_sleep0001( int msec(i) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " msec : " );
	scanf( "%s", tmpstr );
	if( ( msec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid msec ......\n" );
		return;
	}

	e_sleep0001( msec );

	printf( " Result successful\n" );

} /* E_SLEEP0001 */

/*---------------------------------------------------------------------*/
void
E_TIMEGAP()
{
	char		tmpstr[80];
	E_TIMESEC	start;
	E_TIMESEC	end;
	E_TIMESEC	gap;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_timegap( E_TIMESEC *start(i),                 |\n" );
	printf( "|              E_TIMESEC *end(i), E_TIMESEC *gap(o), )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " start.sec        : " );
	scanf( "%s", tmpstr );
	if( ( start.sec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid start.sec ......\n" );
		return;
	}
	printf( " start.micro      : " );
	scanf( "%s", tmpstr );
	if( ( start.micro = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid start.micro ......\n" );
		return;
	}
	printf( " end.sec          : " );
	scanf( "%s", tmpstr );
	if( ( end.sec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid end.sec ......\n" );
		return;
	}
	printf( " end.micro        : " );
	scanf( "%s", tmpstr );
	if( ( end.micro = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid end.micro ......\n" );
		return;
	}

	e_timegap( &start, &end, &gap );

	printf( " Result gap.sec   : [%d]\n", gap.sec );
	printf( " Result gap.micro : [%d]\n", gap.micro );

} /* E_TIMEGAP */

/*----------------------------------------------------------------------+
|	Display function for others					|
+----------------------------------------------------------------------*/
void
DisplayEtcF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( others )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. TraceLog   2. e_addsigact    3. e_delenv\n" );
	printf( " 4. e_getenv   5. e_setenv       6. e_sleep0001\n" );
	printf( " 7. e_timegap\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayEtcF */

/*----------------------------------------------------------------------+
|	Choose function for others					|
+----------------------------------------------------------------------*/
int
ChooseEtcF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 9 && ( choosenum < 1 || choosenum > 7 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseEtcF */

/*----------------------------------------------------------------------+
|	Main function for others					|
+----------------------------------------------------------------------*/
void
EtcF()
{
	for( ; ; )
	{
		DisplayEtcF();
		switch( ChooseEtcF() )
		{
		case	1	:	TRACELOG();		break;
		case	2	:	E_ADDSIGACT();		break;
		case	3	:	E_DELENV();		break;
		case	4	:	E_GETENV();		break;
		case	5	:	E_SETENV();		break;
		case	6	:	E_SLEEP0001();		break;
		case	7	:	E_TIMEGAP();		break;
		default		:				return;
		}
	}

} /* EtcF */

/****** End of etc.c ***************************************************/
