/* d_nstradd2() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 서로다른 길이의 decimal string을 더함 			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*s1		first string
		  int	s1len		length of first string
		  char	*s2		second string
		  int	s2len		lenth of second string
		  int	dlen;		length of destination strin
	output	: char	*dest[] 	destination string
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_nstradd2( char *s1, int s1len, char *s2, int s2len, char *d, int dlen )
#else
d_nstradd2( s1, s1len, s2, s2len, d, dlen )
char	*s1;
int	s1len;
char	*s2;
int	s2len;
char	*d;
int	dlen;
#endif
{
	double	d_s1, d_s2, d_d;

	if( d_nstr2d( s1, s1len, &d_s1 ) < 0 )
		return -1;
	if( d_nstr2d( s2, s2len, &d_s2 ) < 0 )
		return -1;

	d_d = d_s1 + d_s2;
	if( d_d2nstr( d_d, d, dlen, 0, ' ' ) < 0 )
		return -1;

	return 0;
}
