/* d_int2ndec() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 정수값을 ascii decimal string으로 변환 ( not null terminate ) */
/*----------------------------------------------------------------------*/
/*
	input	: u-int num		integer
		  int	nstr		length or string
		  char	leftchar	left fill char ('0',' ' etc)
	output	: char	string[nstr]	not null terminated
*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
d_int2ndec( unsigned int num, int nstr, char leftchar, char *string )
#else
d_int2ndec( num, nstr, leftchar, string )
unsigned int	num ;
int	nstr ;
char	leftchar ;
char	*string ;
#endif
{
	register	i;

	for( i=nstr-1; i>=0 && num; i--, num/=10 )
		string[i] = num % 10 + '0';

	for( ; i>=0; i-- )
		string[i] = leftchar;

	if( string[nstr-1] == ' ')
		string[nstr-1] = '0';
}
