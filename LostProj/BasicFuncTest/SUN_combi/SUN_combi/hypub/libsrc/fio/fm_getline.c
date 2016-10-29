/* fm_getline() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get one line data						*/
/*----------------------------------------------------------------------*/
/* internal function */
/*
	input	: char	*s		source buffer
		  int	bsize		buffer size to eof
		  char	*d		line buffer
*/

#include	"fm_fun.h"

int
#if	defined( __CB_STDC__ )
fm_getline( char *s, int bsize, char *d )
#else
fm_getline( s, bsize, d )
char	*s;
int	bsize;
char	*d;
#endif
{
	register	i;

	/* bsize > 0 */
	for( i=0; i<bsize; i++ )
	{
		d[i] = s[i];
		if ( s[i] == '\n' )
			return	i+1;
	}
	if( i == 0 ) return( 0 );
	if( d[i-1] == 0x1a )
		i--;
	return	i;
}
