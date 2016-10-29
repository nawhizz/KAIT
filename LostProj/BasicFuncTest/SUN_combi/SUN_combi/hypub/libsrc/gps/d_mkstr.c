/* d_mkstr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : make buffer to NULL terminated string right spaces ignored	*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*src		source string
		  int	srcsize 	length of source
	output	: char	*dest		destination string
*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
d_mkstr( char *src, int srcsize, char *dest )
#else
d_mkstr( src, srcsize, dest )
char	*src;
int	srcsize;
char	*dest;
#endif
{
	register	i;

	for( i=0; i<srcsize && (unsigned char) src[i]>' '; i++ )
		dest[i] = src[i];
	dest[i] = '\0';
}
