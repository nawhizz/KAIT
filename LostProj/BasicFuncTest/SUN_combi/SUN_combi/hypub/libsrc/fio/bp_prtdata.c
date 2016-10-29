/* bp_prtdata() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print data to file						*/
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
bp_prtdata( int	pfd, char *data, int len )
#else
bp_prtdata( pfd, data, len )
int	pfd;
char	*data;
int	len;
#endif
{
	if( FS_APPEND( pfd, data, len ) < 0 )
		return( -1 );
	else	return( 0 );
}
