/* wfm_freeblkinfo() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : free block info for a form file segment			*/
/*----------------------------------------------------------------------*/
/* internal function */
/*
	input	: struct WFM_BLKINFO	*blk	: blk to free
	return	: none
*/

#include	<stdlib.h>

#include	"wfm_fun.h"

void
#if	defined( __CB_STDC__ )
wfm_freeblkinfo( struct WFM_BLKINFO *blk )
#else
wfm_freeblkinfo( blk )
struct WFM_BLKINFO *blk;
#endif
{
	struct WFM_BLKINFO *blkptr;
	struct WFM_BLKINFO *blkptr_sav;
	
	for( blkptr = blk; blkptr; )
	{
		if( !blkptr->next )
		{
			free( blkptr );
			break;
		}
		else 
		{
			blkptr_sav = blkptr->next;
			free( blkptr );
			blkptr = blkptr_sav->next;
		}
	}
	return;	/* OK */
}
