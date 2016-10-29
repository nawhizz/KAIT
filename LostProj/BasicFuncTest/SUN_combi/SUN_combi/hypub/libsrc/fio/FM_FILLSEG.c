/* FM_FILLSEG() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : fill data in one masked segment				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	ffd		file descriptor
		  char	*segid		segment descriptor
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
FM_FILLSEG( int ffd, char *segid, char data[], int datalen, char dest[],
		int destlen, char maskchar )
#else
FM_FILLSEG( ffd, segid, data, datalen, dest, destlen, maskchar )
int	ffd;
char	*segid;
char	data[];
int	datalen;
char	dest[];
int	destlen;
char	maskchar;
#endif
{
	register	i, j;
	FILE		*fd;
	char		buff[FM_LINESIZE];
	char		*fbuff;
	int		num, fsize, segidlen;
	int		segstart, segsize;

	if ( ffd == -1 || ( fd = fm_svfinfo[ffd].fd_sav ) == 0 ) {
		l_fiosethyerrno( EFM_NOPEN );
		return -1;
	}

	fsize = fm_svfinfo[ffd].fsize;
	fbuff = fm_svfinfo[ffd].fbuff;
	if( segid == (char *)0 ) segidlen = 0;
	else segidlen = strlen( segid );
	if( segidlen > sizeof buff - 1 ) return( -1 );

	segstart = 0;
	if( segidlen > 0 ) while ( 1 ) {
		num = fm_getline( &fbuff[segstart], fsize - segstart, buff );
		segstart += num;
		if ( segstart >= fsize - segidlen ) {
			l_fiosethyerrno( EFM_NOSEGID );
			return ( -1 );
		}
		if ( buff[0] == ':' )	/* segment name start separator */
			if ( !memcmp( &buff[1], segid, segidlen ) )
				break;
	}
	segsize = 0;
	for ( i = segstart; i < fsize - 1; i+= num ) {
		num = fm_getline( &fbuff[i], fsize - i, buff );
		if ( buff[0] == ':' ) break;
		segsize += num;
	}

	if ( segsize >= destlen ) {
		l_fiosethyerrno( EFM_OVERFLOW );
		return -1;
	}
	memcpy( dest, &fbuff[segstart], segsize );

	if ( !data || ! datalen )
		return segsize;

	for ( i = 0, j = 0; i < segsize && j < datalen; i++ ) {
		if ( dest[i] == maskchar )
			dest[i] = data[j++];
	}
	return segsize;
}
