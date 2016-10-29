/* ds_chkvolinf() : LIB dsml internal function */
/************************************************************************
*	check volume information					*
*-----------------------------------------------------------------------*
*	input	: struct VOLFORM *svol_inf	volume information	*
*	output	: struct VOLFORM *dvol_inf	volume information	*
************************************************************************/

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	check volume information					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_chkvolinf( struct VOLFORM *svol_inf, struct VOLFORM *dvol_inf )
#else
ds_chkvolinf( svol_inf, dvol_inf )
struct	VOLFORM	*svol_inf;
struct	VOLFORM	*dvol_inf;
#endif
{
	/* check member */
	if( svol_inf->maxvolsz < 0 || svol_inf->maxvolsz > DS_MAX_VOLSZ )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/* move etc */
	if( svol_inf->maxvolsz == 0 )
		dvol_inf->maxvolsz = DS_MAX_VOLSZ;
	else
		dvol_inf->maxvolsz = svol_inf->maxvolsz;

	if( ds_fullpath( svol_inf->volpath, dvol_inf->volpath ) < 0 )
		return( -1 );

	return( 0 );
}

/******* The end of ds_chkvolinf.c *************************************/
