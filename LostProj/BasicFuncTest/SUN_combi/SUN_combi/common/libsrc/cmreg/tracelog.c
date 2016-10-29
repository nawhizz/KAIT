/* tracelog.c */
/*----------------------------------------------------------------------*/
/* FUNC : generate file							*/
/*----------------------------------------------------------------------*/
/* cmreg internal function */
#include	<stdio.h>	/*fclose,fopen,fprintf,va_start,va_end,
				vfprintf*/
#include	<string.h>	/*strcat*/
#include	<stdarg.h>	/*vfprintf*/
#include	<time.h>

#include	"gps.h"
#include	"cmreg.h"
#include	"cmregdef.h"

/*----------------------------------------------------------------------*/
/* FUNC : Internal							*/
/*----------------------------------------------------------------------*/
void
#if	defined(__CB_STDC__)
tracelog( char *fmt, ... )
#else
tracelog( fmt, ... )
char	*fmt;
#endif
{
#ifdef	TRACELOG
	va_list vlist;
static	int	cnt=0;
static	char	logpath[128];
	char	termid[20];
	FILE	*logfd;

	if( !fmt )
		return;

	if( !cnt )
	{
		if( e_getenv( "TPLOG", logpath ) < 0 )
		{
			if( e_getenv( "TPHOME", logpath ) < 0 )
#ifdef	WIN32
				strcpy( logpath, "c:\\" );
#else
				strcpy( logpath, "/tmp" );
#endif
		}
#ifdef	WIN32
		strcat( logpath, "\\" );
#else
		strcat( logpath, "/" );
#endif
		strcat( logpath, "cmreg.log" );
		if( e_getenv( "TERMID", termid ) >= 0 )
		{
			strcat( logpath, "." );
			strcat( logpath, termid );
		}
		cnt++;
	}

	logfd = fopen( logpath, "a" );
	if( logfd == (FILE *)0 )
		return;

	fprintf( logfd, "fileno=%d  ", fileno(logfd) );
	va_start( vlist, fmt );
	vfprintf( logfd, fmt, vlist );
	va_end( vlist );
	fclose( logfd );
#endif
}
/*----------------------------------------------------------------------*/
void
#if	defined(__CB_STDC__)
l_errlog( char *ftn, char *fmt, ... )
#else
l_errlog( ftn, fmt, ... )
char	*ftn;
char	*fmt;
#endif
{
	va_list 	vlist;
	FILE		*logfd;
	long		timeval;
	struct	tm	*tmt;
	int		i;
	char		datetimestr[20];
	char		logpath[128], tpportno[10], *_lpath;
	char		*_termid, *_asid;
	char		l_null[1], logbuf[256];

	if( !ftn )
		return;

	if( !fmt )
		return;

	l_null[0] = 0;

	_termid = (char *)getenv( "TERMID" );
	if( !_termid )
		_termid = l_null;

	_asid = (char *)getenv( "ASID" );
	if( !_asid )
		_asid = l_null;

	if( e_getenv( "TPPORTNO", tpportno ) < 0 )
		strcpy( tpportno, "0" );

	if( e_getenv( "TPLOG", logpath ) < 0 )
	{
		if( e_getenv( "TPHOME", logpath ) < 0 )
		{
#ifdef	WIN32
			strcpy( logpath, "c:\\" );
#else
			strcpy( logpath, "/tmp" );
#endif
		}
	}
	_lpath = logpath + strlen(logpath);
#ifdef	WIN32
	sprintf( _lpath, "\\err%s.log", tpportno );
#else
	sprintf( _lpath, "/err%s.log", tpportno );
#endif

	logfd = fopen( logpath, "a" );
	if( logfd == (FILE *)0 )
		return;

	tzset ();
	timeval = (long)time(0);
	tmt = localtime ((time_t *)&timeval);

	sprintf ( datetimestr, "%02d/%02d/%02d %02d:%02d:%02d",
		(int) tmt->tm_year, (int) tmt->tm_mon+1, (int) tmt->tm_mday,
		(int) tmt->tm_hour, (int) tmt->tm_min,	 (int) tmt->tm_sec );

	sprintf( logbuf, "CMREGerr [%8.8s]<%4.4s>[%s] <hyerrno=%5.5d> %s",
		_termid, _asid, ftn, hyerrno, datetimestr );
	for( i=strlen(logbuf); i<80; i++ )
		logbuf[i] = ' ';
	logbuf[i] = 0;	
	strcat( logbuf, "--->" );

	fprintf( logfd, logbuf );

	va_start( vlist, fmt );
	vfprintf( logfd, fmt, vlist );
	va_end( vlist );

	fclose( logfd );
}
