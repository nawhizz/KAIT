/* wfm_freeseginfo() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : free segment info for a form file				*/
/*----------------------------------------------------------------------*/
/* internal function */
/*
	input	: struct WFM_SEGINFO	*seg	: seg to free
	return	: none
*/

#include	<stdlib.h>

#include	"wfm_fun.h"

void
#if	defined( __CB_STDC__ )
wfm_freeseginfo( struct WFM_SEGINFO *seg )
#else
wfm_freeseginfo( seg )
struct WFM_SEGINFO *seg;
#endif
{
	struct WFM_SEGINFO *segptr;
	struct WFM_SEGINFO *segptr_sav;
	
	for( segptr = seg; segptr; )
	{
		if( !segptr->next )
		{
			wfm_freeblkinfo( segptr->blk );
			free( segptr );
			break;
		}
		else 
		{
			segptr_sav = segptr->next;
			wfm_freeblkinfo( segptr->blk );
			free( segptr );
			segptr = segptr_sav->next;
		}
	}
	return;	/* OK */
}
