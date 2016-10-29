/* k_inpnnumeric() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input numeric string from std-in at current cursor position	*/
/*----------------------------------------------------------------------*/
/*
	input	: int	len		length to input
	output	: char	*string 	NULL term. string
*/

#include	<ctype.h>

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
k_inpnnumeric( char *string, int len )
#else
k_inpnnumeric( string, len )
char	*string;
int	len;
#endif
{
	register	i;
	char		buff[300];
	int		inpsts;

	/* input data */
	while( 1 )
	{
		inpsts = 0;
		k_inpnstring( buff, len );
		for( i=0; buff[i]; i++ )
		{
			if( ! isdigit( buff[i] ) )
			{
				inpsts = -1;
				break;
			}
		}

		/* if numeric */
		if(inpsts == 0)
			break;
	}

	/* convert data */
	for( i=0; i<len; i++ )
	{
		if(buff[i] == 0)
		{
			string[i] = ' ';
			break;
		}
		else
			string[i] = buff[i];
	}

	for( ; i<len-1; i++ )
		string[i] = ' ';
	string[len-1] = 0;
}
