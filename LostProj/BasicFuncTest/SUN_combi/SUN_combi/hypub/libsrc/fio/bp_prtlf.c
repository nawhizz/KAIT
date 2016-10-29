/* bp_prtlf() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print linefeed to file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	pfd		file descriptor
	return	: 0/-1
*/

#include	"fio.h"

int CBD1
#if	defined( __CB_STDC__ )
bp_prtlf( int pfd )
#else
bp_prtlf( pfd )
int	pfd;
#endif
{
	if( pfd < 0 )
		return(-1);
	bp_prtdata( pfd, "\r\n", 2 );
	return(0);
}
