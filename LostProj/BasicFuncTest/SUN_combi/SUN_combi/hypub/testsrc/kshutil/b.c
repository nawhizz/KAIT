#include <stdio.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <errno.h>

/*
#include "/home1/ieap/common/include/unix/iswrap.h"
#include "/home1/ieap/common/include/gps.h"
#include "/home1/ieap/common/include/pisam.h"
*/

main( int argc, char *argv[] )
{
	struct	timeval	tv;
	struct	tm	*tmt;

	gettimeofday( &tv, (void *)0 );
	tv.tv_sec -= 57600;
	tv.tv_sec -= 1200;
	tmt = localtime( &tv.tv_sec );
	printf( "%02d:%02d:%02d\n", tmt->tm_hour, tmt->tm_min, tmt->tm_sec );
}
