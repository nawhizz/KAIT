/* d_rightalign() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : align data right						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*src		source data
		  int	srclen		length of source data
		  char	lfilchar	right fill character
	output	: char	*dest		destination data
	return	: 0/-1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_rightalign( char *src, int srclen, char *dest, char lfilchar )
#else
d_rightalign( src, srclen, dest, lfilchar )
char	*src;
int	srclen;
char	*dest;
char	lfilchar;
#endif
{
	register	i;
	register	j;

	if( src == (char *)0 || dest == (char *)0 || srclen == 0 )
		return(-1);

	for( i=srclen-1; i>=0 && src[i]==' '; i-- ) ;

	for( j=srclen-1; i>=0 && src[i]!=' '; j--, i-- )
			dest[j] = src[i];

	for( ; j>=0; j-- )
		dest[j] = lfilchar;

	return(0);
}
