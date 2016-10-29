/* d_hanadjt() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : adjust HANGUL data						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source data
		  int	len		length of stc. data
		  char	dest[]		destination data
	return	: 0/-1
*/

#include	<string.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_hanadjt( char src[], int len, char dest[] )
#else
d_hanadjt( src, len, dest )
char	src[];
int	len;
char	dest[];
#endif
{
	register	i;
	int		hanad = 0;

	if ( src == (char *)0 || dest == (char *)0 || len <= 0 )
		return(-1);

	strncpy( dest, src, len );
	for ( i=0; i<len; i++ )
	{
		if( src[i] & 0x80 )
		{
			if( i + 1 < len )
				i++;
			else
				hanad = 1;
		}
	}

	if( hanad )
		dest[len - 1] = ' ';

	return(0);
}
