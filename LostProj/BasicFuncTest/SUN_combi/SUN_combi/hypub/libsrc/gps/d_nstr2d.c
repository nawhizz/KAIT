/* d_nstr2d() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert string date into double ( or	10자리이상 정수 )	*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source date
		  int	srclen		length of source
	output	: double *num		double value
	return	: 0/-1
*/

#include	<string.h>
#include	<stdlib.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_nstr2d( char src[], int srclen, double *num )
#else
d_nstr2d( src, srclen, num )
char	src[];
int	srclen;
double	*num;
#endif
{
	char	work[64];

	if ( src == (char *)0 || srclen <= 0 )
		return -1;

	strncpy( work, src, srclen );
	work[srclen] = '\0';

	d_rightalign( work, srclen, work, ' ' );
	*num = atof( work );

	return( 0 );
}
