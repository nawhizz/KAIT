/* SM_APPEND() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : append data to sam file					*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_APPEND( FILE	*fp, char *record, int recsize )
#else
SM_APPEND( fp, record, recsize )
FILE	*fp;
char	*record;
int	recsize;
#endif
{
	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}

	if( (fseek( fp, 0L, SEEK_END )) < 0 ) {
		l_fiosethyerrno( ESM_FSEEK );
		return( -1 ) ;
	}
	if( (int)fwrite(record, recsize, 1, fp) != 1 ) {
		l_fiosethyerrno( ESM_WRITE );
		return( -1 ) ;
	}
	return( 0 ) ;
}
