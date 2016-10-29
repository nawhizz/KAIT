/* ds_chkbuildinf() : LIB dsml internal function */
/************************************************************************
*	check build information						*
*-----------------------------------------------------------------------*
*	input	: struct BUILDFORM *sbuild_inf	build information	*
*	output	: struct BUILDFORM *dbuild_inf	build information	*
************************************************************************/

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	check build information						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_chkbuildinf( struct BUILDFORM *sbuild_inf, struct BUILDFORM *dbuild_inf )
#else
ds_chkbuildinf( sbuild_inf, dbuild_inf )
struct	BUILDFORM	*sbuild_inf;
struct	BUILDFORM	*dbuild_inf;
#endif
{
	register	short	chksz;

	/* check member */
	if( sbuild_inf->maxvolsz < 0 || sbuild_inf->maxvolsz > DS_MAX_VOLSZ ||
	    sbuild_inf->blksz < 0 || sbuild_inf->blksz > DS_MAX_BLKSZ )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/* move block size */
	if( sbuild_inf->blksz == 0 )
		dbuild_inf->blksz = DS_DEF_BLKSZ;
	else
		dbuild_inf->blksz = sbuild_inf->blksz;

	for( chksz = 1; chksz < dbuild_inf->blksz; chksz *= 2 );
	dbuild_inf->blksz = chksz;

	/* move etc */
	if( sbuild_inf->maxvolsz == 0 )
		dbuild_inf->maxvolsz = DS_MAX_VOLSZ;
	else
		dbuild_inf->maxvolsz = sbuild_inf->maxvolsz;

	return( 0 );
}

/******* The end of ds_chkbuildinf.c ***********************************/
