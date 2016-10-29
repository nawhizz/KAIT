/* FM_FILLFRM() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : fill data in formatted form file				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	ffd		file descriptor
		  char	data[]		filling data
		  int	datalen 	length of data
		  int	destlen 	length of dest
		  char	maskchar	mask character
	output	: char	dest		masked form
	return	: >0 (size of filled data)
		  -1
*/

#include	<stdio.h>
#include	<string.h>

#include	"gps.h"
#include	"fio.h"
#include	"fm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FM_FILLFRM( int ffd, char data[], int datalen, char dest[], int destlen,
		char maskchar )
#else
FM_FILLFRM( ffd, data, datalen, dest, destlen, maskchar )
int	ffd;
char	data[];
int	datalen;
char	dest[];
int	destlen;
char	maskchar;
#endif
{
	register	i, j;
	FILE		*fd;
	int		fsize;

	if ( ffd == -1 || ( fd = fm_svfinfo[ffd].fd_sav ) == 0 ) {
		l_fiosethyerrno( EFM_NOPEN );
		return -1;
	}
	fsize = fm_svfinfo[ffd].fsize;

	if ( fsize <= 0 ) {
		l_fiosethyerrno( EFM_NODATA );
		return -1;
	}

	if ( fsize > destlen ) {
		l_fiosethyerrno( EFM_OVERFLOW );
		return -1;
	}

	memcpy( dest, fm_svfinfo[ffd].fbuff, fsize );

	for ( i = 0, j = 0; i < fsize && j < datalen; i++ ) {
		if ( dest[i] == maskchar )
			dest[i] = data[j++];
	}
	return fsize;
}
