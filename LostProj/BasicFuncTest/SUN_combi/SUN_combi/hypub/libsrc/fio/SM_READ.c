/* SM_READ() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read data from record number's position's of sam file 	*/
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
SM_READ( FILE *fp, char	*record, int recsize, int recno )
#else
SM_READ( fp, record, recsize, recno )
FILE	*fp;
char	*record;
int	recsize;
int	recno;
#endif
{
	long	offset;

	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}

	offset = (long)recsize * (long)recno;

	if( fseek( fp, offset, SEEK_SET  ) < 0 ) {
		l_fiosethyerrno( ESM_FSEEK );
		return( -2 ) ;
	}

	if( (int)fread( record, recsize, 1, fp ) < 1 ) {
		l_fiosethyerrno( ESM_READ );
		return( -3 ) ;
	}
	return( 0 );
}
