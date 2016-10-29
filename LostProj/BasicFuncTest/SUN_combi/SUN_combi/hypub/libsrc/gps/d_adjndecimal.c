/* d_adjndecimal() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : adjust numeric string with format (with len, left fill char)	*/
/*	: Not Null Terminated						*/
/*----------------------------------------------------------------------*/
/*
	(assume string consist of numeric or ' ' only)
	i/o	: char	  str[len]
	input	: char	  leftchar	left fill char
		  int	  len
	return	: 0/-1
	example :
	" 132 ", "132  ", "  132", "00132", "0132 "
	==> "    132"/"0000132"
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_adjndecimal( char *str, char leftchar, int len )
#else
d_adjndecimal( str, leftchar, len )
char	*str;
char	leftchar;
int	len;
#endif
{
	register	i;
	register	j;
	int		charappeared;

	for( i=0; i<len; i++ )
	{
		if( str[i] != ' ' && ( str[i] < '0' || str[i] > '9' ) )
			return( -1 );
	}

	for( i=len-1; i>=0 && str[i]==' '; i-- ) ;

	if( i < 0 )
	{						/* if all space */
		for( j=0; j<len-1; j++ )
			str[j] = leftchar;
		str[ len - 1 ] = '0';
		return( 0 );
	}

	for( j=len-1; j>=len-1-i; j-- )
		str[j] = str[j-(len-1-i)];

	for( j=0; j<len-1-i; j++ )
		str[j] = ' ';

	charappeared = 0;
	for( i=0; i<len; i++ )
	{
		if( str[i] == ' ' )
		{
			if( charappeared )	str[i] = '0';
			else			str[i] = leftchar;
		}
		else if( str[i] == '0' )
		{
			if( charappeared )	str[i] = '0';
			else if( i == len-1 )	str[i] = '0';
			else			str[i] = leftchar;
		}
		else
			charappeared = 1;
	}

	return(0);
}
