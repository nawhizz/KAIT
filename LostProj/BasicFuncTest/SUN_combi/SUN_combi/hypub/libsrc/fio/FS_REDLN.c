/* FS_REDLN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : ???????							*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  int	buffsize	size of line buffer (>512)
	output	: char	*linebuff	read line buffer
	return	: 0/-1
*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_REDLN( int sfd, char	*linebuff, int buffsize )
#else
FS_REDLN( sfd, linebuff, buffsize )
int	sfd;
char	*linebuff;
int	buffsize;
#endif
{
	FILE	*fd;
	char	*linedata;

	if ( sfd == -1 || ( fd = fs_svfinfo[sfd].fd_sav ) == (FILE *)0 ) {
		l_fiosethyerrno( EFS_NOPEN );
		return -1;
	}

	if( ( linedata = (char *)malloc( FS_LINESIZE + 1 ) ) == (char *)0 )
	{
		l_fiosethyerrno( EFM_NOMEM );
		return -1;
	}

	if ( fgets( linedata, FS_LINESIZE, fd ) == (char *)0 ) {
		free( linedata );
		l_fiosethyerrno( EFS_READ );
		return -1;
	}

	if ( (int)strlen( linedata ) > buffsize ) {
		free( linedata );
		l_fiosethyerrno( EFS_OVERFLOW );
		return -1;
	}
	if( (int)strlen(linedata) && linedata[strlen(linedata)-1] == 26 )
		linedata[strlen(linedata)-1] = '\0';

	strcpy( linebuff, linedata );
	free( linedata );
	return ( strlen( linebuff ) );
}
