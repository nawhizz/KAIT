/* PI_DVREAD() : LIB dsml */
/************************************************************************
*	read volume							*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	volno			volume number		*
*	output	: struct DSMVFORM *dsmv_inf	volume information	*
************************************************************************/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	add new volume							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DVREAD( int fd, int volno, struct DSMVFORM *dsmv_inf )
#else
PI_DVREAD( fd, volno, dsmv_inf )
int			fd;
int			volno;
struct	DSMVFORM	*dsmv_inf;
#endif
{
	int	verno;
	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return -1;

	if( !dsfi[fd].filepath[0] )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}

	if( dsfi[fd].verno[0] != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( volno < 0 || volno >= dsfi[fd].volcnt )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( dsmv_inf == (struct DSMVFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** set volume information
	**-------------------------------------------------------------*/
	memset( dsmv_inf, 0, sizeof( struct DSMVFORM ) );
	dsmv_inf->doccnt	= dsfi[fd].vol[volno].doccnt;
	dsmv_inf->mindocid	= dsfi[fd].vol[volno].mindocid;
	dsmv_inf->maxdocid	= dsfi[fd].vol[volno].maxdocid;
	dsmv_inf->usedblkcnt	= dsfi[fd].vol[volno].usedblkcnt;
	dsmv_inf->reservblkcnt	= dsfi[fd].vol[volno].reservblkcnt;
	strcpy( dsmv_inf->volpath, dsfi[fd].vol[volno].volpath );
	dsmv_inf->maxvolsz	=
			dsfi[fd].vol[volno].maxblkcnt * dsfi[fd].blksz / 1024;
	dsmv_inf->volgen	= dsfi[fd].vol[volno].volgen;

	return( 0 );
}

/******* The end of PI_DVREAD.c ****************************************/
