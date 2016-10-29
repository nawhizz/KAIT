/* bp_prtseg() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print segment data with segment form				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	pfd		file descriptor
		  int	ffd		form file descriptor
		  char	*segid		segment id in form file
					if segid = (char *)0 or [0] then
					with full form
		  char	*data		data for print
		  int	len		length of data
		  char	maskchar	masking character
	return	: 0/-1
*/

#include	<stdlib.h>

#include	"fio.h"

int CBD1
#if	defined( __CB_STDC__ )
bp_prtseg( int pfd, int	ffd, char *segid, char *data, int len, char maskchar )
#else
bp_prtseg( pfd, ffd, segid, data, len, maskchar )
int	pfd;
int	ffd;
char	*segid;
char	*data;
int	len;
char	maskchar;
#endif
{
	char	*buf;
	int	withsegid=1;	/* print with segment */
	int	bufsize;
	int	prtsize;

	if( ffd < 0 || pfd < 0 )
		return( -1 );
	if( segid == (char *)0 || segid[0] == '\0' )
		withsegid = 0;
	if( ( bufsize = FM_GETSIZE( ffd ) ) <= 0 )
		return( -1 );

	if( ( buf = (char *)malloc( bufsize ) ) == (char *)0 )
		return( -1 );

	if( withsegid )
		prtsize = FM_FILLSEG( ffd, segid, data, len, buf, bufsize,
			maskchar );
	else
		prtsize = FM_FILLFRM( ffd, data, len, buf, bufsize, maskchar );

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
