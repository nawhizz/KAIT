/* d_hextoint() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii hexadecimal string into integer 		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	string[nstr]
		  int	nstr		string length ( not null term. )
	output	: int	*num
	return	: 0
	example :
		  [  9f],[009a],[009A],[0000],[   0]
		    159,   154,   154,	   0,	  0
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_hextoint( char *string, int nstr, int *num )
#else
d_hextoint( string, nstr, num )
char	*string;
int	nstr;
int	*num;
#endif
{
	register	i;
	int		nn;

	*num = 0;
	for( i=0; i<nstr; i++ )
	{
		if( string[i] == ' ' && *num )		break;
		else if( (string[i]==' ') & (! *num) )	nn = 0;
		else if( string[i] > 0x60 )		nn = string[i] - 0x57;
		else if( string[i] > 0x40 )		nn = string[i] - 0x37;
		else					nn = string[i] - 0x30;
		*num = 16 * *num + nn;
	}

	return 0;
}
