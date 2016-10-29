/* SM_REDLN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : ???????							*/
/*----------------------------------------------------------------------*/
/*
	input	: FILE	*fp		file descriptor
		  int	recsize		size of line buffer (>512)
	output	: char	*linebuff	read line buffer
	return	: 0/-1
*/

#include	<stdio.h>
#include	<string.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_REDLN( FILE *fp, char *linebuff, int recsize )
#else
SM_REDLN( fp, linebuff, recsize )
FILE	*fp;
char	*linebuff;
int	recsize;
#endif
{
	char	*linedata;

	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}

	if( ( linedata = (char *)malloc( SM_LINESIZE + 1 ) ) == (char *)0 )
	{
		l_fiosethyerrno( EFM_NOMEM );
		return -1;
	}

	if ( fgets( linedata, SM_LINESIZE, fp ) == (char *)0 ) {
		free( linedata );
		l_fiosethyerrno( ESM_READ );
		return -1;
	}

	if ( (int)strlen( linedata ) > recsize ) {
		free( linedata );
		l_fiosethyerrno( ESM_OVERFLOW );
		return -1;
	}
	if( (int)strlen(linedata) && linedata[strlen(linedata)-1] == 26 )
		linedata[strlen(linedata)-1] = '\0';

	strcpy( linebuff, linedata );
	free( linedata );
	return ( strlen( linebuff ) );
}
