/* k_inpnstring() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input string from std-in at current cursor position		*/
/*----------------------------------------------------------------------*/
/*
	input	: int	len		length to input
	output	: char	*string 	NULL term. string
*/

#include	<stdio.h>

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
k_inpnstring( char *str, int len )
#else
k_inpnstring( str, len )
char	*str;
int	len;
#endif
{
	register	i;
	int		keyval;

	len--;
	for( ; ; )
		if( ( str[0] = getchar() ) != 0x0a )
			break;
	for( i=1; ( keyval = getchar() ) != 0x0a; i++ )
		if( i < len )
			str[i] = keyval;

	str[len<i?len:i] = 0;
}
