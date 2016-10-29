#include	<windows.h>

#include	"gps.h"
#include	"gpsdef.h"

DWORD	dwGpsTlsIndex;	// address of TLS Index
CRITICAL_SECTION	CfgCrtSec;

int WINAPI DllMain( HINSTANCE hInstDLL, DWORD dwReason, PVOID lpReserved )
{
	struct	GPS_GLOBAL_DATA	*gpsData;

	switch ( dwReason )	// The DLL is loading due to process
	{
		// initialization or a call to LoadLibrary.  
		case	DLL_PROCESS_ATTACH	:	// Allocate a TLS index.
			if( ( dwGpsTlsIndex = TlsAlloc() ) == 0xFFFFFFFF )
				return( FALSE );

			InitializeCriticalSection( &CfgCrtSec );

		// No break: Initialize the index for first thread.

		// The attached process creates a new thread.
		case	DLL_THREAD_ATTACH	:
			// Initialize the TLS index for this thread.
			gpsData = (struct GPS_GLOBAL_DATA *)LocalAlloc( LPTR, sizeof( struct GPS_GLOBAL_DATA ) );
			if( gpsData != NULL )
				if( !TlsSetValue( dwGpsTlsIndex, gpsData ) )
					return( FALSE );

			
			gpsData->g_msgidx = 0;
			break;

		// The thread of the attached process terminates.
		case	DLL_THREAD_DETACH	:
			// Release the allocated memory for this thread.
			gpsData = (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex );
			if( gpsData != NULL )
				LocalFree( (HLOCAL)gpsData );

			break;

		// The DLL unloading due to process termination or call to FreeLibrary.
		case	DLL_PROCESS_DETACH	:
			// Release the allocated memory for this thread.
			gpsData = (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex );
			if( gpsData != NULL )
				LocalFree( (HLOCAL)gpsData );
			// Release the TLS index.
			TlsFree( dwGpsTlsIndex );
			DeleteCriticalSection( &CfgCrtSec );
			break;
		
		default				:
			break;
	}
	
	return( TRUE );

	UNREFERENCED_PARAMETER( hInstDLL );
	UNREFERENCED_PARAMETER( lpReserved );
}
