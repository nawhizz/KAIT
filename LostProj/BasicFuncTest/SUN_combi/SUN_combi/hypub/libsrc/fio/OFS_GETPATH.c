/* OFS_GETPATH() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get full path of formatted sam file ("SAMCFG" use)		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid 	file id
		  char	*fileext	file extention
	output	: char	*filepath	full path of file
	return	: 0/-1
*/

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_GETPATH( char *retcode, char *fileid, char *fileext, char *filepath )
#else
OFS_GETPATH( retcode, fileid, fileext, filepath )
char	*retcode;			/* X(5). SPACE=OK */
char	*fileid;			/* X(8) */
char	*fileext;			/* X(n) */
char	*filepath;			/* X(100) */
#endif
{
	register	i;
	char		l_fileid[FS_IDLEN + 1];
	char		l_fileext[FS_EXTLEN + 1];
	char		l_filepath[FS_PATHLEN + 1];

	d_mkstr( fileid, FS_IDLEN, l_fileid );
	d_mkstr( fileext, FS_EXTLEN, l_fileext );
	if ( FS_GETPATH( l_fileid, l_fileext, l_filepath ) < 0 ) {
		fs_errset( retcode );
		return;
	}

	for( i=0; i<FS_PATHLEN && (unsigned char)l_filepath[i] > ' '; i++ )
		filepath[i] = l_filepath[i];
	for( ; i<FS_PATHLEN; i++ )
		filepath[i] = ' ';

	memset( retcode, ' ', 5 );
	return;
}
