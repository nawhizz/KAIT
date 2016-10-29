/* FS_GETPATH() : LIB fio */
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

int CBD1
#if	defined( __CB_STDC__ )
FS_GETPATH( char *fileid, char *fileext, char *filepath )
#else
FS_GETPATH( fileid, fileext, filepath )
char	*fileid;
char	*fileext;
char	*filepath;
#endif
{
	if ( fs_getfpath( fileid, fileext, filepath ) < 0 ) {
		l_fiosethyerrno( EFS_FILENDEF );
		return -1;
	}
	return	0;
}
