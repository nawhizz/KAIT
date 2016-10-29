/* OFM_GETPATH() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get full path of form file					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid 	file id
		  char	*fileext	file extention
	output	: char	*filepath	full path of file
	return	: 0/-1
*/

#include	"fio.h"
#include	"fm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_GETPATH( char *retcode, char *fileid, char *fileext, char *filepath )
#else
OFM_GETPATH( retcode, fileid, fileext, filepath )
char	*retcode;			/* X(5). SPACE=OK */
char	*fileid;			/* X(8) */
char	*fileext;			/* X(n) */
char	*filepath;			/* X(100) */
#endif
{
	register	i;
	char		l_fileid[FM_IDLEN + 1];
	char		l_fileext[40 + 1];
	char		l_filepath[FM_PATHLEN + 1];

	d_mkstr( fileid, FM_IDLEN, l_fileid );
	d_mkstr( fileext, 40, l_fileext );
	if ( FM_GETPATH( l_fileid, l_fileext, l_filepath ) < 0 ) {
		fm_errset( retcode );
		return;
	}

	for( i=0; i<FM_PATHLEN && (unsigned char)l_filepath[i] > ' '; i++ )
		filepath[i] = l_filepath[i];
	for( ; i<FM_PATHLEN; i++ )
		filepath[i] = ' ';

	memset( retcode, ' ', 5 );
	return;
}
