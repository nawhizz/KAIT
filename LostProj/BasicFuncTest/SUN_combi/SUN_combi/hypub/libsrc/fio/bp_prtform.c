/* bp_prtform() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print formatted data to file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	pfd		file descriptor
		  int	ffd		form file descriptor
		  char	*data		data for print (not formatted)
		  int	len		length of data
		  char	maskchar	masking character
	return	: 0/-1
*/

#include	<stdlib.h>

#include	"fio.h"

int CBD1
#if	defined( __CB_STDC__ )
bp_prtform( int	pfd, int ffd, char *data, int len, char	maskchar )
#else
bp_prtform( pfd, ffd, data, len, maskchar )
int	pfd;
int	ffd;
char	*data;
int	len;
char	maskchar;
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

	prtsize = FM_FILLFRM( ffd, data, len, buf, bufsize, maskchar );

	if( prtsize <= 0 )
	{
		free( buf );
		return( -1 );
	}

	if( FS_APPEND( pfd, buf, prtsize ) < 0 )
	{
		free( buf );
		return( -1 );
	}

	free( buf );
	return( 0 );
}
