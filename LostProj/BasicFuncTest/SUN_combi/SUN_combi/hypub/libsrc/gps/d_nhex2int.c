/* d_nhex2int() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert ascii hexadecimal string into integer 		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	string[nstr]
		  int	nstr		string length ( not null term. )
	return	: int value
	example :
		  [  9f],[009a],[009A],[0000],[   0]
		    159,   154,   154,	   0,	  0
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_nhex2int( char *string, int nstr )
#else
d_nhex2int( string, nstr )
char	*string;
int	nstr;
#endif
{
	int	 i,nn;
	int	num;

	num = 0;
	for(i=0;i<nstr;i++)
	{	if(string[i] == ' ') nn=0;
		else if(string[i] > 0x60) nn =string[i]-0x57;
		else if(string[i] > 0x40) nn =string[i]-0x37;
		else nn=string[i] - 0x30;
		num = 16 * num + nn;
	}
	return( num );
}
