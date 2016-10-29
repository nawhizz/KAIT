/************************************************************************
*	DSML Administrator Tool						*
************************************************************************/

#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<time.h>

#ifdef	WIN32
#include	<io.h>
#ifndef	F_OK
#define	F_OK	0
#define	W_OK	1
#endif
#else
#include	<unistd.h>
#endif

#include	<errno.h>

#include	"cbuni.h"
#include	"gps.h"
#include	"pisam.h"
#include	"dsml.h"

/*----------------------------------------------------------------------+
|	Define	constants						|
+----------------------------------------------------------------------*/
#define	MAX_ID_GROUPS	256
/*----------------------------------------------------------------------+
|	External variables						|
+----------------------------------------------------------------------*/
struct	ids_tag	{
	int	fr_id;
	int	to_id;
	int	id_fl;	/* 0:docid 1:volid 2:all */
}	ids[MAX_ID_GROUPS];

int	stdout_fl=1;

/*----------------------------------------------------------------------+
|	check string is space or null					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
l_isspaceornull( char *s, int n )
#else
l_isspaceornull( s, n )
char	*s;
int	n;
#endif
{
	register	i;

	for( i=0; i<n && s[i]; i++ )
		if( s[i] != ' ' )
			return( 0 );

	return( 1 );
}

/*----------------------------------------------------------------------+
|	Convert V1 to V2						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_1to2( char *file2path, int volsize, int blksize, char *file1path )
#else
ds_1to2( file2path, volsize, blksize, file1path )
char	*file2path;
int	volsize;
int	blksize;
char	*file1path;
#endif
{
	struct	BUILDFORM	inf;

	inf.maxvolsz = volsize;
	inf.blksz = blksize;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d).\n",
								hyerrno );
		return( EIO );
	}

	if( file1path != (char *)0 )
	{
		if( PI_DCONV( file1path, file2path, &inf ) < 0 )
		{
			printf( "Transfer error with errno(%d).\n", hyerrno );
			PI_ROLLBACK();
			PI_ENDTRAN();
			return( ENOENT );
		}

		printf( "Data transfer from V1 to V2 complete.\n" );
	}
	else
	{
		if( PI_DBUILD( file2path, &inf ) < 0 )
		{
			printf( "Build error with errno(%d).\n", hyerrno );
			PI_ROLLBACK();
			PI_ENDTRAN();
			return( ENOENT );
		}
		printf( "Build successfull.\n" );
	}

	PI_COMMIT();
	PI_ENDTRAN();

	return( 0 );

} /* ds_1to2 */

/*----------------------------------------------------------------------+
|	add a volume							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_vol_add( char *filepath, char *volpath, int volsize )
#else
ds_vol_add( filepath, volpath, volsize )
char	*filepath;
char	*volpath;
int	volsize;
#endif
{
	int		dsfd;
	struct	VOLFORM	vol_inf;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	strcpy( vol_inf.volpath, filepath );
	vol_inf.maxvolsz = volsize;

	if( PI_DVADD( dsfd, &vol_inf ) < 0 )
	{
		printf( "Volume information add error with errno(%d).\n",
								hyerrno );
		PI_DCLOSE( dsfd );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();

	printf( "Volume information add complete.\n" );

	return( 0 );

} /* ds_vol_add */

/*----------------------------------------------------------------------+
|	delete a volume							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_vol_del( char *filepath, char *volpath )
#else
ds_vol_del( filepath, volpath )
char	*filepath;
char	*volpath;
#endif
{
	int	dsfd;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_DVDEL( dsfd, volpath ) < 0 )
	{
		printf( "Volume delete error with errno(%d).\n", hyerrno );
		PI_DCLOSE( dsfd );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();

	printf( "Volume delete complete.\n" );

	return( 0 );

} /* ds_vol_del */

/*----------------------------------------------------------------------+
|	rename a volume							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_vol_ren( char *filepath, char *fromvolpath, char *tovolpath )
#else
ds_vol_ren( filepath, fromvolpath, tovolpath )
char	*filepath;
char	*fromvolpath;
char	*tovolpath;
#endif
{
	int	dsfd;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_DVREN( dsfd, fromvolpath, tovolpath ) < 0 )
	{
		printf( "Volume rename error with errno(%d).\n", hyerrno );
		PI_DCLOSE( dsfd );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();

	printf( "Volume rename complete.\n" );

	return( 0 );

} /* ds_vol_ren */

/*----------------------------------------------------------------------+
|	update information of volume					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_vol_upd( char *filepath, char *volpath, int volsize )
#else
ds_vol_upd( filepath, volpath, volsize )
char	*filepath;
char	*volpath;
int	volsize;
#endif
{
	int		dsfd;
	struct	VOLFORM	vol_inf;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	strcpy( vol_inf.volpath, filepath );
	vol_inf.maxvolsz = volsize;

	if( PI_DVUPD( dsfd, &vol_inf ) < 0 )
	{
		printf( "Volume information update error with errno(%d).\n",
								hyerrno );
		PI_DCLOSE( dsfd );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();

	printf( "Volume information update complete.\n" );

	return( 0 );

} /* ds_vol_upd */

/*----------------------------------------------------------------------+
|	View information of volumes					|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
ds_vol_view( int dsfd )
#else
ds_vol_view( dsfd )
int	dsfd;
#endif
{
	register		i;
	struct	DSMMFORM	dm;
	struct	DSMVFORM	dv;

	if( PI_DHREAD( dsfd, &dm ) < 0 )
		return;

	printf( "Version      : %-.*s\n", sizeof dm.version, dm.version );
	printf( "Block size   : %d Kbytes\n", dm.blksz );
	printf( "Volume count : %d\n", dm.volcnt );
	printf( "-----------------------------------------\n" );

	for( i=0; i<dm.volcnt; i++ )
	{
		if( PI_DVREAD( dsfd, i, &dv ) < 0 )
		{
			printf(
		"Volume(volno=%d) information read error with errno(%d).\n",
								i, hyerrno );
			continue;
		}

		printf( "Volume number        : %d\n", i );
		printf( "Document count       : %d\n", dv.doccnt );
		printf( "Minimum document ID  : %d\n", dv.mindocid );
		printf( "Maximum document ID  : %d\n", dv.maxdocid );
		printf( "Used block count     : %d\n", dv.usedblkcnt );
		printf( "Unused block count   : %d\n", dv.reservblkcnt );
		printf( "Volume path          : %s\n", dv.volpath );
		printf( "Volume size          : %d Mbytes\n", dv.maxvolsz );
		printf( "Volume generate flag : %c\n", dv.volgen );
		printf( "-------------------------------------------------\n" );
	}

	return;

} /* ds_vol_view */

/*----------------------------------------------------------------------+
|	View information of all documents				|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_di_all( char *filepath )
#else
ds_di_all( filepath )
char	*filepath;
#endif
{
	register		idix;
	int			docid;
	int			frdoc;
	int			todoc;
	int			dsfd;
	struct	DSMIFORM	di;
	struct	DSMVFORM	dv;
	int			okcnt = 0;

	if( ( dsfd = PI_DOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		return( ENOENT );
	}

	if( ids[0].id_fl == 2 )
	{
		ids[0].fr_id = 1;
		ids[0].to_id = 100000000;
		ids[0].id_fl = 0;
	}

	for( idix=0; ; idix++ )
	{
		if( !ids[idix].fr_id && !ids[idix].to_id && !ids[idix].id_fl )
			break;

		if( ids[idix].id_fl )
		{
			if( ids[idix].fr_id > ids[idix].to_id )
				continue;

			if( PI_DVREAD( dsfd, ids[idix].fr_id, &dv ) < 0 )
			{
				printf( "Read error(%d) information", hyerrno );
				printf( " of volume number(%d).\n",
							ids[idix].fr_id );
				break;
			}

			printf( "Volume number        : %d\n",
							ids[idix].fr_id );
			printf( "Document count       : %d\n", dv.doccnt );
			printf( "Minimum document ID  : %d\n", dv.mindocid );
			printf( "Maximum document ID  : %d\n", dv.maxdocid );
			printf( "Used block count     : %d\n", dv.usedblkcnt );
			printf( "Unused block count   : %d\n",
							dv.reservblkcnt );
			printf( "Volume path          : %s\n", dv.volpath );
			printf( "Volume size          : %d Mbytes\n",
							dv.maxvolsz );
			printf( "Volume generate flag : %c\n", dv.volgen );
			printf( "-----------------------------------------\n" );

			ids[idix].fr_id ++;
			idix--;

			if( dv.doccnt <= 0 )
				continue;

			frdoc = dv.mindocid - 1;
			todoc = dv.maxdocid;
		}
		else
		{
			frdoc = ids[idix].fr_id - 1;
			todoc = ids[idix].to_id;
		}

		for( docid=frdoc; ; )
		{
			if( PI_DINEXT( dsfd, &docid, &di ) < 0 ||
			    docid > todoc )
			{
				break;
			}

			okcnt++;

			printf( "docid   : %d\n", docid );
			printf( "size    : %d\n", di.size );
			printf( "atime   : %s", ctime( (time_t *)&di.atime ) );
			if( di.utime )
			{
				printf( "utime   : %s",
						ctime( (time_t *)&di.utime ) );
			}
			if( !l_isspaceornull( di.title, sizeof di.title ) )
			{
				printf( "title   : %.*s\n", sizeof di.title,
								di.title );
			}
			if( !l_isspaceornull( di.fname, sizeof di.fname ) )
			{
				printf( "fname   : %.*s\n", sizeof di.fname,
								di.fname );
			}
			if( !l_isspaceornull( di.type, sizeof di.type ) )
			{
				printf( "type    : %.*s\n", sizeof di.type,
								di.type );
			}
			if( !l_isspaceornull( di.userinf, sizeof di.userinf ) )
			{
				printf( "userinf : %.*s\n", sizeof di.userinf,
								di.userinf );
			}
			printf( "-----------------------------------------\n" );
		}
	}

	if( ids[0].id_fl == 0 &&
	    ids[0].fr_id == 1 && ids[0].to_id == 100000000 )
	{
		printf( "document total count is %d\n", okcnt );
		printf( "last document id     is %d\n", docid );
		printf( "-----------------------------------------\n" );

		ds_vol_view( dsfd );
	}

	PI_DCLOSE( dsfd );

	return( 0 );

} /* ds_di_all */

int
#if	defined( __CB_STDC__ )
ds_delete_doc( char *filepath )
#else
ds_delete_doc( filepath )
char	*filepath;
#endif
{
	register		idix;
	int			docid;
	int			frdoc;
	int			todoc;
	int			dsfd;
	struct	DSMIFORM	di;
	struct	DSMVFORM	dv;
	int			okcnt = 0;

	if( ids[0].id_fl == 2 )
	{
		printf( "Input Document Id or Volume Number.\n" );
		return( ENOENT );
	}

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	for( idix=0; ; idix++ )
	{
		if( !ids[idix].fr_id && !ids[idix].to_id && !ids[idix].id_fl )
			break;

		if( ids[idix].id_fl )
		{
			if( ids[idix].fr_id > ids[idix].to_id )
				continue;

			if( PI_DVREAD( dsfd, ids[idix].fr_id, &dv ) < 0 )
			{
				printf( "Read error(%d) information", hyerrno );
				printf( " of volume number(%d).\n",
							ids[idix].fr_id );
				break;
			}

			ids[idix].fr_id ++;
			idix--;

			if( dv.doccnt <= 0 )
				continue;

			frdoc = dv.mindocid - 1;
			todoc = dv.maxdocid;
		}
		else
		{
			frdoc = ids[idix].fr_id - 1;
			todoc = ids[idix].to_id;
		}

		for( docid=frdoc; ; )
		{
			if( PI_DINEXT( dsfd, &docid, &di ) < 0 ||
			    docid > todoc )
			{
				break;
			}

			okcnt++;

			if( PI_DELDOC( dsfd, docid ) < 0 )
			{
				printf(
				"Delete error document(%d) with errno(%d).\n", 
						docid, hyerrno );
				PI_ROLLBACK();
				PI_ENDTRAN();
				return( ENOENT );
			}
		}
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();
	printf( "Document delete complete.\n" );

	return( 0 );

}

/*----------------------------------------------------------------------+
|	Check volume information					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_check_volume( int dsfd, int frvol, int tovol )
#else
ds_check_volume( dsfd, frvol, tovol )
int	dsfd;
int	frvol;
int	tovol;
#endif
{
	register	volix;

	for( volix=frvol; volix<=tovol; volix++ )
	{
		if( PI_DVCHK( dsfd, volix ) < 0 )
		{
			printf( "Volume information recovery error " );
			printf( "with errno(%d).\n", hyerrno );
			return( -1 );
		}
	}

	printf( "Volume information recovery complete.\n" );

	return( 0 );

} /* ds_check_volume */

/*----------------------------------------------------------------------+
|	Check delete block						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_check_delete( int dsfd )
#else
ds_check_delete( dsfd )
int	dsfd;
#endif
{
	if( PI_DDCHK( dsfd ) < 0 )
	{
		printf( "Delete page recovery error with errno(%d)\n",
								hyerrno );
		return( -1 );
	}

	printf( "Delete page recovery complete.\n" );

	return( 0 );

} /* ds_check_delete */

/*----------------------------------------------------------------------+
|	Check size information of document				|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_check_fsize( int dsfd, int frdoc, int todoc )
#else
ds_check_fsize( dsfd, frdoc, todoc )
int	dsfd;
int	frdoc;
int	todoc;
#endif
{
#ifdef	PENDING
	int			docid;
	struct	DSMIFORM	di;

	for( docid=frdoc; ; )
	{
		if( PI_DINEXT( dsfd, &docid, &di ) < 0 || docid > todoc )
			break;

		if( PI_DICHK( dsfd, docid ) < 0 )
		{
			printf( "Document information recovery error " );
			printf( "with errno(%d).\n", hyerrno );
			return( -1 );
		}
		;
	}

	printf( "Document information recovery complete.\n" );

#endif
	return( 0 );

} /* ds_check_fsize */

/*----------------------------------------------------------------------+
|	Check with all options						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_check_all( char *filepath )
#else
ds_check_all( filepath )
char	*filepath;
#endif
{
	int			idix;
	int			dsfd;
	int			frdoc;
	int			todoc;
	int			frvol;
	int			tovol;
	int			version;
	struct	DSMMFORM	dm;
	struct	DSMVFORM	dv;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_DHREAD( dsfd, &dm ) < 0 )
	{
		if( hyerrno != EDS_EARLY_VERSION )
		{
			printf( "Volume head read error with errno(%d).\n",
								hyerrno );
			PI_DCLOSE( dsfd );
			PI_ROLLBACK();
			PI_ENDTRAN();
			return( ENOENT );
		}
		version = 1;
	}
	else
		version = 2;

	if( ids[0].id_fl == 2 )
	{
		if( ds_check_fsize( dsfd, 1, 100000000 ) < 0 )
		{
			PI_DCLOSE( dsfd );
			PI_ROLLBACK();
			PI_ENDTRAN();
			return( EINVAL );
		}

		if( ds_check_delete( dsfd ) < 0 )
		{
			PI_DCLOSE( dsfd );
			PI_ROLLBACK();
			PI_ENDTRAN();
			printf( "All fixed jobs are rolling back.\n" );
			return( EINVAL );
		}

		if( version == 2 )
		{
			if( ds_check_volume( dsfd, 0, dm.volcnt - 1 ) < 0 )
			{
				PI_DCLOSE( dsfd );
				PI_ROLLBACK();
				PI_ENDTRAN();
				printf( "All fixed jobs are rolling back.\n" );
				return( EINVAL );
			}

			if( PI_DHCHK( dsfd ) < 0 )
			{
				printf(
			"Master information recovery error with errno(%d).\n",
								hyerrno );
				printf( "All fixed jobs are rolling back.\n" );
				PI_DCLOSE( dsfd );
				PI_ROLLBACK();
				PI_ENDTRAN();
				return( EINVAL );
			}
			printf( "Master information recovery complete.\n" );
		}
	}

	for( idix=0; ids[0].id_fl!=2; idix++ )
	{
		if( !ids[idix].fr_id && !ids[idix].to_id && !ids[idix].id_fl )
			break;

		if( ids[idix].id_fl > 0 )
		{
			if( ids[idix].id_fl == 1 )
			{
				frvol = ids[idix].fr_id;
				tovol = ids[idix].to_id;
				if( tovol >= dm.volcnt )
				{
					tovol = dm.volcnt - 1;
					ids[idix].to_id = dm.volcnt - 1;
				}

				ids[idix].id_fl = 3;
			}

			if( ids[idix].fr_id > ids[idix].to_id )
			{
				if( ds_check_volume( dsfd, frvol, tovol ) < 0 )
				{
					PI_DCLOSE( dsfd );
					PI_ROLLBACK();
					PI_ENDTRAN();
					printf( "All fixed jobs are " );
					printf( "rolling back.\n" );
					return( EINVAL );
				}
				continue;
			}

			if( PI_DVREAD( dsfd, ids[idix].fr_id, &dv ) < 0 )
			{
				printf( "Read error(%d) information", hyerrno );
				printf( " of volume number(%d).\n",
							ids[idix].fr_id );
				break;
			}

			ids[idix].fr_id ++;
			idix--;

			if( dv.doccnt <= 0 )
				continue;

			frdoc = dv.mindocid - 1;
			todoc = dv.maxdocid;
		}
		else
		{
			frdoc = ids[idix].fr_id - 1;
			todoc = ids[idix].to_id;
		}

		if( ds_check_fsize( dsfd, frdoc, todoc ) < 0 )
		{
			PI_DCLOSE( dsfd );
			PI_ROLLBACK();
			PI_ENDTRAN();
			printf( "All fixed jobs are rolling back.\n" );
			return( EINVAL );
		}
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();
	printf( "All fixed jobs are successful.\n" );

	return( 0 );

} /* ds_check_all */

/*----------------------------------------------------------------------+
|	Backup								|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_backup( char *filepath, char *tg_dir )
#else
ds_backup( filepath, tg_dir )
char	*filepath;
char	*tg_dir;
#endif
{
	register		idix;
	int			docid;
	int			frdoc;
	int			todoc;
	int			dsfd;
	struct	DSMIFORM	di;
	struct	DSMVFORM	dv;
	char			samfile[256];
	char			inffile[256];
	char			docfile[sizeof di.fname + 1];
	int			errcnt = 0;
	int			okcnt = 0;
	FILE			*ifd;

	if( ( dsfd = PI_DOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		return( ENOENT );
	}

	strcpy( inffile, tg_dir );
	strcat( inffile, "/" );
	strcat( inffile, "dsmback.inf" );
	ifd = fopen( inffile, "ab" );

	if( ifd != (FILE *)0 )
	{
		time_t	tm;

		time( &tm );
		fprintf( ifd, "#\n" );
		fprintf( ifd, "#Backup from %s at %s", filepath, ctime( &tm ) );
		fprintf( ifd, "#\n" );
	}

	if( ids[0].id_fl == 2 )
	{
		ids[0].fr_id = 1;
		ids[0].to_id = 100000000;
		ids[0].id_fl = 0;
	}

	for( idix=0; ; idix++ )
	{
		if( !ids[idix].fr_id && !ids[idix].to_id && !ids[idix].id_fl )
			break;

		if( ids[idix].id_fl )
		{
			if( ids[idix].fr_id > ids[idix].to_id )
				continue;

			if( PI_DVREAD( dsfd, ids[idix].fr_id, &dv ) < 0 )
			{
				printf( "Read error(%d) information", hyerrno );
				printf( " of volume number(%d).\n",
							ids[idix].fr_id );
				break;
			}

			ids[idix].fr_id ++;
			idix--;

			if( dv.doccnt <= 0 )
				continue;

			frdoc = dv.mindocid - 1;
			todoc = dv.maxdocid;
		}
		else
		{
			frdoc = ids[idix].fr_id - 1;
			todoc = ids[idix].to_id;
		}

		for( docid=frdoc; ; )
		{
			if( PI_DINEXT( dsfd, &docid, &di ) < 0 ||
			    docid > todoc )
			{
				break;
			}

			d_mkstr( di.fname, sizeof di.fname, docfile);
			strcpy( samfile, tg_dir );
			strcat( samfile, "/" );
			strcat( samfile, docfile );
			if( docfile[0] == (char)0 || !access( samfile, F_OK ) )
			{
				sprintf( docfile, "%08d.", docid );
				if( di.type[0] != ' ' )
				{
					docfile[9] = di.type[0];
					if( di.type[1] != ' ' )
					{
						docfile[10] = di.type[1];
						docfile[11] = 0;
					}
					else
						docfile[10] = 0;
				}
				else
					strcat( docfile, "dsm" );

				strcpy( samfile, tg_dir );
				strcat( samfile, "/" );
				strcat( samfile, docfile );
			}

			if( PI_REDDOC( dsfd, docid, samfile ) < 0 )
			{
				printf(
				"Read error doc of docid(%d) with errno(%d).\n",
							docid, hyerrno );
				errcnt++;
			}
			else
			{
				okcnt++;
				if( ifd != (FILE *)0 )
				{
					fprintf( ifd, "[ %d ]\n", docid );
					fprintf( ifd, " Backup file name : " );
					fprintf( ifd, "%s\n", docfile );
					fprintf( ifd, " Document size    : " );
					fprintf( ifd, "%d\n", di.size );
					fprintf( ifd, " Add time         : " );
					fprintf( ifd, "%s",
						ctime( (time_t *)&di.atime ) );
					if( di.utime )
					{
						fprintf( ifd, " Update time " );
						fprintf( ifd, "     : %s",
						ctime( (time_t *)&di.utime ) );
					}
					if( !l_isspaceornull( di.title,
							sizeof di.title ) )
					{
						fprintf( ifd, " Title       " );
						fprintf( ifd, "     : %-*.*s\n",
							sizeof di.title,
							sizeof di.title,
							di.title );
					}
					if( !l_isspaceornull( di.fname,
							sizeof di.fname ) )
					{
						fprintf( ifd, " File name   " );
						fprintf( ifd, "     : %-*.*s\n",
							sizeof di.fname,
							sizeof di.fname,
							di.fname );
					}
					if( !l_isspaceornull( di.type,
							sizeof di.type ) )
					{
						fprintf( ifd, " Type        " );
						fprintf( ifd, "     : %-*.*s\n",
							sizeof di.type,
							sizeof di.type,
							di.type );
					}
					if( !l_isspaceornull( di.userinf,
							sizeof di.userinf ) )
					{
						fprintf( ifd, " User info   " );
						fprintf( ifd, "     : %-*.*s\n",
							sizeof di.userinf,
							sizeof di.userinf,
							di.userinf );
					}
				}
			}
		}
	}

	if( ifd != (FILE *)0 )
		fclose( ifd );

	PI_DCLOSE( dsfd );

	printf( "Backup OK ( read doc count = %d, error count = %d ).\n",
						okcnt, errcnt );

	return( 0 );

} /* ds_backup */

/* added by stoneshim start */
/*----------------------------------------------------------------------+
|	add a directory							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_add_dir( char *filepath, char *dirpath )
#else
ds_add_dir( filepath, dirpath )
char	*filepath;
char	*dirpath;
#endif
{
	int		dsfd;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_ADDDIR( dsfd, dirpath ) < 0 )
	{
		printf( "Direcoty information add error with errno(%d).\n",
								hyerrno );
		PI_DCLOSE( dsfd );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();

	printf( "Directory information add complete.\n" );

	return( 0 );
}

/* end of ds_add_dir */
/*----------------------------------------------------------------------+

/*----------------------------------------------------------------------+
|	update a directory						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_upd_dir( char *filepath, char *olddirpath, char *newdirpath )
#else
ds_upd_dir( filepath, olddirpath, newdirpath )
char	*filepath;
char	*olddirpath;
char	*newdirpath;
#endif
{
	int		dsfd;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_UPDDIR( dsfd, olddirpath, newdirpath ) < 0 )
	{
		printf( "Direcoty update error with errno(%d).\n",
								hyerrno );
		PI_DCLOSE( dsfd );
		PI_ROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_COMMIT();
	PI_ENDTRAN();

	printf( "Directory update complete.\n" );

	return( 0 );
}

/* end of ds_upd_dir */
/*----------------------------------------------------------------------+

/*----------------------------------------------------------------------+
|	delete a directory						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_del_dir( char *filepath, char *dirpath )
#else
ds_del_dir( filepath, dirpath )
char	*filepath;
char	*dirpath;
#endif
{
	int		dsfd;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_DROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_DELDIR( dsfd, dirpath ) < 0 )
	{
		printf( "Direcoty information delete error with errno(%d).\n",
								hyerrno );
		PI_DCLOSE( dsfd );
		PI_DROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_DCOMMIT();
	PI_ENDTRAN();

	printf( "Directory information delete complete.\n" );

	return( 0 );
}

/* end of ds_del_dir */

/*----------------------------------------------------------------------+
|	update a directory information in DSMLFILE			|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_upd_dirinfo( char *filepath, char *olddirpath, char *newdirpath )
#else
ds_upd_dirinfo( filepath, olddirpath, newdirpath )
char	*filepath;
char	*olddirpath;
char	*newdirpath;
#endif
{
	int		dsfd;

	if( PI_TRAN() < 0 )
	{
		printf( "Can't start transaction processing. errno(%d)\n",
								hyerrno );
		return( EIO );
	}

	if( ( dsfd = PI_DUOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		PI_DROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	if( PI_UPDDIRINFO( dsfd, olddirpath, newdirpath ) < 0 )
	{
		printf( "Direcoty information update error with errno(%d).\n",
								hyerrno );
		PI_DCLOSE( dsfd );
		PI_DROLLBACK();
		PI_ENDTRAN();
		return( ENOENT );
	}

	PI_DCLOSE( dsfd );
	PI_DCOMMIT();
	PI_ENDTRAN();

	printf( "Directory information update complete.\n" );

	return( 0 );
}

/* end of ds_upd_dirinfo */
/*----------------------------------------------------------------------+
|	read master directory information				|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_show_lm( char *filepath )
#else
ds_show_lm( filepath )
char	*filepath;
#endif
{
	int			dsfd;
	struct	DS_DIRMINFO	lmbuf;
	int			i;

	if( ( dsfd = PI_DOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		return( ENOENT );
	}

	for( i = 0; ; i++ )
	{
		if( PI_DLMREAD( dsfd, i, &lmbuf ) < 0 )
			break;

		printf( "---------------------------------------------------------------\n");
		printf( "master path = %s\n", lmbuf.dir );
		printf( "subdircnt = %d\n", lmbuf.dircnt );
	}

	printf( "---------------------------------------------------------------\n");
	printf( "total %d master directory found in %s\n\n", i, filepath );

	PI_DCLOSE( dsfd );

	return( 0 );
}
/* end of ds_show_lm */
/*----------------------------------------------------------------------+
|	read sub directory information					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_show_lv( char *filepath, char *buf )
#else
ds_show_lv( filepath, s_volno )
char	*filepath;
char	*buf;
#endif
{
	register		i, j;
	int			dsfd;
	int			fromvolno;
	int			tovolno;
	struct	DS_DIRVINFO	lvbuf;
	struct	DSMMFORM	dsmm_inf;
	int			cnt=0;

	if( ( dsfd = PI_DOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		return( ENOENT );
	}

	if( PI_DHREAD( dsfd, &dsmm_inf ) < 0 )
	{
		printf( "DSML file read error with errno(%d).\n", hyerrno );	
		return( ENOENT );
	}
	tovolno = dsmm_inf.volcnt - 1;

	if( buf == (char *)0 )
	{
		fromvolno = 0;
	}
	else
	{
		if( buf[0] == '-' )
		{
			fromvolno = 0;
			tovolno = atoi( &buf[1] );
		}
		else
		{
			for( i = 1; (unsigned int)i < strlen( buf ); i++ )
			{
				if( buf[i] == '-' )
					break;
			}

			if( (unsigned int)i == strlen( buf ) -1 )
			{
				fromvolno = atoi( buf );
			}
			else
			{
				buf[i] = 0;
				fromvolno = atoi( buf );
				tovolno = atoi( &buf[i+1] );
			}	
		}
	}

	for( i = fromvolno; i <= tovolno; i++ )
	{
		for( j = 0; ; j++ )
		{
			if( PI_DLVREAD( dsfd, i, j, &lvbuf ) < 0 )
				break;

			printf( "---------------------------------------------------------------\n");
			printf( "volno = %d\n", i );
			printf( "sub path = %s\n", lvbuf.dir );
			printf( "filecnt = %d\n", lvbuf.filecnt );
			cnt++;
		}
	}

	printf( "---------------------------------------------------------------\n");
	printf( "total %d subdir found in vol %d-%d\n\n", cnt, fromvolno, tovolno );

	PI_DCLOSE( dsfd );

	return( 0 );
}
/* end of ds_show_lv */
/*----------------------------------------------------------------------+
|	read files in sub directory					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_show_file( char *filepath, char *buf )
#else
ds_show_file( filepath, buf )
char	*filepath;
char	*buf;
#endif
{
	int			dsfd;
	struct	DSMIFORM	di;
	int			fromdocid;
	int			todocid = 100000000;
	int			i;
	int			cnt = 0;
	char			filebuf[128];
	char			filename[128];

printf( "aaaaaa\n" );
	if( buf == (char *)0 )
	{
printf( "22222\n" );
		fromdocid = 1;
		todocid = 100000000;
	}
	else
	{
printf( "11111\n" );
		if( buf[0] == '-' )
		{
			fromdocid = 1;
			todocid = atoi( &buf[1] );
		}
		else
		{
			for( i = 1; (unsigned int)i < strlen( buf ); i++ )
			{
				if( buf[i] == '-' )
					break;
			}

			if( (unsigned int)i == strlen( buf ) -1 )
			{
				fromdocid = atoi( buf );
			}
			else
			{
				buf[i] = 0;
				fromdocid = atoi( buf );
				todocid = atoi( &buf[i+1] );
			}	
		}
	}

	if( ( dsfd = PI_DOPEN( filepath ) ) < 0 )
	{
		printf( "File open error with errno(%d).\n", hyerrno );
		return( ENOENT );
	}

	for( i = fromdocid; i <= todocid; i++ )
	{
		memset( filename, 0, sizeof( filename ) );
		if( PI_DLFREAD( dsfd, i, filebuf, filename ) < 0 )
			continue;

		cnt++;
		printf( "---------------------------------------------------------------\n");
		printf( "docid = %d\n", i );
		printf( "filename = %s\n", filename );
		printf( "filepath = %s\n", filebuf );

		if( PI_DINEXT( dsfd, &i, &di ) < 0 )
		{
			todocid = i;
			break;
		}
	}

	printf( "---------------------------------------------------------------\n" );
	printf( "total %d documents found in docid %d-%d\n\n", cnt, fromdocid, todocid );

	PI_DCLOSE( dsfd );

	return( 0 );
}
/* end of ds_show_file */
/*-------------------------------------------------------------------/
**	prmore
/-------------------------------------------------------------------*/
static	void
#if	defined( __CB_STDC__ )
prmore( void )
#else
prmore()
#endif
{
	if( stdout_fl )
	{
		printf( "Press enter key......\n" );
		fflush( stdin );
		getchar();
	}

	return;

} /* prmore */

/*----------------------------------------------------------------------+
/* added by stoneshim end */
/*----------------------------------------------------------------------+

/*----------------------------------------------------------------------+
|	USAGE								|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
usage( char *exepath )
#else
usage( exepath )
char	*exepath;
#endif
{
	register	i;

#ifdef	WIN32
	for( i=strlen( exepath )-1; i>0 && exepath[i]!='\\'; i-- ) ;
	if( exepath[i] == '\\' )
		i++;
#else
	for( i=strlen( exepath )-1; i>0 && exepath[i]!='/'; i-- ) ;
	if( exepath[i] == '/' )
		i++;
#endif

	printf( "\n-----===== [ DSML Administrator Utility ] =====-----\n\n" );
	printf( "USAGE : %s dsmlfile action args\n", &exepath[i] );
	printf( " < action >----------------------------------------------\n" );
	printf( "   b  : Backup documents into sam files.\n" );
	printf( "   l  : List information of documents.\n" );
	printf( "   c  : Check and fix information of document, " );
	printf( "volume or master.\n" );
	printf( "   d  : Delete documents.\n" );
	printf( "   va : Add new volume.            " );
	printf( "   vs : Change size of volume.\n" );
	printf( "   vr : Rename path of volume.     " );
	printf( "   vd : Delete volume.\n" );
	printf( "   m  : Build new DSML. or Convert old DSML.\n" );
	printf( "   fa : Add master Directory.      " );
	printf( "   fc : Change master directory.\n" );
	printf( "   fd : Delete master directory.   " );
	printf( "   fu : Change master directory Info.\n" );
	printf( "   im : List information of master directory.\n" );
	printf( "   iv : List information of sub directory in specific volids.\n" );
	printf( "   if : List information of files of specific docids.\n\n" );
	prmore();
	printf( " < args >------------------------------------------------\n" );
	printf( "   b      : target_directory [ docids | -v volids ... ]\n" );
	printf( "   l,d    : [ docids | -v volids ... ]\n" );
	printf( "   c      : [ -v volids ... ]\n" );
	printf( "   va, vs : vol_path vol_size(in_M)\n" );
	printf( "   vr     : old_vol_path new_vol_path\n" );
	printf( "   vd     : vol_path\n" );
	printf( "   m      : vol_size(in_M) blk_size(in_K) " );
	printf( "[ old_dsml_to_convert ]\n" );
	printf( "   fa     : dir_path to add\n" );
	printf( "   fc     : old_dir_path new_dir_path\n" );
	printf( "   fd     : dir_path to delete\n" );
	printf( "   fu     : old_dir_path( full path ) new_dir_path\n" );
	printf( "   iv     : [ volids ]\n" );
	printf( "   if     : [ docids ]\n" );
	printf( " < docids, volids >--------------------------------------\n" );
	printf( "   n   : single id.                  " );
	printf( "   n-  : ids from id(n) to last id\n" );
	printf( "   -m  : ids from first id to id(m)  " );
	printf( "   n-m : ids from id(n) to id(m)\n\n" );

} /* usage */

/*----------------------------------------------------------------------+
|	check IDs							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
chk_id( int argc, char *argv[], int start )
#else
chk_id( argc, argv, start )
int	argc;
char	*argv[];
int	start;
#endif
{
	register	idix, i, j;

	memset( ids, 0, sizeof ids );

	if( start == argc )
	{
		ids[0].id_fl = 2;
		return( 0 );
	}

	for( idix=0; idix<MAX_ID_GROUPS && start<argc; idix++, start++ )
	{
		if( argv[start][0] == '-' &&
		    ( argv[start][1] == 'v' || argv[start][1] == 'V' ) )
		{
			if( (int)strlen( argv[start] ) > 2 )
				return( -1 );

			ids[idix].id_fl = 1;
			start ++;

			if( start >= argc )
				return( -1 );
		}

		for( i=0; argv[start][i] && argv[start][i]!='-'; i++ )
			if( argv[start][i] < '0' || argv[start][i] > '9' )
				return( -1 );

		if( i == 0 )
		{
			if( argv[start][i] == 0 || argv[start][i+1] == 0 )
				return( -1 );

			ids[idix].fr_id = ids[idix].id_fl ? 0 : 1;
		}
		else
		{
			ids[idix].fr_id = atoi( argv[start] );
			if( !ids[idix].id_fl && ids[idix].fr_id < 1 )
				return( -1 );

			if( argv[start][i] == 0 )
			{
				ids[idix].to_id = ids[idix].fr_id;
				continue;
			}

			if( argv[start][i+1] == 0 )
			{
				ids[idix].to_id = 100000000;
				continue;
			}
		}

		for( i++, j=0; argv[start][i+j]; j++ )
			if( argv[start][i+j] < '0' || argv[start][i+j] > '9' )
				return( -1 );

		ids[idix].to_id = atoi( &argv[start][i] );
		if( !ids[idix].id_fl && ids[idix].fr_id < 1 )
			return( -1 );
		if( ids[idix].fr_id > ids[idix].to_id )
			return( -1 );
	}

	if( ids[0].fr_id == 0 && ids[0].to_id == 0 && ids[0].id_fl == 0 )
		return( -1 );

	return( 0 );
}

/*----------------------------------------------------------------------+
|	check arguments							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
chk_args( int argc, char *argv[] )
#else
chk_args( argc, argv )
int	argc;
char	*argv[];
#endif
{
	if( argc < 3 )
		return( -1 );

	if( ! isatty( fileno( stdout ) ) )
		stdout_fl = 0;

	switch( argv[2][0] )
	{
	case	'b'	:
	case	'B'	:
		if( (int)strlen( argv[2] ) > 1 )
			return( -1 );
		argv[2][0] = 'b';

		if( argc < 4 )
			return( -1 );
		if( access( argv[3], W_OK ) )
			return( -1 );
		if( chk_id( argc, argv, 4 ) )
			return( -1 );
		break;

	case	'c'	:
	case	'C'	:
		if( (int)strlen( argv[2] ) > 1 )
			return( -1 );
		argv[2][0] = 'c';

		if( chk_id( argc, argv, 3 ) )
			return( -1 );
		break;

/* added by stoneshim start */
	case	'f'	:
	case	'F'	:
		if( (int)strlen( argv[2] ) > 2 )
			return( -1 );
		argv[2][0] = 'f';
		switch( argv[2][1] )
		{
		case	'a'	:
		case	'A'	:
			argv[2][1] = 'a';
			if( argc < 4 )
				return( -1 );
			break;
		case	'c'	:
		case	'C'	:
			argv[2][1] = 'c';
			if( argc < 5 )
				return( -1 );
			break;
		case	'd'	:
		case	'D'	:
			argv[2][1] = 'd';
			if( argc < 4 )
				return( -1 );
			break;
		case	'u'	:
		case	'U'	:
			argv[2][1] = 'u';
			if( argc < 5 )
				return( -1 );
			break;
		default	: return( -1 );
		}
		break;

	case	'i'	:
	case	'I'	:
		if( (int)strlen( argv[2] ) > 2 )
			return( -1 );
		argv[2][0] = 'i';
		switch( argv[2][1] )
		{
		case	'm'	:
		case	'M'	:
			argv[2][1] = 'm';
			break;
		case	'v'	:
		case	'V'	:
			argv[2][1] = 'v';
			break;
		case	'f'	:
		case	'F'	:
			argv[2][1] = 'f';
			break;
		default	: return( -1 );
		}
		break;
/* added by stoneshim end */

	case	'l'	:
	case	'L'	:
		if( (int)strlen( argv[2] ) > 1 )
			return( -1 );
		argv[2][0] = 'l';

		if( chk_id( argc, argv, 3 ) )
			return( -1 );
		break;

	case	'd'	:
	case	'D'	:
		if( (int)strlen( argv[2] ) > 1 )
			return( -1 );
		argv[2][0] = 'd';

		if( chk_id( argc, argv, 3 ) )
			return( -1 );
		break;

	case	'v'	:
	case	'V'	:
		if( (int)strlen( argv[2] ) > 2 )
			return( -1 );
		argv[2][0] = 'v';

		switch( argv[2][1] )
		{
		case	'a'	:
		case	'A'	:
			argv[2][1] = 'a';
			if( argc < 5 )
				return( -1 );
			if( atoi( argv[4] ) < 0 )
				return( -1 );
			break;

		case	's'	:
		case	'S'	:
			argv[2][1] = 's';
			if( argc < 5 )
				return( -1 );
			if( atoi( argv[4] ) < 0 )
				return( -1 );
			break;

		case	'd'	:
		case	'D'	:
			if( argc < 4 )
				return( -1 );
			argv[2][1] = 'd';
			break;

		case	'r'	:
		case	'R'	:
			argv[2][1] = 'r';
			if( argc < 5 )
				return( -1 );
			break;

		default		:
			return( -1 );
		} /* end of switch */
		break;

	case	'm'	:
	case	'M'	:
		if( (int)strlen( argv[2] ) > 1 )
			return( -1 );

		argv[2][0] = 'm';

		if( argc < 5 )
			return( -1 );
		if( atoi( argv[3] ) < 0 )
			return( -1 );
		if( atoi( argv[4] ) < 0 )
			return( -1 );
		break;

	default		:
		return( -1 );
	}

	return( 0 );

} /* chk_args */

/*----------------------------------------------------------------------+
|	main								|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	int	ret;

	if( chk_args( argc, argv ) < 0 )
	{
		usage( argv[0] );
		return( EINVAL );
	}

	switch( argv[2][0] )	/* command */
	{
	case	'b'	:
		ret = ds_backup( argv[1], argv[3] );
		break;

	case	'c'	:
		ret = ds_check_all( argv[1] );
		break;

/* added by stoneshim */
	case	'f'	:
		switch( argv[2][1] )
		{
		case	'a'	:
			ret = ds_add_dir( argv[1], argv[3] );
			break;
		case	'c'	:
			ret = ds_upd_dir( argv[1], argv[3], argv[4] );
			break;
		case	'd'	:
			ret = ds_del_dir( argv[1], argv[3] );
			break;
		case	'u'	:
			ret = ds_upd_dirinfo( argv[1], argv[3], argv[4] );
			break;
		}
		break;
	case	'i'	:
		switch( argv[2][1] )
		{
		case	'm'	:
			ret = ds_show_lm( argv[1] );
			break;
		case	'v'	:
			if( argc < 4 )
			{
				ret = ds_show_lv( argv[1], (char *)0 );
			}
			else
			{
				ret = ds_show_lv( argv[1], argv[3] );
			}
			break;
		case	'f'	:
			if( argc < 4 )
			{
				ret = ds_show_file( argv[1], (char *)0 );
			}
			else
			{
				ret = ds_show_file( argv[1], argv[3] );
			}
			break;
		}
		break;
/* added by stoneshim */
		
	case	'd'	:
		ret = ds_delete_doc( argv[1] );
		break;

	case	'l'	:
		ret = ds_di_all( argv[1] );
		break;

	case	'v'	:
		switch( argv[2][1] )
		{
		case	'a'	:
			ret = ds_vol_add( argv[1], argv[3], atoi( argv[4] ) );
			break;
		case	'd'	:
			ret = ds_vol_del( argv[1], argv[3] );
			break;
		case	'r'	:
			ret = ds_vol_ren( argv[1], argv[3], argv[4] );
			break;
		case	's'	:
			ret = ds_vol_upd( argv[1], argv[3], atoi( argv[4] ) );
			break;
		}
		break;

	case	'm'	:
		ret = ds_1to2( argv[1], atoi(argv[3]), atoi(argv[4]),
				argc > 5 ? argv[5] : (char *)0 );
		break;

	} /* switch command */

	return( ret );

} /* main */

/******* The end of dsmladm.c ******************************************/
