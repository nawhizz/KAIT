/************************************************************************
*	GPS library testing program ( keyboard I/O )			*
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
K_ACCEPTSTR()
{
	char	tmpstr[80];
	char	string[512];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       k_acceptstr( char *str(o), int len(i) )         |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	printf( "input       : " );
	k_acceptstr( string, len );

	printf( " Result str : [%.*s]\n", len, string );

} /* K_ACCEPTSTR */

/*---------------------------------------------------------------------*/
void
K_GETCHAR()
{
	short	keyval;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       k_getchar( short *keyval(o) )                   |\n" );
	printf( "+-------------------------------------------------------+\n" );

	printf( "input          : " );
	k_getchar( &keyval );

	printf( " Result keyval : [%d]\n", keyval );

} /* K_GETCHAR */

/*---------------------------------------------------------------------*/
void
K_INPNNUMERIC()
{
	char	tmpstr[80];
	char	string[512];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       k_inpnnumeric( char *str(o), int len(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	printf( "input       : " );
	k_inpnnumeric( string, len );

	printf( " Result str : [%.*s]\n", len, string );

} /* K_INPNNUMERIC */

/*---------------------------------------------------------------------*/
void
K_INPNSTRING()
{
	char	tmpstr[80];
	char	string[512];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       k_inpnstring( char *str(o), int len(i) )        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	printf( "input       : " );
	k_inpnstring( string, len );

	printf( " Result str : [%.*s]\n", len, string );

} /* K_INPNSTRING */

/*----------------------------------------------------------------------+
|	Display function for keyboard I/O				|
+----------------------------------------------------------------------*/
void
DisplayKIOF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( keyboard I/O )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. k_acceptstr    2. k_getchar\n" );
	printf( " 3. k_inpnnumeric  4. k_inpnstring\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayKIOF */

/*----------------------------------------------------------------------+
|	Choose function for keyboard I/O				|
+----------------------------------------------------------------------*/
int
ChooseKIOF()
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

} /* ChooseKIOF */

/*----------------------------------------------------------------------+
|	Main function for keyboard I/O					|
+----------------------------------------------------------------------*/
void
KIOF()
{
	for( ; ; )
	{
		DisplayKIOF();
		switch( ChooseKIOF() )
		{
		case	1	:	K_ACCEPTSTR();		break;
		case	2	:	K_GETCHAR();		break;
		case	3	:	K_INPNNUMERIC();	break;
		case	4	:	K_INPNSTRING();		break;
		default		:				return;
		}
	}

} /* KIOF */

/****** End of keyio.c *************************************************/
