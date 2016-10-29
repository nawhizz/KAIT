/* ds_convert() : LIB dsml internal function */
/************************************************************************
*	copy document from V1 to V2					*
*-----------------------------------------------------------------------*
*	input	: int	fd_v1	open descipter				*
*		  int	fd_v2	open descipter				*
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
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	copy document from V1 to V2					|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_convert( int fd_v1, int fd_v2 )
#else
ds_convert( fd_v1, fd_v2 )
int	fd_v1;		/* isam open number */
int	fd_v2;		/* DSML open index */
#endif
{
	union	dsmuFORM	ou;		/* buffer for V1 */
	int			*deldocids;	/* deleted docids */
	int			delcnt = 0;	/* deleted docid count */
	int			dlh;		/* data length of head for V2 */
	int			dlb;		/* data length of body for V2 */
	int			dlm;		/* data length to move */
	int			rdl;		/* real data length */
	int			lastdoc;	/* last docid */
	int			doccnt = 0;	/* copied document count */
	int			docid;		/* current processing docid */
	int			readdocid;	/* current read docid */
	int			fsize;		/* size of current document */
	int			pos1;		/* data position of V1 */
	int			pos2;		/* data position of V2 */
	int			seq;		/* sequence number */
	int			dlo;		/* data length of delete blk */
	int			usedblkcnt = 0;	/* used block count */

	/*---------------------------------------------------------------
	** get maximum document id of version 1
	**-------------------------------------------------------------*/
	if( isread( fd_v1, (char *)&ou, ISLAST ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	lastdoc = ldint( (char *)&ou.h1.id );

	/*---------------------------------------------------------------
	** for saving deleted document id
	**-------------------------------------------------------------*/
	deldocids = (int *)malloc( sizeof( int ) * lastdoc );
	if( deldocids == (int *)0 )
	{
		l_dsmlsethyerrno( errno );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** move documents
	**-------------------------------------------------------------*/
	dlh = dsfi[fd_v2].blksz * 1024 - DS_DOC_HEADSZ - 1;
	dlb = dsfi[fd_v2].blksz * 1024 - DS_DAT_HEADSZ - 1;
	usedblkcnt = dsfi[fd_v2].vol[0].usedblkcnt;

	stint( 1, (char *)&ou.h1.id );
	stint( 0, (char *)&ou.h1.seq );

	if( isread( fd_v1, (char *)&ou, ISGTEQ ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		free( deldocids );
		return( -1 );
	}
	readdocid = ldint( (char *)&ou.h1.id );

	for( docid=1; docid<=lastdoc; docid++ )
	{
		doccnt++;

		/* save deleted docid */
		for( ; docid!=readdocid && docid<=lastdoc; docid ++, delcnt++ )
			deldocids[delcnt] = docid;

		for( seq=0; docid==readdocid; )
		{
			if( ldint( (char *)&ou.h1.seq ) == 0 )
			{
				memset( &du, 0, sizeof du );
				stlong( (long)readdocid, (char *)&du.h.id );
				stlong( (long)seq, (char *)&du.h.seq );
				memcpy( &du.h.size, &ou.h1.size,
							sizeof ou.h1.size );
				memcpy( &du.h.atime, &ou.h1.atime,
							sizeof ou.h1.atime );
				memcpy( &du.h.utime, &ou.h1.utime,
							sizeof ou.h1.utime );
				memcpy( du.h.title, ou.h1.title,
							sizeof ou.h1.title );
				memcpy( du.h.fname, ou.h1.fname,
							sizeof ou.h1.fname );
				memcpy( du.h.type, ou.h1.type,
							sizeof ou.h1.type );

				fsize = (int)ldlong( (char *)&ou.h1.size );
				rdl = sizeof ou.h1.data < fsize ?
						sizeof ou.h1.data : fsize;
				pos1 = pos2 = rdl;
				fsize -= rdl;

				memcpy( du.h.data, ou.h1.data, pos1 );
			}
			else
			{
				rdl = sizeof ou.d1.data < fsize ?
						sizeof ou.d1.data : fsize;
				if( seq == 0 )
				{
					dlm = dlh - pos2 < rdl ?
						dlh - pos2 : rdl;
					memcpy( &du.h.data[pos2], ou.d1.data,
								dlm );
				}
				else
				{
					dlm = dlb - pos2 < rdl ?
						dlb - pos2 : rdl;
					memcpy( &du.d.data[pos2], ou.d1.data,
								dlm );
				}

				pos2 += dlm;
				pos1 = dlm;
				fsize -= dlm;
			}

			if( pos2 >= ( seq ? dlb : dlh ) || fsize == 0 )
			{
				if( usedblkcnt >= dsfi[fd_v2].vol[0].maxblkcnt )
				{
					l_dsmlsethyerrno( EDS_NOMORE_SPACE );
					return( -1 );
				}

				usedblkcnt++;

				if( iswrite( dsfi[fd_v2].isfd,
							(char *)&du ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					free( deldocids );
					return( -1 );
				}

				seq++;
				memset( &du, 0, sizeof du );
				stlong( (long)readdocid, (char *)&du.h.id );
				stlong( (long)seq, (char *)&du.h.seq );

				pos2 = 0;
			}

			if( ldint( (char *)&ou.h1.seq ) != 0 && pos1 < rdl )
			{
				memcpy( du.d.data, &ou.d1.data[pos1],
								rdl - pos1 );
				fsize -= rdl - pos1;

				if( fsize == 0 )
				{
					usedblkcnt++;

					if( iswrite( dsfi[fd_v2].isfd,
							(char *)&du ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						free( deldocids );
						return( -1 );
					}
				}
			}

			if( isread( fd_v1, (char *)&ou, ISNEXT ) < 0 )
			{
				if( iserrno != EENDFILE && iserrno != ENOREC )
				{
					l_dsmlsethyerrno( iserrno );
					free( deldocids );
					return( -1 );
				}

				readdocid = lastdoc + 2;
				break;
			}

			readdocid = ldint( (char *)&ou.h1.id );

		} /* end of for ( move document page ) */

	} /* end of for ( move document ) */

	/*---------------------------------------------------------------
	** change delete page of target volume
	**-------------------------------------------------------------*/
	dlo = dsfi[fd_v2].blksz * 1024 - DS_DEL_HEADSZ - 1;

	if( delcnt != 0 )
	{
		int	delix;
		int	outcnt;
		int	dflno;

		for( delix=0, seq=-1; delix<delcnt; delix++ )
		{
			if( seq != deldocids[delix] / ( dlo * 8 ) )
			{
				if( seq != -1 )
				{
					stlong( (long)outcnt,
							(char *)&du.o.outcnt );

					if( iswrite( dsfi[fd_v2].isfd,
							(char *)&du ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						free( deldocids );
						return( -1 );
					}

					usedblkcnt++;
				}

				seq = deldocids[delix] / ( dlo * 8 );
				outcnt = 0;

				memset( &du, 0, sizeof du );
				stlong( (long)0, (char *)&du.o.id );
				stlong( (long)seq, (char *)&du.o.seq );

			} /* end of if( seq of delete page change ) */

			dflno = deldocids[delix] % ( dlo * 8 );

			du.o.dfl[dflno / 8] |= 1 << dflno % 8;
			outcnt++;
		}

		if( outcnt != 0 )
		{
			stlong( (long)outcnt, (char *)&du.o.outcnt );

			if( iswrite( dsfi[fd_v2].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( deldocids );
				return( -1 );
			}

			usedblkcnt++;
		}

	} /* end of if( exist delete document id ) */

	free( deldocids );

	/*---------------------------------------------------------------
	** change volume page of target volume
	**-------------------------------------------------------------*/
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	if( isread( dsfi[fd_v2].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	stlong( (long)doccnt, (char *)&du.m.doccnt );
	stlong( (long)usedblkcnt, (char *)&du.m.usedblkcnt );

	if( isrewcurr( dsfi[fd_v2].isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** change volume information in table
	**-------------------------------------------------------------*/
	dsfi[fd_v2].vol[0].doccnt = doccnt;
	dsfi[fd_v2].vol[0].usedblkcnt = usedblkcnt;

	return( 0 );
}

/******* The end of ds_convert.c ***************************************/
