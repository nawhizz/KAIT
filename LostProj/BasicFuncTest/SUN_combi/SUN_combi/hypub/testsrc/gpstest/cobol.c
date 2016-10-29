/************************************************************************
*	GPS library testing program ( COBOL only )			*
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
GOD_STRNCAT()
{
	char	tmpstr[80];
	char	src[256];
	char	add[256];
	char	dest[256];
	int	addsize;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       OD_STRNCAT( char *src(i), char *add(i),         |\n" );
	printf( "|                   int *addsize(i), char *dest(o) )    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " add         : " );
	gets( add );
	printf( " addsize     : " );
	scanf( "%s", tmpstr );
	if( ( addsize = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid addsize ......\n" );
		return;
	}

	OD_STRNCAT( src, add, &addsize, dest );

	printf( " Result dest : [%s]\n", dest );

} /* GOD_STRNCAT */

/*---------------------------------------------------------------------*/
void
GOD_GETWEEKDAY()
{
	char	src[41];
	char	mask[41];
	char	dest[1];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       OE_GETWEEKDAY( char *src(i), char *mask(i),     |\n" );
	printf( "|                                    char *dest(o) )    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " mask        : " );
	gets( mask );

	OE_GETWEEKDAY( src, mask, dest );

	printf( " Result dest : [%c]\n", dest[0] );

} /* GOD_GETWEEKDAY */

/*---------------------------------------------------------------------*/
void
GOF_TEMPNAM()
{
	char	temp_dir[256];
	char	temp_file[256];
	char	retcode;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       OF_TEMPNAM( char *tempdir(i),                   |\n" );
	printf( "|             char *tempfile(o), char *retcode(o) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " tempdir         : " );
	gets( temp_dir );
	gets( temp_dir );

	OF_TEMPNAM( temp_dir, temp_file, &retcode );
	if( retcode != ' ' )
	{
		printf( "OF_TEMPNAM error .......\n" );
		return;
	}

	printf( " Result tempfile : [%s]\n", temp_file );

} /* GOF_TEMPNAM */

/*---------------------------------------------------------------------*/
void
GOF_UNLINK()
{
	char	filepath[256];
	char	retcode;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       OF_UNLINK( char *filepath(i),                   |\n" );
	printf( "|                  char *retcode(o) )                   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath : " );
	scanf( "%s", filepath );

	OF_UNLINK( filepath, &retcode );
	if( retcode != ' ' )
	{
		printf( "OF_UNLINK error .......\n" );
		return;
	}

	printf( " Result successful\n" );

} /* GOF_UNLINK */

/*----------------------------------------------------------------------+
|	Display function for COBOL only					|
+----------------------------------------------------------------------*/
void
DisplayCobolF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( shared memory )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. OD_STRNCAT  2. OE_GETWEEKDAY  3. OF_TEMPNAM\n" );
	printf( " 4. OF_UNLINK\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayCobolF */

/*----------------------------------------------------------------------+
|	Choose function for COBOL only					|
+----------------------------------------------------------------------*/
int
ChooseCobolF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 9 && ( choosenum < 1 || choosenum > 3 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseCobolF */

/*----------------------------------------------------------------------+
|	Main function for COBOL only					|
+----------------------------------------------------------------------*/
void
CobolF()
{
	for( ; ; )
	{
		DisplayCobolF();
		switch( ChooseCobolF() )
		{
		case	1	:	GOD_STRNCAT();		break;
		case	2	:	GOD_GETWEEKDAY();	break;
		case	3	:	GOF_TEMPNAM();		break;
		case	4	:	GOF_UNLINK();		break;
		default		:				return;
		}
	}

} /* CobolF */

/****** End of cobol.c *************************************************/
