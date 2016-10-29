/* k_acceptstr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input n-string from std-in at current cursor position 	*/
/*----------------------------------------------------------------------*/
/*
	input	: int	len		length to input
	output	: char	*string 	not NULL term. string
					( filled with space if not input )
*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
k_acceptstr( char *string, int len )
#else
k_acceptstr( string, len )
char	*string;
int	len;
#endif
{
	register	i;
	char		buff[300];

	for( ; ; )
	{
		buff[0] = 0;
		k_inpnstring(buff,len+1);
		if(buff[0] != 0)
			break;
	}

	for( i=0; i<len; i++ )
	{
		if(buff[i] == 0)
		{
			string[i] = ' ';
			break;
		}
		string[i] = buff[i];
	}
	for( ; i<len; i++ )
		string[i] = ' ';
}
