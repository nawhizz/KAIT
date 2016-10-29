/* d_inttohex() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert integer to ascii hexadecimal string (null terminate)	*/
/*----------------------------------------------------------------------*/
/*
	input	: int	val
		  int	nstr		string length
		  char	leftchar	left fill char
	output	: char	string[nstr+1]	null terminated
	example :
		    245,     0,      245,      0
		  [00F5],[0000],   [  F5],[   0]
*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
d_inttohex( int val, int nstr, char leftchar, char *string )
#else
d_inttohex( val, nstr, leftchar, string )
int	val;
int	nstr;
char	leftchar;
char	*string;
#endif
{
	register	i;

	string[nstr] = 0;

	for( i=nstr-1; i>=0 && val; i--, val/=16 )
	{
		string[i] = val % 16 + 0x30;
		if( string[i] > 0x39 )
			string[i] += 7;
	}

	for( ; i>=0; i-- )
		string[i] = leftchar;

	if( string[nstr-1] == ' ')
		string[nstr-1] = '0';
}
