/* l_socksethyerrno() : LIB sock */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for sock				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	sock_hyerrno
*/
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_socksethyerrno( int sock_hyerrno )
#else
l_socksethyerrno( sock_hyerrno )
int	sock_hyerrno;
#endif
{
	hyerrno = sock_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = sock_hyerrno;
#endif
	return;
}

