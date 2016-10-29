/* d_mkstradd() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 두개의 string을 붙임 						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*presrc		pre-string
		  char	*postsrc	post-string
	output	: char	*dest		destination string
		  int	*destlen;	lenth of destination string
	return	: 0/-1
*/

#include	<string.h>
#include	<stdlib.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_mkstradd( char *presrc, char *postsrc, char *dest, int *destlen )
#else
d_mkstradd( presrc, postsrc, dest, destlen )
char	*presrc;
char	*postsrc;
char	*dest;
int	*destlen;
#endif
{
	char	l_presrc[201], l_postsrc[201];

	if( presrc == 0 || postsrc == 0 || dest == 0 )
		return( -1 );

	d_mkstr( presrc, 200, l_presrc );
	d_mkstr( postsrc, 200, l_postsrc );
	strcpy( dest, l_presrc );
	strcat( dest, l_postsrc );
	( *destlen ) = (int)strlen( dest );
	return( 0 );
}
