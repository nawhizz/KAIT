/* e_fullyear() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert 2 length year to 4 length year			*/
/*----------------------------------------------------------------------*/
/*
	return	: >0 (result year)
		  -1
*/

#include	<string.h>
#include	<stdlib.h>
#include	"e_date.h"
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_fullyear( char src[], char dest[] )
#else
e_fullyear( src, dest )
char	src[];
char	dest[];
#endif
{
	char	year[3];
	char	*sp = "    ";
	int	iyear;

	if ( src == (char *)0 || dest == (char *)0 )
		return -1;

	if ( !strncmp( src, sp, 2 ) )
		return -1;

	strncpy( year, src, 2 );
	year[2] = '\0';

	iyear = atoi( year );

	/* Convert year */
	if ( iyear >= 0 && iyear <= 50 ) {
		iyear += 2000;
		strncpy( dest, "20", 2 );
	}
	else if ( iyear > 50 && iyear < 100 ) {
		iyear += 1900;
		strncpy( dest, "19", 2 );
	}
	strncpy( &dest[2], src, 2 );

	return( iyear );
}
