/* h_errno() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : declare error number						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"
#include	"gpsdef.h"
/*
#ifdef	WIN32
#if     (defined(_MT) || defined(_DLL)) && !defined(_MAC)
extern	DWORD	dwGpsTlsIndex;
int *	__cdecl	_hyerrno( void )
{
	struct	GPS_GLOBAL_DATA	*gpsData;

	gpsData = (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex );
	return( &(gpsData->g_hyerrno) );
}
#else	* ndef _MT && ndef _DLL *
int	hyerrno;
#endif	* _MT || _DLL *
#else	* ndef WIN32 *
int	hyerrno;
#endif	* WIN32 *
*/
int	hyerrno;

#ifdef	WIN32
extern	DWORD	dwGpsTlsIndex;
int *	__cdecl	_hyerrno( void )
{
	return( &( ( (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex ) )->g_hyerrno) );
}
#endif	/* WIN32 */
