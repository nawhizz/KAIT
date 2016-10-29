/* PI_DLMREAD() : LIB dsml */
/************************************************************************
*	read information of master directory				*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		: int	lmidx			index of lm		*
*	output	: struct DS_DIRMINFO *lmbuf	info of master dir	*
************************************************************************/

#include	<string.h>

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	read information of master directory				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DLMREAD( int fd, int lmidx, struct DS_DIRMINFO *lmbuf )
#else
PI_DLMREAD( fd, lmidx, lmbuf )
int			fd;
int			lmidx;
struct	DSMIFORM	*lmbuf;
#endif
{
	int	verno;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( verno != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( lmbuf == (struct DS_DIRMINFO *)0 || lmidx < 0 ||
			lmidx >= dsfi[fd].dircnt )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** search master directory information 
	**-------------------------------------------------------------*/
	lmbuf->dircnt = dsfi[fd].lm[lmidx].dircnt;
	strcpy( lmbuf->dir, dsfi[fd].lm[lmidx].dir );

	return( 0 );
}

/******* The end of PI_DLMREAD.c ****************************************/
