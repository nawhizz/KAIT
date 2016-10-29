/* d_ndec2int() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii decimal string into integer			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	string[nstr]	ascii decimal string (Not null term)
		  int	nstr		length of string
	return	: >0/-1
*/

#include	"gps.h"

int	 CBD1
#if	defined( __CB_STDC__ )
d_ndec2int( char *string, int nstr )
#else
d_ndec2int( string, nstr )
char	*string ;
int	nstr ;
#endif
{
	register	i;
	register	nn;
	unsigned int	num = 0;

	for( nstr--; nstr>=0 && string[nstr]==' '; nstr--) ;

	if( nstr < 0 )
		return -1;
	for( i=0; i<=nstr; i++ )
	{
		if( string[i] == ' ' )
			nn = 0;
		else if( string[i] < '0' || string[i] > '9' )
			return -1;
		else
			nn = string[i] - '0';
		num = 10 * num + nn;
	}
	return ( num );
}
