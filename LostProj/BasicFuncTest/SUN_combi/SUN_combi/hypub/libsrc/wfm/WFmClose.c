/* WFmClose() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : close formatted form file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	ffd		file descriptor
	return	: 0/-1
*/

#include	"wfm.h"
#include	"wfm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
WFmClose( int FormFD )
#else
WFmClose( FormFD )
int	FormFD;
#endif
{
	if ( FormFD < 0 || FormFD >= WFM_MAXOPEN )
	{
		l_wfmsethyerrno( EWF_INVAL_ARG );
		return -1;
	}

	if ( !wfm_svfinfo[FormFD].filepath_sav[0] )
	{
		l_wfmsethyerrno( EWF_INVAL_FD );
		return -1;
	}

	wfm_freeseginfo( wfm_svfinfo[FormFD].hseg );
	wfm_freeseginfo( wfm_svfinfo[FormFD].cseg );
	wfm_freeseginfo( wfm_svfinfo[FormFD].tseg );
	wfm_svfinfo[FormFD].hseg = (void *)0;
	wfm_svfinfo[FormFD].cseg = (void *)0;
	wfm_svfinfo[FormFD].tseg = (void *)0;

	wfm_svfinfo[FormFD].filepath_sav[0] = '\0';
	if( wfm_svfinfo[FormFD].fbuff ) free( wfm_svfinfo[FormFD].fbuff );
	wfm_svfinfo[FormFD].fbuff = (char *)0;
	wfm_svfinfo[FormFD].fsize = 0;
	if( wfm_currfd < 0 ) wfm_currfd = FormFD;

	return 0;
}
