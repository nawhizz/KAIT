/* d_filldata() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fill data into print buffer using form string 		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		data
		  int	srclen		length of src. data
		  char	dest[]		destination buffer
		  char	*filldata	data form
		  char	maskdata	src.data pattern
	return	: 0/-1
*/

#include	<string.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_filldata( char src[], int srclen, char dest[], char *filldata, char maskchar )
#else
d_filldata( src, srclen, dest, filldata, maskchar )
char	src[];
int	srclen;
char	dest[];
char	*filldata;
char	maskchar;
#endif
{
	register	i;
	register	j;
	int		destlen;

	if ( src == (char *)0 ||
	     dest == (char *)0 ||
	     filldata == (char *)0 ||
	     srclen <= 0 )
		return -1;

	destlen = strlen( filldata );
	strncpy( dest, filldata , destlen );

	for( i=0, j=0; i<destlen && j<srclen; i++ )
	{
		if ( filldata[i] == maskchar )
			dest[i] = src[j++];
	}

	return(0);
}
