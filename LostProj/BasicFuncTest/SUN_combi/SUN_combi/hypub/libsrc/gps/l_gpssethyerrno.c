/* l_gpssethyerrno() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for gps				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	gps_hyerrno
*/
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_gpssethyerrno( int gps_hyerrno )
#else
l_gpssethyerrno( gps_hyerrno )
int	gps_hyerrno;
#endif
{
	hyerrno = gps_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = gps_hyerrno;
#endif
	return;
}

