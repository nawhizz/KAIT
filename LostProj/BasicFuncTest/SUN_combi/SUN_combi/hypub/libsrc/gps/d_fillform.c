/* d_fillform() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fill data into print buffer using form string 		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		data
		  int	srclen		length of src. data
		  char	dest[]		destination buffer
		  char	*filldata	data form
		  int	fillen		length of filldata
		  char	maskdata	src.data pattern
	return	: 0/-1
*/

#include	<string.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_fillform( char src[], int srclen, char dest[], char *filldata, int fillen, char maskchar )
#else
d_fillform( src, srclen, dest, filldata, fillen, maskchar )
char	src[];
int	srclen;
char	dest[];
char	*filldata;
int	fillen;
char	maskchar;
#endif
{
	register	i;
	register	j;

	if ( src == (char *)0 ||
	     dest == (char *)0 ||
	     filldata == (char *)0 ||
	     srclen <= 0 ||
	     fillen <= 0 )
		return -1;

	strncpy( dest, filldata , fillen );

	for( i=0, j=0; i<fillen && j<srclen; i++ )
	{
		if ( filldata[i] == maskchar )
			dest[i] = src[j++];
	}

	return 0;
}
