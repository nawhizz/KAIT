/* PI_DHCHK() : LIB dsml */
/************************************************************************
*	check DSML header						*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*	output	: struct DSMMFORM *dsmm_inf	DSML header information	*
************************************************************************/

#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	check master information					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DHCHK( int fd )
#else
PI_DHCHK( fd )
int	fd;
#endif
{
	register	i;
	int		currvol;
	int		nextvol;
	int		mindocid;

	int		currid;		/* unused docid cnt of curr vol */
	int		currblk;	/* unused blk cnt of curr vol */
	int		nextid;		/* unused docid cnt of next vol */
	int		nextblk;	/* unused blk cnt of next vol */
	int		skipid;		/* total cnt of miss docid */
	int		moveid;		/* move cnt of miss docid to curr vol */
	int		firstid;	/* first docid to move to next vol */

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( fd < DS_BASE_FD || fd >= DS_BASE_FD + DS_MAX_OPEN )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}
	fd -= DS_BASE_FD;

	if( !dsfi[fd].filepath[0] )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}

	if( dsfi[fd].verno[0] != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** check exist invalid volume
	**-------------------------------------------------------------*/
	for( i=0; i<dsfi[fd].volcnt; i++ )
	{
		if( dsfi[fd].vol[i].volgen != DS_GEN_VOLUME &&
		    dsfi[fd].vol[i].volgen != DS_CGEN_VOLUME &&
		    dsfi[fd].vol[i].volgen != DS_NOTGEN_VOLUME )
		{
			l_dsmlsethyerrno( EDS_CHECK_VOLUME );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** search first volume
	**-------------------------------------------------------------*/
	mindocid = DS_MAX_DOC_ID + 1;
	for( i=0; i<dsfi[fd].volcnt; i++ )
	{
		if( dsfi[fd].vol[i].volgen == DS_NOTGEN_VOLUME )
			continue;

		if( dsfi[fd].vol[i].mindocid < mindocid )
		{
			mindocid = dsfi[fd].vol[i].mindocid;
			currvol = i;
		}

		if( mindocid == 1 )
			break;
	}

	if( i >= dsfi[fd].volcnt &&
	    ( mindocid > DS_MAX_DOC_ID || mindocid < 1 ) )
	{
		l_dsmlsethyerrno( EDS_CHECK_VOLUME );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** change first volume
	**-------------------------------------------------------------*/
	if( mindocid != 1 )
	{
		if( ds_volopen( fd, currvol ) < 0 )
			return( -1 );

		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)0, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		stlong( (long)1, (char *)&du.m.mindocid );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		dsfi[fd].vol[currvol].mindocid = 1;
	}

	for( ; dsfi[fd].vol[currvol].maxdocid!=DS_MAX_DOC_ID; currvol=nextvol )
	{
		/*-------------------------------------------------------
		** search next volume
		**-----------------------------------------------------*/
		mindocid = DS_MAX_DOC_ID + 1;
		for( i=0; i<dsfi[fd].volcnt; i++ )
		{
			if( dsfi[fd].vol[i].volgen == DS_NOTGEN_VOLUME )
				continue;

			if( dsfi[fd].vol[i].mindocid >
					dsfi[fd].vol[currvol].maxdocid &&
			    dsfi[fd].vol[i].mindocid < mindocid )
			{
				mindocid = dsfi[fd].vol[i].mindocid;
				nextvol = i;
			}

			if( mindocid == dsfi[fd].vol[currvol].maxdocid + 1 )
				break;
		}

		if( i >= dsfi[fd].volcnt && mindocid > DS_MAX_DOC_ID )
		{
			mindocid = DS_MAX_DOC_ID;
			nextvol = -1;
		}
		else if( mindocid == dsfi[fd].vol[currvol].maxdocid + 1 )
			continue;

		/*-------------------------------------------------------
		** exist skip docid, the ids move to curr and next volume
		**-----------------------------------------------------*/
		if( nextvol < 0 )
		{
			skipid = mindocid - dsfi[fd].vol[currvol].maxdocid;
			moveid = mindocid - dsfi[fd].vol[currvol].maxdocid;
			nextvol = currvol;
		}
		else
		{
			currid = dsfi[fd].vol[currvol].maxdocid
					- dsfi[fd].vol[currvol].mindocid + 1
					- dsfi[fd].vol[currvol].doccnt;
			if( currid < 0 )
				currid = 0;

			nextid = dsfi[fd].vol[nextvol].maxdocid
					- dsfi[fd].vol[nextvol].mindocid + 1
					- dsfi[fd].vol[nextvol].doccnt;
			if( nextid < 0 )
				nextid = 0;
				
			skipid = dsfi[fd].vol[nextvol].mindocid
					- dsfi[fd].vol[currvol].maxdocid - 1;

			currblk = dsfi[fd].vol[currvol].maxblkcnt
					* ( 100 - DS_VOL_FREE ) / 100
					- dsfi[fd].vol[currvol].usedblkcnt;
			if( currblk < 0 )
				currblk = 0;

			nextblk = dsfi[fd].vol[nextvol].maxblkcnt
					* ( 100 - DS_VOL_FREE ) / 100
					- dsfi[fd].vol[nextvol].usedblkcnt;
			if( nextblk < 0 )
				nextblk = 0;

			if( currblk == 0 && nextblk == 0 )
				moveid = 0;
			else
			{
				moveid = ( skipid + nextid ) * currblk;
				moveid -= currid * nextblk;
				moveid /= currblk + nextblk;

				if( moveid < 0 )
					moveid = 0;
				if( moveid > skipid )
					moveid = skipid;
			}
		}

		/* move skip id to current volume */
		if( moveid > 0 )
		{
			if( ds_volopen( fd, currvol ) < 0 )
				return( -1 );

			stlong( (long)-1, (char *)&du.m.id );
			stlong( (long)0, (char *)&du.m.seq );

			if( isread( dsfi[fd].isfd, (char *)&du,
							ISEQUAL + ISLCKW ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			stlong( (long)( dsfi[fd].vol[currvol].maxdocid
					+ moveid ), (char *)&du.m.maxdocid );

			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			dsfi[fd].vol[currvol].maxdocid += moveid;

		} /* end of if( move docid to current volume ) */

		/* move skip id to next volume */
		if( skipid - moveid > 0 )
		{
			int	seq;
			int	delix;
			int	outcnt;
			int	dflno;
			int	rew_fl;
			int	chgblkcnt = 0;
			int	datasize;

			if( ds_volopen( fd, nextvol ) < 0 )
				return( -1 );

			/* change mindocid */
			stlong( (long)-1, (char *)&du.m.id );
			stlong( (long)0, (char *)&du.m.seq );

			if( isread( dsfi[fd].isfd, (char *)&du,
							ISEQUAL + ISLCKW ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			stlong( (long)( dsfi[fd].vol[nextvol].mindocid
					- moveid ), (char *)&du.m.mindocid );

			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			dsfi[fd].vol[nextvol].mindocid -= moveid;

			/* change delete page */
			datasize = dsfi[fd].blksz * 1024 - DS_DEL_HEADSZ - 1;
			firstid = dsfi[fd].vol[currvol].maxdocid + 1;
			for( delix=0, seq=-1; delix<skipid-moveid; delix++ )
			{
				if( seq != ( firstid + delix )
							/ ( datasize * 8 ) )
				{
					if( seq != -1 )
					{
						stlong( (long)outcnt,
							(char *)&du.o.outcnt );

						if( ( rew_fl
						    ? isrewcurr( dsfi[fd].isfd,
							(char *)&du )
						    : iswrite( dsfi[fd].isfd,
							(char *)&du ) ) < 0 )
						{
							l_dsmlsethyerrno( iserrno );
							return( -1 );
						}

						if( !rew_fl )
							chgblkcnt++;
					}

					seq = ( firstid + delix )
							/ ( datasize * 8 );
					stlong( (long)0, (char *)&du.o.id );
					stlong( (long)seq, (char *)&du.o.seq );

					if( isread( dsfi[fd].isfd, (char *)&du,
							ISEQUAL + ISLCKW ) < 0 )
					{
						memset( &du, 0, sizeof du );
						stlong( (long)0, (char *)&du.o.id );
						stlong( (long)seq,
							(char *)&du.o.seq );
						outcnt = 0;
						rew_fl = 0;
					}
					else
					{
						outcnt = (int)ldlong(
							(char *)&du.o.outcnt );
						rew_fl = 1;
					}

				} /* if( seq of delete page change ) */

				dflno = ( firstid + delix ) % ( datasize * 8 );

				du.o.dfl[dflno / 8] |= 1 << dflno % 8;
				outcnt ++;

			} /* end of for( movedocid ) */

			/* last delete page flush */
			if( outcnt != 0 )
			{
				stlong( (long)outcnt, (char *)&du.o.outcnt );

				if( ( rew_fl
				      ? isrewcurr( dsfi[fd].isfd, (char *)&du )
				      : iswrite( dsfi[fd].isfd,
							(char *)&du ) ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					return( -1 );
				}

				if( !rew_fl )
					chgblkcnt++;
			}

			if( ds_usedblkcnt( fd, chgblkcnt, 0 ) < 0 )
				return( -1 );

		} /* end of if( move docid to next volume ) */

	} /* end of for */

	return( 0 );
}

/******* The end of PI_DHCHK.c *****************************************/
