/* bp_prtff() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print formfeed to file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	pfd		file descriptor
		  char	*data		data for print
		  int	len		length of data
	return	: 0/-1
*/

#include	"fio.h"

int CBD1
#if	defined( __CB_STDC__ )
bp_prtff( int pfd )
#else
bp_prtff( pfd )
int	pfd;
#endif
{
	char	ff[2];

	if( pfd < 0 ) return(-1);
	ff[0] = 12;
	ff[1] = '\0';
	return( bp_prtdata( pfd, ff, 1 ) );
}
