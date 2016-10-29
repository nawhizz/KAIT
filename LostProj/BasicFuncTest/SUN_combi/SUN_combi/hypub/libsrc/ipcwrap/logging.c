extern	int
l_ipclog( char *fmt, ... )
{
	char	logpath[128];
	va_list vlist;
	time_t	tv;
	struct	tm	*t;
	FILE	*fd;

	GetTempPath(sizeof(logpath), logpath);
	strcat( logpath, "\\ipcd.log" ); 
	if( ( fd = fopen( logpath, "a" ) ) == (FILE *)0 )
		return 0;
	va_start( vlist, fmt );

	time(&tv);
	t = localtime( &tv );
	fprintf( fd, "[%06d] %04d/%02d/%02d %02d:%02d:%02d ", GetCurrentProcessId(),
		t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
		t->tm_hour, t->tm_min, t->tm_sec );
	vfprintf( fd, fmt, vlist );
	va_end( vlist );

	fclose( fd );
	return 0;
}
