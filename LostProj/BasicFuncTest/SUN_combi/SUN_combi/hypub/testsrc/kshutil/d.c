#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

char	*lfifo = "/home1/ieap/kshutil/testfifo";

main()
{
	int	i, fd;
	char	buf[3][6], tmp[10];

	strcpy( buf[0], "12345" );
	strcpy( buf[1], "abcde" );
	strcpy( buf[2], "kkkkk" );

	for( i=1; i<2; i++ )
	{
		printf( "before input (%d)= \n", i );

		fd = open( lfifo, O_WRONLY );
		if( fd < 0 )
		{
			printf( "open error(%d)\n", errno );
			close( fd );
			exit( 0 );
		}
		printf( "after open( %d) \n", i );

		if( write( fd, buf[i], 5 ) < 0 )
		{
			printf( "read error(%d)\n", errno );
		}

		close( fd );
	}
}	
