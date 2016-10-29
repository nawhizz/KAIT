/* e_delenv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : set evironment variable to null				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*envname
	return	: 0/-1
*/
#include	<stdlib.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_delenv( char *envname )
#else
e_delenv( envname )
char	*envname;
#endif
{
	char	*retvalue;

	if( ( retvalue = getenv( envname ) ) != (char *)0 )
	{
		retvalue[0] = 0;
		return(0);
	}
	else	return(-1);
}
