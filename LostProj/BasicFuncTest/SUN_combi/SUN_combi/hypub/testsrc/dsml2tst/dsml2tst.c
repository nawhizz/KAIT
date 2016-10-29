/************************************************************************
*	DSML2 library testing program					*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
-----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>
#include	<iswrap.h>

#include	"cbuni.h"
#include	"gps.h"
#include	"pisam.h"
#include	"dsml.h"

/*----------------------------------------------------------------------+
|	External variables						|
+----------------------------------------------------------------------*/
int	dsml_fd = -1;

/*----------------------------------------------------------------------+
|	Function proto-types						|
+----------------------------------------------------------------------*/
void
TPI_TRAN()
{
	if( PI_TRAN() < 0 )
		printf( "PI_TRAN error(%d)\n", hyerrno );
	else
		printf( "PI_TRAN successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_COMMIT()
{
	PI_DCOMMIT();
	printf( "PI_DCOMMIT successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_ROLLBACK()
{
	PI_DROLLBACK();
	printf( "PI_DROLLBACK successful with iserrno=%d\n", iserrno );
}

/*---------------------------------------------------------------------*/
void
TPI_ENDTRAN()
{
	PI_ENDTRAN();
	printf( "PI_ENDTRAN successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_DBUILD()
{
	char	filepath[256];
	struct	BUILDFORM	inf;
	char	tmpstr[80];
	int	fd;

	if( dsml_fd >= 0 )
	{
		if( PI_DCLOSE( dsml_fd ) < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DBUILD( char *filepath(i),                    |\n" );
	printf( "|                 struct BUILDFORM *inf(i) )            |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath            : " );
	scanf( "%s", filepath );
	printf( "inf.maxvolsz (in M) : " );
	scanf( "%s", tmpstr );
	if( ( inf.maxvolsz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.maxvolsz\n" );
		return;
	}
	printf( "inf.blksz (in K)    : " );
	scanf( "%s", tmpstr );
	if( ( inf.blksz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.blksz\n" );
		return;
	}

	if( ( fd = PI_DBUILD( filepath, &inf ) ) < 0 )
	{
		printf( "PI_DBUILD error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DBUILD successful return fd (%d)\n", fd );
	dsml_fd = fd;

} /* TPI_DBUILD */

/*---------------------------------------------------------------------*/
void
TPI_DBUILD2()
{
	char	filepath[256];
	char	dirpath[128];
	struct	BUILDFORM	inf;
	char	tmpstr[80];
	int	fd;

	if( dsml_fd >= 0 )
	{
		if( PI_DCLOSE( dsml_fd ) < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DBUILD2( char *filepath(i),                   |\n" );
	printf( "|                 struct BUILDFORM *inf(i),             |\n" );
	printf( "|                 char dirpath )                        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath            : " );
	scanf( "%s", filepath );
	printf( "dirpath             : " );
	scanf( "%s", dirpath );
	printf( "inf.maxvolsz (in M) : " );
	scanf( "%s", tmpstr );
	if( ( inf.maxvolsz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.maxvolsz\n" );
		return;
	}
	printf( "inf.blksz (in K)    : " );
	scanf( "%s", tmpstr );
	if( ( inf.blksz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.blksz\n" );
		return;
	}

	if( ( fd = PI_DBUILD2( filepath, &inf, dirpath ) ) < 0 )
	{
		printf( "PI_DBUILD2 error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DBUILD2 successful return fd (%d)\n", fd );
	dsml_fd = fd;
}

/*---------------------------------------------------------------------*/

void
TPI_DCROPEN()
{
	char	filepath[256];
	struct	BUILDFORM	inf;
	char	tmpstr[80];
	int	fd;

	if( dsml_fd >= 0 )
	{
		if( PI_DCLOSE( dsml_fd ) < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DCROPEN( char *filepath(i),                   |\n" );
	printf( "|                 struct BUILDFORM *inf(i) )            |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath            : " );
	scanf( "%s", filepath );
	printf( "inf.maxvolsz (in M) : " );
	scanf( "%s", tmpstr );
	if( ( inf.maxvolsz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.maxvolsz\n" );
		return;
	}
	printf( "inf.blksz (in K)    : " );
	scanf( "%s", tmpstr );
	if( ( inf.blksz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.blksz\n" );
		return;
	}

	if( ( fd = PI_DCROPEN( filepath, &inf ) ) < 0 )
	{
		printf( "PI_DCROPEN error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DCROPEN successful return fd (%d)\n", fd );
	dsml_fd = fd;

} /* TPI_DCROPEN */

/*---------------------------------------------------------------------*/
void
TPI_DUOPEN()
{
	char	filepath[256];
	int	fd;

	if( dsml_fd >= 0 )
	{
		if( PI_DCLOSE( dsml_fd ) < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DUOPEN( char *filepath(i) )                   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath : " );
	scanf( "%s", filepath );

	if( ( fd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "PI_DUOPEN error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DUOPEN successful return fd (%d)\n", fd );
	dsml_fd = fd;

} /* TPI_DUOPEN */

/*---------------------------------------------------------------------*/
void
TPI_DOPEN()
{
	char	filepath[256];
	int	fd;

	if( dsml_fd >= 0 )
	{
		if( PI_DCLOSE( dsml_fd ) < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DOPEN( char *filepath(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath : " );
	scanf( "%s", filepath );

	if( ( fd = PI_DOPEN( filepath ) ) < 0 )
	{
		printf( "PI_DOPEN error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DOPEN successful return fd (%d)\n", fd );
	dsml_fd = fd;

} /* TPI_DOPEN */

/*---------------------------------------------------------------------*/
void
TPI_DCLOSE()
{
	if( dsml_fd >= 0 )
	{
		if( PI_DCLOSE( dsml_fd ) < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}
}

/*---------------------------------------------------------------------*/
void
TPI_DALLCLOSE()
{
	if( dsml_fd >= 0 )
	{
		if( PI_DALLCLOSE() < 0 )
			printf( " DSML closed with error(%d)\n", hyerrno );
		else
			printf( " DSML closed\n" );
		dsml_fd = -1;
	}
}

/*---------------------------------------------------------------------*/
void
TPI_DVADD()
{
	struct	VOLFORM	inf;
	char	tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DVADD( int dfd(i), struct VOLFORM *inf(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "inf.volpath         : " );
	scanf( "%s", inf.volpath );
	printf( "inf.maxvolsz (in M) : " );
	scanf( "%s", tmpstr );
	if( ( inf.maxvolsz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.maxvolsz\n" );
		return;
	}

	if( PI_DVADD( dsml_fd, &inf ) < 0 )
	{
		printf( "PI_DVADD error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DVADD successful\n" );

} /* TPI_DVADD */

/*---------------------------------------------------------------------*/
void
TPI_DVUPD()
{
	struct	VOLFORM	inf;
	char	tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DVUPD( int dfd(i), struct VOLFORM *inf(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "inf.volpath         : " );
	scanf( "%s", inf.volpath );
	printf( "inf.maxvolsz (in M) : " );
	scanf( "%s", tmpstr );
	if( ( inf.maxvolsz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.maxvolsz\n" );
		return;
	}

	if( PI_DVUPD( dsml_fd, &inf ) < 0 )
	{
		printf( "PI_DVADD error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DVUPD successful\n" );

} /* TPI_DVUPD */

/*---------------------------------------------------------------------*/
void
TPI_DVREN()
{
	char	svolpath[256];
	char	dvolpath[256];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DVREN( int dfd(i), char *svolpath(i),         |\n" );
	printf( "|                char *dvolpath(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "svolpath : " );
	scanf( "%s", svolpath );
	printf( "dvolpath : " );
	scanf( "%s", dvolpath );

	if( PI_DVREN( dsml_fd, svolpath, dvolpath ) < 0 )
	{
		printf( "PI_DVREN error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DVREN successful\n" );

} /* TPI_DVREN */

/*---------------------------------------------------------------------*/
void
TPI_DVDEL()
{
	char	volpath[256];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DVDEL( int dfd(i), char *volpath(i) )         |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "volpath : " );
	scanf( "%s", volpath );

	if( PI_DVDEL( dsml_fd, volpath ) < 0 )
	{
		printf( "PI_DVDEL error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DVDEL successful\n" );

}

/*---------------------------------------------------------------------*/
void
TPI_DHREAD()
{
	struct	DSMMFORM	inf;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DHREAD( int dfd(i), struct DSMMFORM *inf(o) ) |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( PI_DHREAD( dsml_fd, &inf ) < 0 )
	{
		printf( "PI_DHREAD error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DHREAD successful\n" );
	printf( "-------------------------------\n" );
	printf( "VERSION : %s\n", inf.version );
	printf( "blksz   : %d\n", inf.blksz );
	printf( "volcnt  : %d\n", inf.volcnt );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();

} /* TPI_DHREAD */

/*---------------------------------------------------------------------*/
void
TPI_DVREAD()
{
	struct	DSMVFORM	inf;
	int			volno;
	char			tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DVREAD( int dfd(i), int volno(i),             |\n" );
	printf( "|                 struct DSMVFORM *inf(o) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "volno : " );
	scanf( "%s", tmpstr );
	if( ( volno = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid volno\n" );
		return;
	}

	if( PI_DVREAD( dsml_fd, volno, &inf ) < 0 )
	{
		printf( "PI_DVREAD error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DVREAD successful\n" );
	printf( "-------------------------------\n" );
	printf( "doccnt       : %d\n", inf.doccnt );
	printf( "mindocid     : %d\n", inf.mindocid );
	printf( "maxdocid     : %d\n", inf.maxdocid );
	printf( "usedblkcnt   : %d\n", inf.usedblkcnt );
	printf( "reservblkcnt : %d\n", inf.reservblkcnt );
	printf( "volpath      : %s\n", inf.volpath );
	printf( "maxvolsz     : %dM\n", inf.maxvolsz );
	printf( "volgen       : %c\n", inf.volgen );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();

} /* TPI_DVREAD */

/*---------------------------------------------------------------------*/
void
TPI_ADDDOC()
{
	struct	DSMLFORM	inf;
	char			docpath[256];
	char			tmpstr[256];
	int			docid;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_ADDDOC( int dfd(i), int docid(o),             |\n" );
	printf( "|          char *docpath(i), struct DSMLFORM *inf(i) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docpath     : " );
	scanf( "%s", docpath );
	printf( "inf.title   : " );
	gets( tmpstr );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.title, tmpstr, sizeof inf.title );
	printf( "inf.fname   : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.fname, tmpstr, sizeof inf.fname );
	printf( "inf.type    : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.type, tmpstr, sizeof inf.type );
	printf( "inf.userinf : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.userinf, tmpstr, sizeof inf.userinf );
	printf( "inf.dst : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.dst, tmpstr, sizeof inf.dst );

	if( PI_ADDDOC( dsml_fd, &docid, docpath, &inf ) < 0 )
	{
		printf( "PI_ADDDOC error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_ADDDOC successful with docid(%d)\n", docid );

} /* TPI_ADDDOC */

/*---------------------------------------------------------------------*/
void
TPI_UPDDOC()
{
	struct	DSMLFORM	inf;
	char			docpath[256];
	char			tmpstr[256];
	int			docid;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_UPDDOC( int dfd(i), int docid(i),             |\n" );
	printf( "|          char *docpath(i), struct DSMLFORM *inf(i) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid       : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid docid\n" );
		return;
	}
	printf( "docpath     : " );
	gets( tmpstr );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( docpath, tmpstr, sizeof docpath );
	printf( "inf.title   : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.title, tmpstr, sizeof inf.title );
	printf( "inf.fname   : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.fname, tmpstr, sizeof inf.fname );
	printf( "inf.type    : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.type, tmpstr, sizeof inf.type );
	printf( "inf.userinf : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.userinf, tmpstr, sizeof inf.userinf );
	printf( "inf.dst : " );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( inf.dst, tmpstr, sizeof inf.dst );

	if( PI_UPDDOC( dsml_fd, docid, docpath, &inf ) < 0 )
	{
		printf( "PI_UPDDOC error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_UPDDOC successful\n" );

} /* TPI_UPDDOC */

/*---------------------------------------------------------------------*/
void
TPI_DELDOC()
{
	int	docid;
	char	tmpstr[256];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DELDOC( int dfd(i), int docid(i) )            |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid docid\n" );
		return;
	}

	if( PI_DELDOC( dsml_fd, docid ) < 0 )
	{
		printf( "PI_DELDOC error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DELDOC successful\n" );

} /* TPI_DELDOC */

/*---------------------------------------------------------------------*/
void
TPI_REDDOC()
{
	char	docpath[256];
	int	docid;
	char	tmpstr[256];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_REDDOC( int dfd(i), int docid(i),             |\n" );
	printf( "|                 char *docpath(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid       : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid docid\n" );
		return;
	}
	printf( "docpath     : " );
	gets( tmpstr );
	memset( tmpstr, 0, sizeof tmpstr );
	gets( tmpstr );
	memcpy( docpath, tmpstr, sizeof docpath );

	if( PI_REDDOC( dsml_fd, docid, docpath ) < 0 )
	{
		printf( "PI_REDDOC error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_REDDOC successful\n" );

} /* TPI_REDDOC */

/*---------------------------------------------------------------------*/
void
TPI_DIFIRST()
{
	struct	DSMIFORM	inf;
	int			docid;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DIFIRST( int dfd(i), int *docid(o),           |\n" );
	printf( "|                 struct DSMIFORM *inf(o) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( PI_DIFIRST( dsml_fd, &docid, &inf ) < 0 )
	{
		printf( "PI_DIFIRST error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DIFIRST successful\n" );
	printf( "-------------------------------\n" );
	printf( "docid   : %d\n", docid );
	printf( "size    : %d\n", inf.size );
	printf( "atime   : %d\n", inf.atime );
	printf( "utime   : %d\n", inf.utime );
	printf( "title   : %.*s\n", sizeof inf.title, inf.title );
	printf( "fname   : %.*s\n", sizeof inf.fname, inf.fname );
	printf( "type    : %.*s\n", sizeof inf.type, inf.type );
	printf( "userinf : %.*s\n", sizeof inf.userinf, inf.userinf );
	printf( "dst     : %.*s\n", sizeof inf.dst, inf.dst );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();
	
} /* TPI_DIFIRST */

/*---------------------------------------------------------------------*/
void
TPI_DILAST()
{
	struct	DSMIFORM	inf;
	int			docid;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DILAST( int dfd(i), int *docid(o),            |\n" );
	printf( "|                 struct DSMIFORM *inf(o) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( PI_DILAST( dsml_fd, &docid, &inf ) < 0 )
	{
		printf( "PI_DILAST error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DILAST successful\n" );
	printf( "-------------------------------\n" );
	printf( "docid   : %d\n", docid );
	printf( "size    : %d\n", inf.size );
	printf( "atime   : %d\n", inf.atime );
	printf( "utime   : %d\n", inf.utime );
	printf( "title   : %.*s\n", sizeof inf.title, inf.title );
	printf( "fname   : %.*s\n", sizeof inf.fname, inf.fname );
	printf( "type    : %.*s\n", sizeof inf.type, inf.type );
	printf( "userinf : %.*s\n", sizeof inf.userinf, inf.userinf );
	printf( "dst     : %.*s\n", sizeof inf.dst, inf.dst );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();
	
} /* TPI_DILAST */

/*---------------------------------------------------------------------*/
void
TPI_DINEXT()
{
	struct	DSMIFORM	inf;
	int			docid;
	char			tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DINEXT( int dfd(i), int *docid(io),           |\n" );
	printf( "|                 struct DSMIFORM *inf(o) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid docid\n" );
		return;
	}

	if( PI_DINEXT( dsml_fd, &docid, &inf ) < 0 )
	{
		printf( "PI_DINEXT error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DINEXT successful\n" );
	printf( "-------------------------------\n" );
	printf( "docid   : %d\n", docid );
	printf( "size    : %d\n", inf.size );
	printf( "atime   : %d\n", inf.atime );
	printf( "utime   : %d\n", inf.utime );
	printf( "title   : %.*s\n", sizeof inf.title, inf.title );
	printf( "fname   : %.*s\n", sizeof inf.fname, inf.fname );
	printf( "type    : %.*s\n", sizeof inf.type, inf.type );
	printf( "userinf : %.*s\n", sizeof inf.userinf, inf.userinf );
	printf( "dst     : %.*s\n", sizeof inf.dst, inf.dst );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();
	
} /* TPI_DINEXT */

/*---------------------------------------------------------------------*/
void
TPI_DIPREV()
{
	struct	DSMIFORM	inf;
	int			docid;
	char			tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DIPREV( int dfd(i), int *docid(io),           |\n" );
	printf( "|                 struct DSMIFORM *inf(o) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid docid\n" );
		return;
	}

	if( PI_DIPREV( dsml_fd, &docid, &inf ) < 0 )
	{
		printf( "PI_DIPREV error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DIPREV successful\n" );
	printf( "-------------------------------\n" );
	printf( "docid   : %d\n", docid );
	printf( "size    : %d\n", inf.size );
	printf( "atime   : %d\n", inf.atime );
	printf( "utime   : %d\n", inf.utime );
	printf( "title   : %.*s\n", sizeof inf.title, inf.title );
	printf( "fname   : %.*s\n", sizeof inf.fname, inf.fname );
	printf( "type    : %.*s\n", sizeof inf.type, inf.type );
	printf( "userinf : %.*s\n", sizeof inf.userinf, inf.userinf );
	printf( "dst     : %.*s\n", sizeof inf.dst, inf.dst );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();
	
} /* TPI_DIPREV */

/*---------------------------------------------------------------------*/
void
TPI_DIREAD()
{
	struct	DSMIFORM	inf;
	int			docid;
	char			tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DIREAD( int dfd(i), int *docid(i),            |\n" );
	printf( "|                 struct DSMIFORM *inf(o) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid docid\n" );
		return;
	}

	if( PI_DIREAD( dsml_fd, &docid, &inf ) < 0 )
	{
		printf( "PI_DIREAD error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DIREAD successful\n" );
	printf( "-------------------------------\n" );
	printf( "docid   : %d\n", docid );
	printf( "size    : %d\n", inf.size );
	printf( "atime   : %d\n", inf.atime );
	printf( "utime   : %d\n", inf.utime );
	printf( "title   : %.*s\n", sizeof inf.title, inf.title );
	printf( "fname   : %.*s\n", sizeof inf.fname, inf.fname );
	printf( "type    : %.*s\n", sizeof inf.type, inf.type );
	printf( "userinf : %.*s\n", sizeof inf.userinf, inf.userinf );
	printf( "dst     : %.*s\n", sizeof inf.dst, inf.dst );
	printf( "-- Press any key --------------\n" );
	getchar();
	getchar();
	
} /* TPI_DIREAD */

/*---------------------------------------------------------------------*/
void
TPI_DHCHK()
{
	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DHCHK( int dfd(i) )                           |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( PI_DHCHK( dsml_fd ) < 0 )
	{
		printf( "PI_DHCHK error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DHCHK successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_DVCHK()
{
	int	volno;
	char	tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DVCHK( int dfd(i), int volno(i) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "volno : " );
	scanf( "%s", tmpstr );
	if( ( volno = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid volno\n" );
		return;
	}

	if( PI_DVCHK( dsml_fd, volno ) < 0 )
	{
		printf( "PI_DVCHK error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DVCHK successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_DDCHK()
{
	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DDCHK( int dfd(i) )                           |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( PI_DDCHK( dsml_fd ) < 0 )
	{
		printf( "PI_DDCHK error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DDCHK successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_DICHK()
{
	int	docid;
	char	tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DICHK( int dfd(i), int docid(i) )             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "docid : " );
	scanf( "%s", tmpstr );
	if( ( docid = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid docid\n" );
		return;
	}

	if( PI_DICHK( dsml_fd, docid ) < 0 )
	{
		printf( "PI_DICHK error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DICHK successful\n" );
}

/*---------------------------------------------------------------------*/
void
TPI_DCONV()
{
	char			v1file[256];
	char			v2file[256];
	struct	BUILDFORM	inf;
	char			tmpstr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_DCONV( char *v1file(i), char *v2file(i),      |\n" );
	printf( "|                struct BUILDFORM *build_inf(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "v1file              : " );
	scanf( "%s", v1file );
	printf( "v2file              : " );
	scanf( "%s", v2file );
	printf( "inf.maxvolsz (in M) : " );
	scanf( "%s", tmpstr );
	if( ( inf.maxvolsz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.maxvolsz\n" );
		return;
	}
	printf( "inf.blksz (in K)    : " );
	scanf( "%s", tmpstr );
	if( ( inf.blksz = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid inf.blksz\n" );
		return;
	}

	if( PI_DCONV( v1file, v2file, &inf ) < 0 )
	{
		printf( "PI_DCONV error (%d)\n", hyerrno );
		return;
	}

	printf( "PI_DCONV successful\n" );
}

/*----------------------------------------------------------------------+
|	Display functions						|
+----------------------------------------------------------------------*/
void
DisplayFunctions()
{
	printf( "\n" );
	printf( "*********************************************************\n" );
	printf( "*       DSML2 library test program                      *\n" );
	printf( "*********************************************************\n" );
	printf( "\n" );
	printf( "  1. PI_TRAN    2. PI_DCOMMIT   3. PI_DROLLBACK\n" );
	printf( "  4. PI_ENDTRAN\n" );
	printf( "*********************************************************\n" );
	printf( " 11. PI_DBUILD 12. PI_DCROPEN 13. PI_DUOPEN\n" );
	printf( " 14. PI_DOPEN  15. PI_DCLOSE  16. PI_DALLCLOSE\n" );
	printf( " 17. PI_DVADD  18. PI_DVUPD   19. PI_DVREN\n" );
	printf( " 20. PI_DVDEL  21. PI_DHREAD  22. PI_DVREAD\n" );
	printf( " 23. PI_ADDDOC 24. PI_UPDDOC  25. PI_DELDOC\n" );
	printf( " 26. PI_REDDOC 27. PI_DIFIRST 28. PI_DILAST\n" );
	printf( " 29. PI_DINEXT 30. PI_DIPREV  31. PI_DIREAD\n" );
	printf( " 32. PI_DHCHK  33. PI_DVCHK   34. PI_DDCHK\n" );
	printf( " 35. PI_DICHK  36. PI_DCONV   37. PI_DBUILD2\n" );
	printf( "*********************************************************\n" );
	printf( " 99. Exit\n" );
	printf( "\n" );
	printf( "*********************************************************\n" );
	printf( "\n" );

} /* DisplayFunctions */

/*----------------------------------------------------------------------+
|	Choose function							|
+----------------------------------------------------------------------*/
int
ChooseFunctions()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 99 &&
	       ( choosenum < 1 || choosenum > 4 ) &&
	       ( choosenum < 11 || choosenum > 37 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseFunctions */

/*----------------------------------------------------------------------+
|	Main function							|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
main( int argc, char argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	for( ; ; )
	{
		DisplayFunctions();
		switch( ChooseFunctions() )
		{
		case	 1	:	TPI_TRAN();		break;
		case	 2	:	TPI_COMMIT();		break;
		case	 3	:	TPI_ROLLBACK();		break;
		case	 4	:	TPI_ENDTRAN();		break;
		case	11	:	TPI_DBUILD();		break;
		case	12	:	TPI_DCROPEN();		break;
		case	13	:	TPI_DUOPEN();		break;
		case	14	:	TPI_DOPEN();		break;
		case	15	:	TPI_DCLOSE();		break;
		case	16	:	TPI_DALLCLOSE();	break;
		case	17	:	TPI_DVADD();		break;
		case	18	:	TPI_DVUPD();		break;
		case	19	:	TPI_DVREN();		break;
		case	20	:	TPI_DVDEL();		break;
		case	21	:	TPI_DHREAD();		break;
		case	22	:	TPI_DVREAD();		break;
		case	23	:	TPI_ADDDOC();		break;
		case	24	:	TPI_UPDDOC();		break;
		case	25	:	TPI_DELDOC();		break;
		case	26	:	TPI_REDDOC();		break;
		case	27	:	TPI_DIFIRST();		break;
		case	28	:	TPI_DILAST();		break;
		case	29	:	TPI_DINEXT();		break;
		case	30	:	TPI_DIPREV();		break;
		case	31	:	TPI_DIREAD();		break;
		case	32	:	TPI_DHCHK();		break;
		case	33	:	TPI_DVCHK();		break;
		case	34	:	TPI_DDCHK();		break;
		case	35	:	TPI_DICHK();		break;
		case	36	:	TPI_DCONV();		break;
		case	37	:	TPI_DBUILD2();		break;
		case	99	:	TPI_DALLCLOSE();	
					TPI_ROLLBACK();
					TPI_ENDTRAN();
					return;
		}
	}
}
