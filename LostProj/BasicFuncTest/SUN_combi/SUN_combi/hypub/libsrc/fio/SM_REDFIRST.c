/* SM_REDFIRST() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read first data						*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_REDFIRST( FILE *fp, char *record, int recsize )
#else
SM_REDFIRST( fp, record, recsize )
FILE	*fp;
char	*record;
int	recsize;
#endif
{
	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}

	if( fseek( fp, 0L, SEEK_SET  ) < 0 ) {
		l_fiosethyerrno( ESM_FSEEK );
		return( -1 ) ;
	}

	if( (int)fread( record, recsize, 1, fp ) != 1 ) {
		l_fiosethyerrno( ESM_READ );
		return( -1 ) ;
	}
	return( 0 );
}
