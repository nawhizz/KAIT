/* bp_prtsegf() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print segment form without data				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	pfd		file descriptor
		  int	ffd		form file descriptor
		  char	*segid		segment id in form file
	return	: 0/-1
*/

#include	<stdlib.h>

#include	"fio.h"

int CBD1
#if	defined( __CB_STDC__ )
bp_prtsegf( int pfd, int ffd, char *segid )
#else
bp_prtsegf( pfd, ffd, segid )
int	pfd;
int	ffd;
char	*segid;
#endif
{
	char	*buf;
	int	bufsize;
	int	prtsize;

	if( ffd < 0 || pfd < 0 )
		return( -1 );
	if( ( bufsize = FM_GETSIZE( ffd ) ) <= 0 )
		return( -1 );
	if( ( buf = (char *)malloc( bufsize ) ) == (char *)0 )
		return( -1 );

	prtsize = FM_FILLSEG( ffd, segid, 0, 0,  buf, bufsize, '#' );

	if( prtsize <= 0 ) {
		free( buf );
		return( -1 );
	}
	if( FS_APPEND( pfd, buf, prtsize ) < 0 ) {
		free( buf );
		return( -1 );
	}
	free( buf );
	return( 0 );
}
