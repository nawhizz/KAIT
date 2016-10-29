/* FM_OPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : open file							*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid 	file id
	return	: >=0 (file descriptor)
		  -1
*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"fm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FM_OPEN( char *fileid )
#else
FM_OPEN( fileid )
char	*fileid;
#endif
{
	char	filepath[FM_PATHLEN];
	char	*fbuff;
	int	ffd, fsize;
	FILE	*fd;

	if( fm_currfd < 0 ) {
		l_fiosethyerrno( EFM_FDFULL );
		return -1;
	}

	if ( fm_getfpath( fileid, FM_FILEEXT, filepath ) < 0 ) {
		l_fiosethyerrno( EFM_CFGNDEF );
		return -1;
	}

	if( ( fd = fopen( filepath, "r+b" ) ) == (FILE *)0 ) {
		l_fiosethyerrno( errno );
		return -1;
	}

	fseek( fd, 0, SEEK_END );
	fsize = ftell( fd );
	if( ( fbuff = (char *)malloc( fsize ) ) == (char *)0 )
	{
		fclose( fd );
		l_fiosethyerrno( EFM_NOMEM );
		return -1;
	}

	fseek( fd, 0L, SEEK_SET );
	if ( (int)fread( fbuff, fsize, 1, fd ) <= 0 ) {
		l_fiosethyerrno( errno );
		fclose( fd );
		free( fbuff );
		return -1;
	}

	ffd = fm_savefile( filepath, fd, fbuff, fsize );
	return ffd;
}
