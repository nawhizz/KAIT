/* l_pisamsethyerrno() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for pisam				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	pisam_hyerrno
*/
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_pisamsethyerrno( int pisam_hyerrno )
#else
l_pisamsethyerrno( pisam_hyerrno )
int	pisam_hyerrno;
#endif
{
	hyerrno = pisam_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = pisam_hyerrno;
#endif
	return;
}

