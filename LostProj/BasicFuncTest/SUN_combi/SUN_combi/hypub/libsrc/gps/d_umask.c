/* d_umask() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : unmask data to mask						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*src		source data
		  char	*dest		destination data
		  int	destlen 	source data length
		  char	*mask		mask form
		  char	lfilchar	left fill character
	return	: 0/-1
*/

#include	<string.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_umask( char *src, char *dest, int destlen, char *mask, char lfilchar )
#else
d_umask( src, dest, destlen, mask, lfilchar )
char	*src;
char	*dest;
int	destlen;
char	*mask;
char	lfilchar;
#endif
{
	register	i, j;
	char	tbuf[200];
	int	masklen;
	int	notno = 0;

	if ( destlen < 0 ||
	     src == (char *)0  || dest == (char *)0 || mask == (char *)0 )
		return -1;

	masklen = strlen( mask );
	strncpy( tbuf, src, masklen );
	for( i=masklen-1; i>=0; i-- )
	{
		switch ( mask[i] )
		{
			case	'9'	:
			case	'0'	:
			case	'.'	:
			case	','	: break;
			default 	: notno = 1; break;
		}
		if ( notno ) break;
	}

	for( i=masklen-1, j=destlen-1; i>=0 && j>=0; i-- )
	{
		switch ( mask[i] )
		{
			case	'Y'	:
			case	'y'	:
			case	'M'	:
			case	'm'	:
			case	'D'	:
			case	'd'	:
			case	'9'	:
			case	'0'	:
			case	'Z'	:
				if ( tbuf[i] == ' ' )
					dest[j--] = lfilchar;
				else
					dest[j--] = tbuf[i];
				break;
			default 	:
				if ( !notno && tbuf[i] == '-' )
					dest[j--] = tbuf[i];
				else if ( tbuf[i] == ' ' )
					dest[j--] = lfilchar;
				break;
		}
	}

	for( ; j >= 0; j-- )
		dest[j] = lfilchar;
	return(0);
}
