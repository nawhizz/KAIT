/* FM_GETPATH() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get full path of file 					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid 	file id
		  char	*fileext	file extention
	output	: char	*filepath	full file path
	return	: 0/-1
*/

#include	"gps.h"
#include	"fio.h"
#include	"fm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FM_GETPATH( char *fileid, char *fileext, char *filepath )
#else
FM_GETPATH( fileid, fileext, filepath )
char	*fileid;
char	*fileext;
char	*filepath;
#endif
{
	if ( fm_getfpath( fileid, fileext, filepath ) < 0 ) {
		l_fiosethyerrno( EFM_CFGNDEF );
		return -1;
	}
	return	0;
}
