/* TraceLog : LIB gps */
/*----------------------------------------------------------------------+
|	DBGF ( debugging functions )       				|
|									|
|	system:	DLTP							|
|									|
|	96.9.21 - 96.9.23						|
|									|
+-----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<sys/types.h>
#ifndef		WIN32
#include	<unistd.h>
#include	<sys/time.h>
#else
#include	<io.h>
#include	<sys/timeb.h>
#endif

#include	<time.h>
#include	<stdarg.h>

#include	"gps.h"

int CBD1
TraceLog( int TL_fd, char *fmt, ... )
{
static	char	buffer[1024];

	va_list vlist;

	va_start( vlist, fmt );

	if( TL_fd > 0 )
	{
#ifndef	WIN32
		struct	tm	*t;
		struct	timeval	tv;

		gettimeofday( &tv, (void *)0 );
		t = localtime( &tv.tv_sec );
		sprintf( buffer, "%02d/%02d %02d:%02d:%02d.%03ld ",
			t->tm_mon + 1, t->tm_mday,
			t->tm_hour, t->tm_min, t->tm_sec,
			tv.tv_usec / 1000 );
		vsprintf( &buffer[19], fmt, vlist );
		write( TL_fd, buffer, strlen( buffer ) );
#else
		struct	tm	*t;
		struct	_timeb	tv;

		_ftime( &tv );
		t = localtime( &tv.time );
		sprintf( buffer, "%02d/%02d %02d:%02d:%02d.%03ld ",
			t->tm_mon + 1, t->tm_mday,
			t->tm_hour, t->tm_min, t->tm_sec,
			tv.millitm );
		vsprintf( &buffer[19], fmt, vlist );
		_write( TL_fd, buffer, strlen( buffer ) );
#endif
	}

	va_end( vlist );

	return 0;
}
