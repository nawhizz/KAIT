/* d_d2nstr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert double (or 10자리이상 정수) into string data		*/
/*----------------------------------------------------------------------*/
/*
	input	: double  num		double value
		  char	  *dest 	destination data
		  int	  destlen	length of destnation data
		  int	  pntlen	length below zero
		  char	  lfilchar	left fill char
	return	: 0/-1
*/

#include	<string.h>
#include	<stdio.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_d2nstr( double num, char *dest, int destlen, int pntlen, char lfilchar )
#else
d_d2nstr( num, dest, destlen, pntlen, lfilchar )
double	num;
char	*dest;
int	destlen;
int	pntlen;
char	lfilchar;
#endif
{
	char		savdest[64];
	register	i;
	register	j;

	/* check data */
	if( destlen <= 0 || pntlen < 0  || dest == (char *)0 )
		return(-1);

	/* set length of int part */
	sprintf( savdest, "%*.*f", destlen, pntlen, num );

	for( i=destlen-1, j=strlen(savdest)-1; i>=0 && j>=0; i--, j-- )
		dest[i] = savdest[j];

	/* fill left character */
	if( lfilchar != ' ' )
	{
		for( i=0; i<destlen && dest[i]==' '; i++ )
			dest[i] = lfilchar;
	}

	return(0);
}
