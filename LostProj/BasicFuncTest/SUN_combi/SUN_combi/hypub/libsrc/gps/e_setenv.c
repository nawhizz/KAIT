/* e_setenv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : set environment						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*envname
		: char	*envval
	return	: 0/-1
*/

#include	<string.h>
#include	<stdlib.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_setenv( char *envname, char *envval )
#else
e_setenv( envname, envval )
char	*envname;
char	*envval;
#endif
{
	int	size;
	char	*string;

	if( envname == (char *)0 || envval == (char *)0 )
		return( -1 );

	size = strlen(envname) + strlen(envval) + 2;	/* = + null */

	if( ( string = (char *)malloc( size ) ) == (char *)0 )
		return( -1 );

	strcpy( string, envname );
	strcat( string, "=" );
	strcat( string, envval );

	if( putenv( string ) != 0 )
	{
		free( string );
	 	return( -1 );
	}
	else	return( 0 );
}
