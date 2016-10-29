/*---------------------------------------------------------------------------*/
/*	입력받은 날짜 이후 파일 가져오기				     */
/*---------------------------------------------------------------------------*/
#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<dirent.h>
#include	<time.h>
#include	<errno.h>

static	int	l_dispfile( char *date, char *dir );

main(int argc, char *argv[])
{
	setbuf( stdout, 0 );

	if( argc != 3 )
	{
		printf( "-------------------------------\n" );
		printf( "argument error\n" );
		printf( "arg. is [date(YYYYMMDD)] [source dir]\n" );
		exit(1);
	}

	l_dispfile( argv[1], argv[2] );
}

static	int	l_dispfile( char *date, char *dir )
{
	DIR	*dirp;
	struct	dirent	*dp;
	struct	stat	sts;
	struct	tm	*tm;
	int	dirlen;
	char	tmpdir[256], tmpfile[256], filedate[9];

	dirp = opendir( dir );
	if( !dirp )
	{
		printf( "%s is not directory (errno=%d)\n", dir, errno );
		return( -1 );
	}

	strcpy( tmpfile, dir );
	dirlen = strlen( dir );

	while( 1 )
	{
		dp = readdir( dirp );
		if( !dp )	break;
		if( dp->d_name[0] == '.' )
		{
			if( dp->d_name[1] == 0 )
				continue;
			if( dp->d_name[1] == '.' && dp->d_name[2] == 0 )
				continue;
		}
		tmpfile[dirlen] = 0;
		strcat( tmpfile, "/" );
		strcat( tmpfile, dp->d_name );
		if( stat( tmpfile, &sts ) == -1 )
		{
			printf( "%s get status error\n" );
			continue;
		}
		if( S_ISDIR( sts.st_mode ) )
		{
			if( l_dispfile( date, tmpfile ) < 0 )
				return( -1 );
			continue;
		}
		tm = localtime( &sts.st_mtime );
		sprintf( filedate, "%04d%02d%02d",
			tm->tm_year+1900, tm->tm_mon + 1, tm->tm_mday );
		if( strcmp( date, filedate ) <= 0 )
			printf( "%-60s is %s\n", tmpfile, filedate );
	}

	closedir( dirp );
}
