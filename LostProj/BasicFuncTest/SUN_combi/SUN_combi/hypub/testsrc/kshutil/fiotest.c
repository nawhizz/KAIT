#include <stdio.h>
#include <errno.h>
#include "/home1/ieap/common/include/gps.h"
#include "/home1/ieap/common/include/fio.h"

main()
{
	int	fd, i;
	char	dest[80], inbuf[10];

	fd = FM_OPEN( "test" );
	if( fd < 0 )
	{
		printf( "open error ( %d, %d )\n", hyerrno , errno );
		exit( 0 );
	}

	for( i=0; i<5; i++ )
	{
		memset( dest, 0, sizeof(dest) );
		if( FM_FILLSEG( fd, "BODY1", "12345", 5, dest, sizeof(dest), '#' ) < 0 )
		{
			printf( "fm_fillseg error ( %d, %d )\n", hyerrno , errno );
			FM_CLOSE( fd );
			exit( 0 );
		}
		printf( "dest(%d) = [%s]\n", i, dest );

	inbuf[0] = ' ';
	inbuf[1] = ' ';
	inbuf[2] = ' ';
	inbuf[3] = '\n';
	inbuf[4] = '\r';
	memset( dest, 0, sizeof(dest) );
	if( FM_FILLSEG( fd, "BODY1", inbuf, 5, dest, sizeof(dest), '#' ) < 0 )
	{
		printf( "fm_fillseg error ( %d, %d )\n", hyerrno , errno );
		FM_CLOSE( fd );
		exit( 0 );
	}
	printf( "dest(%d) = [%s]\n", i, dest );

		memset( dest, 0, sizeof(dest) );
		if( FM_FILLSEG( fd, "BODY2", "abcde", 5, dest, sizeof(dest), '#' ) < 0 )
		{
			printf( "fm_fillseg error ( %d, %d )\n", hyerrno , errno );
			FM_CLOSE( fd );
			exit( 0 );
		}
		printf( "dest(%d) = [%s]\n", i, dest );
	}

	FM_CLOSE( fd );
}
