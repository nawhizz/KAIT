/* ds_filegen() : LIB dsml internal function */
/************************************************************************
*	generate new file						*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		full file path		*
*		  struct BUILDFORM *build_inf	build information	*
*		  char	*dirpath		full dir path		*
*	return	: int	isfd			isam open number	*
************************************************************************/

#include	<string.h>
#include	<stdlib.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
int			ds_currfd = -2;
struct	DS_FILEINFO	dsfi[DS_MAX_OPEN];
union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	generate new file						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_filegen( char *filepath, struct BUILDFORM *build_inf, char *dirpath )
#else
ds_filegen( filepath, build_inf, dirpath )
char			*filepath;
struct	BUILDFORM	*build_inf;
char			*dirpath;
#endif
{
	int		isfd;
	struct	keydesc ckey;
	int		fd;

	/*---------------------------------------------------------------
	** Build isam file with primary key
	**-------------------------------------------------------------*/
	ckey.k_flags = ISNODUPS;
	ckey.k_nparts = 2;
	ckey.k_len = 2 * LONGSIZE;
	ckey.k_rootnode = 0;
	ckey.k_part[0].kp_start = 0;
	ckey.k_part[0].kp_leng	= LONGSIZE;
	ckey.k_part[0].kp_type = LONGTYPE;
	ckey.k_part[1].kp_start = LONGSIZE;
	ckey.k_part[1].kp_leng	= LONGSIZE;
	ckey.k_part[1].kp_type = LONGTYPE;

	if( ( isfd = isbuild( filepath, build_inf->blksz * 1024 - 1, &ckey,
					ISINOUT + ISMANULOCK ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** Write DSML master information
	**-------------------------------------------------------------*/
	memset( &du, 0, sizeof du );
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	strcpy( du.m.version, DS_VERSION_2_1 );
	du.m.volsts = DS_MASTER_VOLUME;
	stlong( (long)0, (char *)&du.m.doccnt );
	stlong( (long)1, (char *)&du.m.mindocid );
	stlong( (long)DS_MAX_DOC_ID, (char *)&du.m.maxdocid );
	if( dirpath != (char *)0 )
		stlong( (long)2, (char *)&du.m.usedblkcnt );
	else
		stlong( (long)1, (char *)&du.m.usedblkcnt );
	stlong( (long)0, (char *)&du.m.reservblkcnt );
	stint( build_inf->blksz, (char *)&du.m.blksz );
	stint( 1, (char *)&du.m.volcnt );
	stint( 1, (char *)&du.m.thisvolcnt );

	strcpy( du.m.vol[0].volpath, filepath );
	stlong( (long)( build_inf->maxvolsz * 1024 / build_inf->blksz ),
					(char *)&du.m.vol[0].maxblkcnt );
	du.m.vol[0].volgen = DS_GEN_VOLUME;

	if( iswrite( isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( isfd );
		iserase( filepath );
		return( -1 );
	}

/* added by stoneshim start */
	/*---------------------------------------------------------------
	** Write lm, lv in dsml file & mkdir.
	**-------------------------------------------------------------*/
	if( dirpath != (char *)0 )
	{
		memset( &du, 0, sizeof( du ) ); 
		stlong( (long)-2, (char *)&du.lm.id );
		stlong( (long)0, (char *)&du.lm.seq );
		stlong( (long)1, (char *)&du.lm.totdircnt );
		stlong( (long)1, (char *)&du.lm.thisdircnt );
		strcpy( du.lm.dirent[0].dir, dirpath ); 
		stlong( (long)0, (char *)&du.lm.dirent[0].dircnt );
		if( iswrite( isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			isclose( isfd );
			iserase( filepath );
			return( -1 );
		}
	}
/* added by stoneshim end */

	if( isclose( isfd ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		iserase( filepath );
		return( -1 );
	}

	if( ( isfd = isopen( filepath, ISINOUT + ISMANULOCK + ISTRANS ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		iserase( filepath );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** save DSML master information to table
	**-------------------------------------------------------------*/
	fd = ds_currfd;

	memset( &dsfi[fd], 0, sizeof dsfi[fd] );

	/* head information */
	strcpy( dsfi[fd].version, DS_VERSION );
	dsfi[fd].volsts = DS_MASTER_VOLUME;
	dsfi[fd].verno[0] = (char)2;
	dsfi[fd].isfd = isfd;
	dsfi[fd].ismode = ISINOUT + ISMANULOCK + ISTRANS;
	dsfi[fd].isvolno = 0;
	dsfi[fd].blksz = build_inf->blksz;
	dsfi[fd].volcnt = 1;
/* added by stoneshim start */
	if( dirpath != (char *)0 )
		dsfi[fd].dircnt	= 1;
	else
		dsfi[fd].dircnt = 0;
/* added by stoneshim end */

	/* allocate memory for volume information */
	dsfi[fd].vol = (struct DS_VOLINFO *)malloc(
						sizeof( struct DS_VOLINFO ) );
	if( dsfi[fd].vol == (struct DS_VOLINFO *)0 )
	{
		l_dsmlsethyerrno( EDS_NOMORE_MEM );
		isclose( isfd );
		iserase( filepath );
		return( -1 );
	}
	memset( dsfi[fd].vol, 0, sizeof( struct DS_VOLINFO ) );

	/* volume information */
	dsfi[fd].vol[0].doccnt = 0;
	dsfi[fd].vol[0].mindocid = 1;
	dsfi[fd].vol[0].maxdocid = DS_MAX_DOC_ID;
	if( dirpath != (char *)0 )
		dsfi[fd].vol[0].usedblkcnt = 2;
	else
		dsfi[fd].vol[0].usedblkcnt = 1;
	dsfi[fd].vol[0].reservblkcnt = 0;
/* added by stoneshim start */
/*	dsfi[fd].vol[0].dircnt = 0; */
/* added by stoneshim end */
	strcpy( dsfi[fd].vol[0].volpath, filepath );
	dsfi[fd].vol[0].maxblkcnt = build_inf->maxvolsz * 1024 /
							build_inf->blksz;
	dsfi[fd].vol[0].volgen = DS_GEN_VOLUME;

/* added by stoneshim start */
	/*--------------------------------------------------------------------
	**	Save Parent Directory Information to Table
	--------------------------------------------------------------------*/
	if( dirpath != (char *)0 )
	{
		dsfi[fd].lm = (struct DS_DIRMINFO *)malloc(
						sizeof( struct DS_DIRMINFO ) );
		if( dsfi[fd].lm == (struct DS_DIRMINFO *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			free( dsfi[fd].vol );
			isclose( isfd );
			iserase( filepath );
			return( -1 );
		}
		strcpy( dsfi[fd].lm[0].dir, du.lm.dirent[0].dir ); 
		dsfi[fd].lm[0].dircnt = 0;
	}
/* added by stoneshim end */

	/* fd valid */
	strcpy( dsfi[fd].filepath, filepath );


	ds_nextfd();

	return( fd );
}

/******* The end of ds_filegen.c ***************************************/
