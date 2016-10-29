/* d_strendnull() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change ' 's  to  0 from end of string 			*/
/*----------------------------------------------------------------------*/
/*
	input	: int	length
	inout	: char	string[length]
	return	: length of string
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_strendnull( char *string, int length )
#else
d_strendnull( string, length )
char	*string;
int	length;
#endif
{
	register	i;

	for( i=length-1; i>=0; i-- )
	{
		if( string[i] == ' ' )
			string[i] = 0;
		else if( string[i] )
			break;
	}
	return(i+1);
}
