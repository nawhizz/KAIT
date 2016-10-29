/* d_imask() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : mask input data						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source data
		  int	srclen		source data length
		  char	dest[]		destination data
		  char	*mask		destination data pattern
		  char	lfilchar	left fill character
	return	: 0/-1
*/

#include	<string.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_imask( char src[], int srclen, char dest[], char *mask, char lfilchar )
#else
d_imask( src, srclen, dest, mask, lfilchar )
char	src[];
int	srclen;
char	dest[];
char	*mask;
char	lfilchar;
#endif
{
	char	tbuf[200];
	char	*savsrc;
	int	masklen, savsrclen;
	int	mppos = 0, sppos = 0, offpos = 0;
	register	i;
	register	j;
	int		notno = 0;

	if ( srclen < 0 ||
	     src == (char *)0 ||
	     dest == (char *)0 ||
	     mask == (char *)0 )
		return(-1);

	/* analyze mask form for  type */
	masklen = strlen( mask );
	for ( i = masklen - 1; i >= 0; i-- ) {
		switch ( mask[i] ) {
			case	'9'	:
			case	'0'	:
			case	'.'	:
			case	','	: break;
			default 	: notno = 1; break;
		}
		if ( notno ) break;
	}

	/* right alignment and copy src to tbuf*/
	for ( i = srclen - 1; i >= 0; i-- )
		if ( src[i] != ' ' )
			break;

	for ( j = srclen - 1; j >= 0; j-- )
		if ( i >= 0 )
			tbuf[j] = src[i--];
		else
			tbuf[j] =  ' ';

	tbuf[srclen] = '\0';

	/* remove left space */
	for ( i = 0; i < srclen; i++ )
		if ( tbuf[i] != ' ' )
			break;

	if ( i == srclen ) {
		if ( !notno ) {
			tbuf[0] = '0';
			tbuf[1] = '\0';
		}
		savsrc = tbuf;
		savsrclen = strlen( tbuf );
	}
	else {
		savsrc = &tbuf[i];
		savsrclen =strlen( savsrc );
	}

	/* in case numeric type */
	if ( !notno ) {
		/* analyze mask data for '.'  */
		for ( i = masklen - 1; i >= 0; i-- ) {
			if ( mask[i] == '.' ) {
				mppos = masklen - i;
				break;
			}
		}

		/* analyze source data for '.'	*/
		for ( i = savsrclen - 1; i >= 0; i-- ) {
			if ( savsrc[i] == '.' ) {
				sppos = savsrclen - i;
				break;
			}
		}

		/* remove '.' */
		if  ( sppos ) {
			for ( i = savsrclen - sppos; i < savsrclen; i++ )
				savsrc[i] = savsrc[i + 1];
			savsrclen = strlen( savsrc );
		}

		/* Align Numeric data using decimal point */
		/* using last type of mask string */
		if ( !sppos && mppos )		/* in case no decimal point */
			offpos = mppos - 1;
		else
			offpos = mppos - sppos;

		if ( offpos > 0 ) {
			while ( offpos-- )
				savsrc[savsrclen++] = '0';
			savsrc[savsrclen] = '\0';
		}
		else if ( offpos < 0 ) {
			while ( offpos++ )
				savsrc[--savsrclen] = '\0';
		}
	}

	if ( !notno ) {
		/* set mask */
		for ( i = masklen - 1, j = savsrclen - 1;
				i >= 0 && j >=0; i-- ) {
			switch ( mask[i] ) {
				case	'9'	:
				case	'0'	:
					dest[i] = savsrc[j--];
					break;
				default :
					if ( savsrc[j] == mask[i] )
						dest[i] = savsrc[j--];
					else if ( savsrc[j] == '-' )
						dest[i] = savsrc[j--];
					else	dest[i] = mask[i];
					break;
			}
		}

		for ( ; i >= 0; i-- )
				dest[i] = ' ';
	}
	else {
		for ( i = 0, j = 0; i < masklen && j < savsrclen; i++ ) {
			switch ( mask[i] ) {
				case	'Y'	:
				case	'y'	:
				case	'M'	:
				case	'm'	:
				case	'D'	:
				case	'd'	:
				case	'Z'	:
					dest[i] = savsrc[j++];
					break;
				default 	:
					if ( savsrc[j] == mask[i] )
						dest[i] = savsrc[j++];
					else
						dest[i] = mask[i];
					break;
			}
		}
	}

	/* revise numeric destination data */
	if ( !notno ) {
		for ( i = 0; i < masklen; i++ )
			if ( dest[i] != ' ' )
				break;
		switch ( dest[i] ) {
			case	'0'	:
				while ( dest[i] == '0' ) {
					if ( i >= masklen - 1 ||
					     dest[i + 1] == '.' )
						break;
					if ( dest[i + 1] == ',' )
						dest[i + 1] = '0';
					dest[i++] = ' ';
				}
				break;
			case	'-'	:
				while ( dest[i + 1] == '0' ) {
					if ( i >= masklen - 1 ||
					     dest[i + 2] == '.' ) {
						dest[i] = ' ';
						break;
					}
					dest[i + 1] = dest[i];
					dest[i++] = ' ';
					if ( dest[i + 1] == ',' ) {
						dest[i + 1] = '0';
					}
				}
				break;
			case	','	:
				dest[i] = ' ';
			default 	:
				break;
		}
	}
	return(0);
}
