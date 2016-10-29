/* PI_DLVREAD() : LIB dsml */
/************************************************************************
*	read information of master directory				*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		: int	volno			volume number		*
*		: int	lvidx			index of lv		*
*	output	: struct DS_DIRVINFO *lvbuf	info of sub dir		*
************************************************************************/

#include	<string.h>

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	read information of sub directory				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DLVREAD( int fd, int volno, int lvidx, struct DS_DIRVINFO *lvbuf )
#else
PI_DLVREAD( fd, volno, lvidx, lvbuf )
int			fd;
int			volno;
int			lvidx;
struct	DSMIFORM	*lvbuf;
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

	if( volno < 0 || volno >= dsfi[fd].volcnt ||
		lvbuf == (struct DS_DIRVINFO *)0 || 
		lvidx < 0 || lvidx >= dsfi[fd].vol[volno].dircnt )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** search sub directory information 
	**-------------------------------------------------------------*/
	lvbuf->filecnt = dsfi[fd].vol[volno].lv[lvidx].filecnt;
	strcpy( lvbuf->dir, dsfi[fd].vol[volno].lv[lvidx].dir );

	return( 0 );
}

/******* The end of PI_DLVREAD.c ****************************************/
