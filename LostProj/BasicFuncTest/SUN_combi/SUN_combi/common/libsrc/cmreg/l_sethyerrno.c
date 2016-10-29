/* l_sethyerrno() : LIB cmreg */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for cmreg				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	l_hyerrno
*/
#include	"gps.h"
#include	"cmregdef.h"

void
#if	defined( __CB_STDC__ )
l_sethyerrno( int l_hyerrno )
#else
l_sethyerrno( l_hyerrno )
int	l_hyerrno;
#endif
{
	hyerrno = l_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = l_hyerrno;
#endif
	return;
}

