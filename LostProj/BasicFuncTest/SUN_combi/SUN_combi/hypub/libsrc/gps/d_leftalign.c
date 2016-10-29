/* d_leftalign() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : align data left						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source data
		  int	srclen		source data length
		  char	dest[]		destination data
		  char	rfilchar	right fill character
	return	: 0/-1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_leftalign( char src[], int srclen, char dest[], char rfilchar )
#else
d_leftalign( src, srclen, dest, rfilchar )
char	src[];
int	srclen;
char	dest[];
char	rfilchar;
#endif
{
	register	i, j;

	if( src == (char *)0 || dest == (char *)0 || srclen == 0 )
	     return -1;

	for( i=0; i<srclen && src[i]==' '; i++ ) ;

	for( j=0; i<srclen && src[i]!=' '; j++, i++ )
		dest[j] = src[i];

	for( ; j<srclen; j++ )
		dest[j] = rfilchar;

	return 0;
}
