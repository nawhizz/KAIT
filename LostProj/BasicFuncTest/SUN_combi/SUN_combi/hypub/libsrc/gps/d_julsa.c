/* d_julsa() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 소숫점 이하를 버림.						*/
/*----------------------------------------------------------------------*/
/*
	input	: double ggm
	return	: != 0
*/

#include	<stdio.h>
#include	<math.h>
#include	"gps.h"

double CBD1
#if	defined( __CB_STDC__ )
d_julsa( double ggm )
#else
d_julsa( ggm )
double	ggm;
#endif
{
	if( ggm >= 0 )	return( floor( ggm ) );
	else		return( ceil( ggm ) );
}
