/* l_dsmlsethyerrno() : LIB dsml */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for dsml				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	dsml_hyerrno
*/
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_dsmlsethyerrno( int dsml_hyerrno )
#else
l_dsmlsethyerrno( dsml_hyerrno )
int	dsml_hyerrno;
#endif
{
	hyerrno = dsml_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = dsml_hyerrno;
#endif
	return;
}

