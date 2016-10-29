/* l_wfmsethyerrno() : LIB dsml */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for wfm				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	wfm_hyerrno
*/
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_wfmsethyerrno( int wfm_hyerrno )
#else
l_wfmsethyerrno( wfm_hyerrno )
int	wfm_hyerrno;
#endif
{
	hyerrno = wfm_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = wfm_hyerrno;
#endif
	return;
}

