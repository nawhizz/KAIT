/* d_nstradd() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 두개의 decimal string을 더함 (3개의 string의 길이는 같아야함) */
/*----------------------------------------------------------------------*/
/*
	input	: char	*src1		first string
		  char	*src2		second string
		  int	len;		lenth of each string
	output	: char	*dest
	return	: 0/-1
*/

#include	<string.h>
#include	<stdlib.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_nstradd( char *src11, char *src22, char *dest, int len )
#else
d_nstradd( src11, src22, dest, len )
char	*src11;
char	*src22;
char	*dest;
int	len;
#endif
{
	register	i;
	int		i1, i2, idest;
	double		d1, d2, ddest;
	char		savsrc1[64], savsrc2[64];
	int		src1sign=1, src2sign=1, ressign=1;
	char		src1[64], src2[64];

	if ( len <= 0 ||
	     src1 == (char *)0 ||
	     src2 == (char *)0 ||
	     dest == (char *)0 )
		return -1;

	for( i=0; i<len; i++ )
	{
		src1[i] = src11[i];
		src2[i] = src22[i];
		if( src11[i] == '-' )
		{
			src1[i] = ' ';
			src1sign = -1;
		}
		if( src22[i] == '-' )
		{
			src2[i] = ' ';
			src2sign = -1;
		}
	}

	strncpy( savsrc1, src1, len );
	strncpy( savsrc2, src2, len );
	savsrc1[len] = '\0';
	savsrc2[len] = '\0';

	if ( len < 10 )
	{					/* for int */
		i1 = atoi( savsrc1 ) * src1sign;
		i2 = atoi( savsrc2 ) * src2sign;
		idest = i1 + i2;
		if( idest < 0 )
		{
			ressign = -1;
			idest *= -1;
		}
		d_int2ndec( idest, len, ' ', dest );
	}
	else
	{
		d_nstr2d( savsrc1, len, &d1 );
		d_nstr2d( savsrc2, len, &d2 );
		d1 *= src1sign;
		d2 *= src2sign;
		ddest = d1 + d2;
		if( ddest < 0 )
		{
			ressign = -1;
			ddest *= -1;
		}
		d_d2nstr( ddest, dest, len, 0, ' ' );
	}

	if( ressign < 0 )
	{
		for( i=len-1; i>=0; i-- )
		{
			if( dest[i] == ' ' )
			{
				dest[i] = '-';
				break;
			}
		}
	}

	return(0);
}
