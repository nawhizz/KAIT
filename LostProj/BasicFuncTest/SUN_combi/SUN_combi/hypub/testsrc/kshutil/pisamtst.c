#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#include "/home1/ieap/common/include/gps.h"
#include "/home1/ieap/common/include/pisam.h"
#include "/home1/ieap/dltp/dblay/lusr.h"

main()
{
	int	fd;
	struct	lusrFORM	lusrrec;

	if( PI_TRAN() < 0 )
	{
		printf( "pi_tran(). %d\n", hyerrno, errno );
		exit( 0 );
	}

	fd = PI_TROPEN( "/home1/ieap/kshutil/lusr", "lusr" );
	if( fd < 0 )
	{
		printf( "pi_tropen(). %d\n", hyerrno, errno );
		PI_ENDTRAN();
		exit( 0 );
	}

	memset( (char *)&lusrrec, ' ', sizeof(lusrrec) );
	memcpy( lusrrec.usid, "0400    ", 8 );
	if( PI_REDGT( fd, "KA", (char *)&lusrrec ) < 0 )
	{
		printf( "pi_redgt(). %d\n", hyerrno, errno );
		PI_CLOSE( fd );
		PI_ENDTRAN();
		exit( 0 );
	}

	for( ; ; )
	{
		printf( "usid = %.8s\n", lusrrec.usid );

		if( PI_DELET( fd, (char *)&lusrrec ) < 0 )
		{
			printf( "pi_addit(). %d\n", hyerrno, errno );
			PI_CLOSE( fd );
			PI_ENDTRAN();
			exit( 0 );
		}

		if( PI_REDNX( fd, (char *)&lusrrec ) < 0 )
			break;
	}

	PI_CLOSE( fd );	
	PI_COMMIT();
	PI_ENDTRAN();
}
