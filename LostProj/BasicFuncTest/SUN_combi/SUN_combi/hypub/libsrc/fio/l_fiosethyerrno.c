/* l_fiosethyerrno() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : Set hyerrno value for fio				        */
/*----------------------------------------------------------------------*/
/*
	input	: int	fio_hyerrno
*/
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_fiosethyerrno( int fio_hyerrno )
#else
l_fiosethyerrno( fio_hyerrno )
int	fio_hyerrno;
#endif
{
	hyerrno = fio_hyerrno;
#ifdef	WIN32
	(*_hyerrno()) = fio_hyerrno;
#endif
	return;
}

