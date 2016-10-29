/* ds_fileopen() : LIB dsml internal function */
/************************************************************************
*	open file							*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		full file path		*
*		  int	mode			isam open mode		*
*	return	: int	isfd			isam open number	*
************************************************************************/

#include	<string.h>
#include	<stdlib.h>
#include	<iswrap.h>
#include	<errno.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	int			ds_currfd;
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	open file							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_fileopen( char *filepath, int mode )
#else
ds_fileopen( filepath, mode )
char	*filepath;
int	mode;
#endif
{
	register	i, j;
	int		isfd;
	int		fd;
	int		version;
	int		volno;
	int		thisvolcnt;
	int		dirseq, dircntperpage;
	struct	keydesc	pkey;

	/*---------------------------------------------------------------
	** Open isam file
	**-------------------------------------------------------------*/
	mode += ISMANULOCK;
	if( ( isfd = isopen( filepath, mode ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** Check DSML version
	**-------------------------------------------------------------*/
	if( isindexinfo( isfd, &pkey, 1 ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( isfd );
		return( -1 );
	}

	if( pkey.k_nparts != 2 )
	{
		l_dsmlsethyerrno( EDS_NOT_DSML );
		isclose( isfd );
		return( -1 );
	}

	if( pkey.k_part[0].kp_start == 0 &&
	    pkey.k_part[0].kp_leng == INTSIZE &&
	    pkey.k_part[0].kp_type == INTTYPE &&
	    pkey.k_part[1].kp_start == INTSIZE &&
	    pkey.k_part[1].kp_leng == INTSIZE &&
	    pkey.k_part[1].kp_type == INTTYPE )
	{
		version = 1;
	}
	else if( pkey.k_part[0].kp_start == 0 &&
	    pkey.k_part[0].kp_leng == LONGSIZE &&
	    pkey.k_part[0].kp_type == LONGTYPE &&
	    pkey.k_part[1].kp_start == LONGSIZE &&
	    pkey.k_part[1].kp_leng == LONGSIZE &&
	    pkey.k_part[1].kp_type == LONGTYPE )
	{
		version = 2;
	}
	else
	{
		l_dsmlsethyerrno( EDS_NOT_DSML );
		isclose( isfd );
		return( -1 );
	}
	
	fd = ds_currfd;
	memset( &dsfi[fd], 0, sizeof dsfi[fd] );

	/*---------------------------------------------------------------
	** save DSML information for V. 1.x
	**-------------------------------------------------------------*/
	if( version == 1 )
	{
		/* head information */
		strcpy( dsfi[fd].version, DS_VERSION_1 );
		dsfi[fd].verno[0] = (char)1;
		dsfi[fd].isfd = isfd;
		strcpy( dsfi[fd].filepath, filepath );

		ds_nextfd();

		return( fd );
	}

	/*---------------------------------------------------------------
	** Read DSML master information
	**-------------------------------------------------------------*/
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	if( isread( isfd, (char *)&du, ISGTEQ ) < 0 ||
	    (int)ldlong( (char *)&du.m.id ) >= 0 ||
	    (int)ldlong( (char *)&du.m.seq ) > 0 ||
	    ( strcmp( du.m.version, DS_VERSION ) &&
	      strcmp( du.m.version, DS_VERSION_2_1 ) ) )
	{
		l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
		isclose( isfd );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** save master information at first
	**-------------------------------------------------------------*/
	/* read first master record already */
	memcpy( dsfi[fd].version, du.m.version, sizeof du.m.version );
	dsfi[fd].volsts = du.m.volsts;
	ds_setver( du.m.version, dsfi[fd].verno );
	dsfi[fd].isfd = isfd;
	dsfi[fd].ismode = mode;
	dsfi[fd].blksz = ldint( (char *)&du.m.blksz );
	dsfi[fd].volcnt = ldint( (char *)&du.m.volcnt );

	/*---------------------------------------------------------------
	** allocate memory for volume information
	**-------------------------------------------------------------*/
	dsfi[fd].vol = (struct DS_VOLINFO *)malloc(
			sizeof( struct DS_VOLINFO ) * dsfi[fd].volcnt );
	if( dsfi[fd].vol == (struct DS_VOLINFO *)0 )
	{
		l_dsmlsethyerrno( EDS_NOMORE_MEM );
		isclose( isfd );
		return( -1 );
	}
	memset( dsfi[fd].vol, 0, 
			sizeof( struct DS_VOLINFO ) * dsfi[fd].volcnt );

	/*---------------------------------------------------------------
	** save volume path information
	**-------------------------------------------------------------*/
	thisvolcnt = ldint( (char *)&du.m.thisvolcnt );

	for( i=0, volno=0; ; )
	{
		/* set volume informations in this page to table */
		for( j=0; j<thisvolcnt; j++, volno++ )
		{
			if( i == 0 )
			{
				dsfi[fd].vol[volno].maxblkcnt =
					(int)ldlong( (char *)&du.m.vol[j].maxblkcnt);
				dsfi[fd].vol[volno].volgen = du.m.vol[j].volgen;
				strcpy( dsfi[fd].vol[volno].volpath,
					du.m.vol[j].volpath );
			}
			else
			{
				dsfi[fd].vol[volno].maxblkcnt =
					(int)ldlong( (char *)&du.v.vol[j].maxblkcnt);
				dsfi[fd].vol[volno].volgen = du.v.vol[j].volgen;
				strcpy( dsfi[fd].vol[volno].volpath,
					du.v.vol[j].volpath );
			}
		}

		if( ( i += thisvolcnt ) >= dsfi[fd].volcnt )
			break;

		/* read next master information */
		if( isread( isfd, (char *)&du, ISNEXT ) < 0 ||
		    (int)ldlong( (char *)&du.m.id ) >= 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			isclose( isfd );
			free( dsfi[fd].vol );
			return( -1 );
		}

		thisvolcnt = ldint( (char *)&du.v.thisvolcnt );

	} /* end of for */

	
	dircntperpage = ( dsfi[fd].blksz * 1024 - 1 - 
				DS_DIR_HEADSZ ) / DS_DIR_INFSZ;

	/*---------------------------------------------------------------
	** check whether filepath is in volume information
	**-------------------------------------------------------------*/
	if( dsfi[fd].volsts == DS_MASTER_VOLUME )
	{
		/* if master volume moved */
		if( strcmp( dsfi[fd].vol[0].volpath, filepath ) )
		{
			strcpy( dsfi[fd].vol[0].volpath, filepath );
			if( dsfi[fd].ismode - ISMANULOCK != ISINPUT )
			{
				/*---------------------------------------
				** save moved master volume path to isam file
				**-------------------------------------*/
				stlong( (long)-1, (char *)&du.m.id );
				stlong( (long)0, (char *)&du.m.seq );

				if( isread( isfd, (char *)&du,
							ISEQUAL + ISLCKW ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					isclose( isfd );
					free( dsfi[fd].vol );
					return( -1 );
				}

				memset( du.m.vol[0].volpath, 0, DS_PATHLEN );
				strcpy( du.m.vol[0].volpath, filepath );

				if( isrewcurr( isfd, (char *)&du ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					isclose( isfd );
					free( dsfi[fd].vol );
					return( -1 );
				}
			}

		} /* end of if( master volume moved ) */

/* added by stoneshim start */
		stlong( (long)-2, (char *)&du.lm.id );
		stlong( (long)0, (char *)&du.lm.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
		{
			dsfi[fd].dircnt = 0;
			dsfi[fd].lm = (struct DS_DIRMINFO *)0;
		}
		else
		{
			/*---------------------------------------------------------------
			** allocate memory for parent directory information
			**-------------------------------------------------------------*/
			dsfi[fd].dircnt = (int)ldlong( (char *)&du.lm.totdircnt );

			dsfi[fd].lm = (struct DS_DIRMINFO *)malloc(
					sizeof( struct DS_DIRMINFO ) * dsfi[fd].dircnt );

			if( dsfi[fd].lm == (struct DS_DIRMINFO *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				isclose( isfd );
				free( dsfi[fd].vol );
				return( -1 );
			}
			/*---------------------------------------------------------------
			** Read parent directory information
			**-------------------------------------------------------------*/
			dirseq = 0;
			for( j = 0; j < dsfi[fd].dircnt ;j++ )
			{
				if( j/dircntperpage > dirseq )
				{
					dirseq++;
					memset( &du, 0, sizeof du );
					stlong( (long)-2, (char *)&du.lm.id );
					stlong( (long)dirseq, (char *)&du.lm.seq );

					if( isread( dsfi[fd].isfd, (char *)&du,
						ISEQUAL ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						isclose( isfd );
						free( dsfi[fd].vol );
						free( dsfi[fd].lm );
						return( -1 );
					}
				}

				dsfi[fd].lm[j].dircnt =
				(int)ldlong((char *)&du.lm.dirent[j%dircntperpage].dircnt );	
				strcpy( dsfi[fd].lm[j].dir,
					 du.lm.dirent[j%dircntperpage].dir );
			}
		}
/* added by stoneshim end */

		/* volume information of that volno is 0 saved already */
		dsfi[fd].isvolno = 0;

	} /* end of if( this volume is master volume ) */

	else	/* check filepath because second volume can move only */
		/* when DSML open with master volume */
	{
		/* search filepath in volume path information */
		dsfi[fd].vol[0].volgen = DS_UNKNOWN_VOLUME;
		for( i=1; i<dsfi[fd].volcnt; i++ )
		{
			if( !strcmp( dsfi[fd].vol[i].volpath, filepath ) )
				break;
			dsfi[fd].vol[i].volgen = DS_UNKNOWN_VOLUME;
		}

		/* not found filepath */
		if( i >= dsfi[fd].volcnt )
		{
			l_dsmlsethyerrno( EDS_SECOND_VOLUME_MOVE );
			isclose( isfd );
			free( dsfi[fd].vol );
			return( -1 );
		}

		dsfi[fd].isvolno = i;

		for( i++; i<dsfi[fd].volcnt; i++ )
			dsfi[fd].vol[i].volgen = DS_UNKNOWN_VOLUME;
	}

	/*---------------------------------------------------------------
	** save volume information
	**-------------------------------------------------------------*/
	for( volno=0; volno<dsfi[fd].volcnt; volno++ )
	{
		dsfi[fd].vol[volno].doccnt = 0;
		dsfi[fd].vol[volno].mindocid = -1;
		dsfi[fd].vol[volno].maxdocid = -1;
		dsfi[fd].vol[volno].usedblkcnt = 0;
		dsfi[fd].vol[volno].reservblkcnt = 0;

		if( dsfi[fd].vol[volno].volgen != DS_GEN_VOLUME )
			continue;

		if( ds_volopen( fd, volno ) < 0 )
		{
			if( dsfi[fd].isvolno == -1 )	/* open error */
			{
				dsfi[fd].vol[volno].volgen = DS_INVALID_VOLUME;
				dsfi[fd].isvolno = -2;
				continue;
			}
			else				/* close error */
			{
				isclose( dsfi[fd].isfd );
				for( volno--; volno>=0; volno-- )
				{
					if( dsfi[fd].vol[volno].lv
						!= (struct DS_DIRVINFO *)0 )
					{
						free( dsfi[fd].vol[volno].lv );
					}
				}
				if( dsfi[fd].lm != (struct DS_DIRMINFO *)0 )
					free( dsfi[fd].lm );

				free( dsfi[fd].vol );
				return( -1 );
			}
		}

		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)0, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
		{
			dsfi[fd].vol[volno].volgen = DS_INVALID_VOLUME;
			continue;
		}

		dsfi[fd].vol[volno].doccnt = (int)ldlong( (char *)&du.m.doccnt );
		dsfi[fd].vol[volno].mindocid = (int)ldlong( (char *)&du.m.mindocid );
		dsfi[fd].vol[volno].maxdocid = (int)ldlong( (char *)&du.m.maxdocid );
		dsfi[fd].vol[volno].usedblkcnt =
					(int)ldlong( (char *)&du.m.usedblkcnt );
		dsfi[fd].vol[volno].reservblkcnt =
					(int)ldlong( (char *)&du.m.reservblkcnt);

		if( du.m.volsts == DS_CHILD_VOLUME )
			dsfi[fd].vol[volno].volgen = DS_CGEN_VOLUME;

		/* if master volume was move, */
		/* then change master volume information in this volume */
		if( dsfi[fd].volsts == DS_MASTER_VOLUME &&
		    dsfi[fd].ismode - ISMANULOCK != ISINPUT &&
		    strcmp( dsfi[fd].vol[0].volpath, du.m.vol[0].volpath ) )
		{
			if( isread( dsfi[fd].isfd, (char *)&du,
							ISEQUAL + ISLCKW ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				isclose( dsfi[fd].isfd );
				for( volno--; volno>=0; volno-- )
				{
					if( dsfi[fd].vol[volno].lv
						!= (struct DS_DIRVINFO *)0 )
					{
						free( dsfi[fd].vol[volno].lv );
					}
				}
				if( dsfi[fd].lm != (struct DS_DIRMINFO *)0 )
				{
					free( dsfi[fd].lm );
					free( dsfi[fd].vol );
					return( -1 );
				}
			}

			memset( du.m.vol[0].volpath, 0, DS_PATHLEN );
			strcpy( du.m.vol[0].volpath, dsfi[fd].vol[0].volpath );

			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				isclose( dsfi[fd].isfd );
				for( volno--; volno>=0; volno-- )
				{
					if( dsfi[fd].vol[volno].lv
						!= (struct DS_DIRVINFO *)0 )
					{
						free( dsfi[fd].vol[volno].lv );
					}
				}
				if( dsfi[fd].lm != (struct DS_DIRMINFO *)0 )
				{
					free( dsfi[fd].lm );
					free( dsfi[fd].vol );
					return( -1 );
				}
			}
		}

/* added by stoneshim start */
		stlong( (long)-3, (char *)&du.lv.id );
		stlong( (long)0, (char *)&du.lv.seq );
		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
		{
			dsfi[fd].vol[volno].dircnt = 0;
			dsfi[fd].vol[volno].lv = (struct DS_DIRVINFO *)0;
		}
		else
		{
			/*---------------------------------------------------------------
			** allocate memory for directory information
			**-------------------------------------------------------------*/
			dsfi[fd].vol[volno].dircnt = (int)ldlong( (char *)&du.lv.totdircnt );

			dsfi[fd].vol[volno].lv = (struct DS_DIRVINFO *)malloc(
			     sizeof( struct DS_DIRMINFO ) * dsfi[fd].vol[volno].dircnt );

			if( dsfi[fd].vol[volno].lv == (struct DS_DIRVINFO *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				isclose( dsfi[fd].isfd );
				for( volno--; volno>=0; volno-- )
				{
					if( dsfi[fd].vol[volno].lv
						!= (struct DS_DIRVINFO *)0 )
					{
						free( dsfi[fd].vol[volno].lv );
					}
				}
				if( dsfi[fd].lm != (struct DS_DIRMINFO *)0 )
					free( dsfi[fd].lm );

				free( dsfi[fd].vol );
				return( -1 );
			}

			/*---------------------------------------------------------------
			** Read  lv in isam.
			**-------------------------------------------------------------*/
			dirseq = 0;
			for( j = 0; j < dsfi[fd].vol[volno].dircnt ;j++ )
			{
				if( j/dircntperpage > dirseq )
				{
					dirseq++;
					memset( &du, 0, sizeof du );
					stlong( (long)-3, (char *)&du.lv.id );
					stlong( (long)dirseq, (char *)&du.lv.seq );

					if( isread( dsfi[fd].isfd, (char *)&du,
						ISEQUAL ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						isclose( dsfi[fd].isfd );
						for( volno--; volno>=0; volno-- )
						{
							if( dsfi[fd].vol[volno].lv
								!= (struct DS_DIRVINFO *)0 )
							{
								free( dsfi[fd].vol[volno].lv );
							}
						}
						if( dsfi[fd].lm != (struct DS_DIRMINFO *)0 )
							free( dsfi[fd].lm );

						free( dsfi[fd].vol );
						return( -1 );
					}
				}

				dsfi[fd].vol[volno].lv[j].filecnt = 
				(int)ldlong((char*)&du.lv.dirent[j%dircntperpage].filecnt );	
				strcpy( dsfi[fd].vol[volno].lv[j].dir,
					 du.lv.dirent[j%dircntperpage].dir );
			}
		} /* end of if( lv exist ) */
/*added by stoneshim end */
	} /* end of for ( save volume information ) */

	/* fd valid */
	strcpy( dsfi[fd].filepath, filepath );

	ds_nextfd();

	return( fd );
}

/******* The end of ds_fileopen.c **************************************/
