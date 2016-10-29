/* e_getenv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get environment set						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*envname
	output	: char	*envval
	return	: 0/-1
*/

#include	<string.h>
#include	<stdlib.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_getenv( char *envname, char *envval )
#else
e_getenv( envname, envval )
char	*envname;
char	*envval;
#endif
{
	char	*retvalue;

	if( envname == (char *)0 || envval == (char *)0 )
		return( -1 );

	if( ( retvalue = getenv( envname ) ) == (char *)0 )
		return( -1 );

	if( retvalue[0] == (char)0 )
		return( -1 );

	strcpy( envval, retvalue );

	return( 0 );
}
