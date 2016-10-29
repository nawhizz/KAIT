/***********************************************************************+
| 수정이력								|
| 2001.03.19. tab 이 들어간 경우					|
+************************************************************************/
#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<unistd.h>

#include	"cbuni.h"

unsigned char	rbuf[16*1024];
unsigned char	dbuf[16*1024];
char		syscmd[200];
char		dfpath[200];

FILE		*sfd, *dfd;

int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	int	nread;
	int	nwrite;
	int	i;
	int	j;

	if( argc < 2 )
	{
		printf( "\nmanv < man command & options >...\n\n" );
		return(1);
	}

	for( i=0; i<argc; i++ )
		if( argv[i] == 0 )
			break;
	strcpy( dfpath, argv[i - 1] );
	strcat( dfpath, ".man" );

	strcpy( syscmd, "man" );
	for( i=1; argv[i] != 0 ; i++ )
	{
		strcat( syscmd, " " );
		strcat( syscmd, argv[i] );
	}

	sfd = popen( syscmd, "r" );
	dfd = fopen( dfpath, "w+" );

	while( !feof(sfd) )
	{
		nread = fread( rbuf, 1, sizeof rbuf, sfd );
		nwrite=0;
		for( i=0; i<nread; )
		{
			switch( rbuf[i] )
			{
			case '\n' : 
				dbuf[nwrite++] = rbuf[i++];
				/* skip continuous LFs more than 2 */
				if( rbuf[i] != '\n' )
					continue;
				dbuf[nwrite++] = rbuf[i++];
				for( ; i<nread; i++ )
					if( rbuf[i] != '\n' )
						break;
				continue;
			case '_' :
				/* ESCape sequenct = '_'+0x08+char */
				if( rbuf[i+1] == 0x08 )
				{
					i+=2;
					dbuf[nwrite++] = rbuf[i++];
					continue;
				}
				else
				{
					dbuf[nwrite++] = rbuf[i++];
					continue;
				}
			case 0x08 :
				/* skip ESCape sequenct = 0x08+char */
				i+=2;
				continue;
			case '\t' :
				dbuf[nwrite++] = rbuf[i++];
				break;
			default :
				if(  rbuf[i]  < 0x20 )
				{
					i++;
					continue;
				}
				else
					dbuf[nwrite++] = rbuf[i++];
				break;
			}
		}
		fwrite( dbuf, 1, nwrite, dfd );
	}
	pclose( sfd );
	fclose( dfd );

	strcpy( syscmd, "vi " );
	strcat( syscmd, dfpath );
	system( syscmd );

	unlink( dfpath );

	return( 0 );
}
