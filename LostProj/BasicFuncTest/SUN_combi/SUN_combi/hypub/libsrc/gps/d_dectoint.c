/* d_dectoint() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii decimal string into integer			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	string[nstr]
		  int	nstr		length of string
	output	: int	*num
	return	: 0/-1(not decimal No.)
	example :
		input  [0015],[  15],[0000],[	0],[  32 ],[25	]
		output	  15,	 15,	 0,	0,    320,  2500
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_dectoint( char *string, int nstr, int *num)
#else
d_dectoint( string, nstr, num)
char	*string;
int	nstr;
int	*num;
#endif
{
	register	i;
	register	nn;
	register	nlen;

	*num = 0;

	for( nlen=nstr-1; nlen>=0 && string[nlen]==' '; nlen-- ) ;

	if( nlen < 0 )
		return 0;

	for( i=0; i<=nlen; i++)
	{
		if( string[i] == ' ' )
			nn = 0;
		else if( string[i] < '0' || string[i]>'9' )
			return -1;
		else
			nn = string[i] - 0x30;
		*num = 10 * *num + nn;
	}

	return 0;
}
