/* d_inttodec() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 정수값을 ascii decimal string으로 변환 ( null terminate )	*/
/*----------------------------------------------------------------------*/
/*
	input	: int	num		integer
		  int	nstr		length or string
		  char	leftchar	left fill char ('0',' ' etc)
	output	: char	string[nstr+1]	null terminated
	example :
		     15,    15,     0,	   0
		  [0015],[  15],[0000],[   0])
*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
d_inttodec( int num, int nstr, char leftchar, char *string )
#else
d_inttodec( num, nstr, leftchar, string )
int	num;
int	nstr;
char	leftchar;
char	*string;
#endif
{
	register	i;

	string[nstr] = 0;

	for( i=nstr-1; i>=0 && num; i--, num/=10 )
		string[i] = num % 10 + 0x30;

	for( ; i>=0; i-- )
		string[i] = leftchar;

	if( string[nstr-1] == ' ' )
		string[nstr-1] = '0';
}
