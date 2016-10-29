/* d_isnumstr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : test for numeric ascii string (including space)		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	  string[]
	return	: 1/0(FALSE)
*/
#include	<ctype.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_isnumstr( char *string )
#else
d_isnumstr( string )
char	*string;
#endif
{
	register	i;

	for( i=0; string[i]; i++ )
		if( !isdigit( string[i] ) && string[i] != ' ' )
			return 0;
	return 1;
}
