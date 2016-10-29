/* WFmAllClose() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : close all form file opened	 				*/
/*----------------------------------------------------------------------*/

#include	"wfm.h"
#include	"wfm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
WFmAllClose( void )
#else
WFmAllClose()
#endif
{
	register	i;

	for ( i = 0; i < WFM_MAXOPEN; i++ )
	{
		if ( !wfm_svfinfo[i].filepath_sav[0] ) continue;

		WFmClose( i );
	}

	wfm_currfd = 0;
	if( wfm_outbuf ) free( wfm_outbuf );
	wfm_outbuf = (char *)0;
	wfm_outbuf_size = 0;
	return;
}
