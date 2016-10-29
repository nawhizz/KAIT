/* d_isspacenstr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : test if len's string is all space character                   */
/*----------------------------------------------------------------------*/
/*
	input	: char	string[]
		  int	len		length of string
	return	: 1/0
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_isspacenstr( char *string, int len )
#else
d_isspacenstr( string, len )
char	*string;
int	len ;
#endif
{
	register	 i;

	for( i=0; i<len; i++ )
		if( string[i] != ' ' )
			return 0;
	return 1;
}
