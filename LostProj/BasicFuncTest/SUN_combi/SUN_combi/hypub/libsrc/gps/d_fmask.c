/* d_fmask() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : mask data to red file 					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source data
		  int	srclen		source data length
		  char	dest[]		destination data
		  char	lfilchar	left fill character
	return	: 0/-1
*/

#include	<string.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_fmask (char src[], int srclen, char dest[], char *mask, char lfilchar )
#else
d_fmask (src, srclen, dest, mask, lfilchar )
char	src[];
int	srclen;
char	dest[];
char	*mask;
char	lfilchar;
#endif
{
	char		tbuf[256];
	register	i;
	register	j;
	int		point;
	int		masklen;
	int		notno = 0;
	int		pnt = 0;

	if ( srclen < 0  ||
	     src == (char *)0  ||
	     dest == (char *)0 ||
	     mask == (char *)0 )
		return(-1);

	strncpy( tbuf, src, srclen );

	/* analyze mask form for  type */
	masklen = strlen ( mask );
	for( i=masklen-1; i>=0; i-- )
	{
		switch ( mask[i] )
		{
			case '.'     :	pnt = 1; break;
			case '9'     :
			case '0'     :
			case ','     :	break;
			default      :	notno = 1; break;
		}
		if( notno ) break;
	}

	if ( !notno )
	{
		for( point=0, i=masklen-1, j=srclen-1; i>=0 && j>=0; i-- )
		{
			switch ( mask[i] )
			{
			case	'.'	:
				if (tbuf[j] == '.')
					dest[i] = tbuf[j--];
				else
					dest[i] = mask[i];
				point = 1;
				break;
			case	'9'	:
			case	'0'	:
				if ( tbuf[j] != ' ' )
				{
					dest[i] = tbuf[j--];
					if (point)	point++;
				}
				else if (pnt && !point)
					dest[i] = '0';
				else if (pnt && point == 1) {
					dest[i] = '0';
					point++;
				}
				else
					dest[i] = lfilchar;
				break;
			default 	:
				if ( tbuf[j] == '-' )
					dest[i] = tbuf[j--];
				else if ( tbuf[j] == ' ' )
					dest[i] = lfilchar;
				else
					dest[i] = mask[i];
				break;
			}
		}
		for ( ; i >= 0 ; i-- )
			dest[i] = lfilchar;
	}
	else {
		for ( i = 0, j = 0; i < masklen && j < srclen; i++ ) {
			switch ( mask[i] ) {
				case	'Y'	:
				case	'y'	:
				case	'M'	:
				case	'm'	:
				case	'D'	:
				case	'd'	:
				case	'Z'	:
					dest[i] = tbuf[j++];
					break;
				default 	:
					if ( tbuf[j] == mask[i] )
						dest[i] = tbuf[j++];
					else
						dest[i] = mask[i];
					break;
			}
		}
	}

	if ( d_isspacenstr( dest, masklen ) ) {
		if ( !notno ) {
			if ( pnt ) {
				for ( i = masklen - 1; i >= 0; i-- ) {
					if ( mask[i] =='.' )
						break;
					dest[i] = '0';
				}
				if ( i > 0 ) {
					dest[i--] = '.';
					dest[i] = '0';
				}
			}
			else
				dest[masklen - 1] = '0';
		}
	}
	return(0);
}
