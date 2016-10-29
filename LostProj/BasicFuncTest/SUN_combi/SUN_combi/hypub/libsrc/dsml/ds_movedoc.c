/* ds_movedoc() : LIB dsml internal function */
/************************************************************************
*	move document from parent volume to child volume		*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	pvolno	parent volume number			*
*		  int	cvolno	child volume number			*
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
|	Search volume to insert new document				|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_movedoc( int fd, int pvolno, int cvolno )
#else
ds_movedoc( fd, pvolno, cvolno )
int	fd;
int	pvolno;
int	cvolno;
#endif
{
	int	pisfd;
	int	cisfd;
	int	startdoc;
	int	lastdoc;
	int	maxdocid;
	int	docid;
	int	readdocid;
	int	*deldocids;
	int	delcnt;
	int	movedoccnt = 0;
	int	pchgblkcnt = 0;
	int	cchgblkcnt = 0;
	int	datasize;
	int	seq;
/* added by stoneshim start */
	int	lvcnt = 0;
	struct	DS_DIRVINFO	*t_lv;
	struct	DS_DIRVINFO	*tmpaddr;
	char	tmppath[DS_PATHLEN];
	char	dummy[DS_PATHLEN/2];
	int	t_lvexist = 0;
	int	t_seq = -1;
	int	dirseq = 0;
	int	dirix;
	int	dircntperpage;
	int	i;
	int	pdircnt, cdircnt;
		
	dircntperpage = ( dsfi[fd].blksz * 1024 - 1 - 
				DS_DIR_HEADSZ ) / DS_DIR_INFSZ;
/* added by stoneshim end */
	/*---------------------------------------------------------------
	** get real maximum document id of this volume
	**-------------------------------------------------------------*/
	if( isread( dsfi[fd].isfd, (char *)&du, ISLAST ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( dsfi[fd].vol[pvolno].maxdocid != DS_MAX_DOC_ID )
		maxdocid = dsfi[fd].vol[pvolno].maxdocid;
	else
		maxdocid = (int)ldlong( (char *)&du.h.id );
	lastdoc = (int)ldlong( (char *)&du.h.id );

	/*---------------------------------------------------------------
	** calculate start document id to move
	**-------------------------------------------------------------*/
	startdoc = maxdocid - dsfi[fd].vol[pvolno].mindocid + 1;
	startdoc *= dsfi[fd].vol[pvolno].maxblkcnt;
	startdoc /= dsfi[fd].vol[pvolno].maxblkcnt +
						dsfi[fd].vol[cvolno].maxblkcnt;
	startdoc += dsfi[fd].vol[pvolno].mindocid;

	if( ( deldocids = (int *)malloc( sizeof( int ) *
				( maxdocid - startdoc + 1 ) ) ) == (int *)0 )
	{
		l_dsmlsethyerrno( EDS_NOMORE_MEM );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** move documents
	**-------------------------------------------------------------*/
	if( ( cisfd = isopen( dsfi[fd].vol[cvolno].volpath,
					ISINOUT + ISMANULOCK + ISTRANS ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		free( deldocids );
		return( -1 );
	}
	pisfd = dsfi[fd].isfd;

	stlong( (long)startdoc, (char *)&du.h.id );
	stlong( (long)0, (char *)&du.h.seq );

	if( isread( pisfd, (char *)&du, ISGTEQ ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( cisfd );
		free( deldocids );
		return( -1 );
	}
	readdocid = (int)ldlong( (char *)&du.h.id );

	for( docid=startdoc, delcnt=0; docid<=lastdoc; docid ++ )
	{
		movedoccnt ++;

		for( ; docid!=readdocid && docid<=lastdoc; docid ++, delcnt++ )
			deldocids[delcnt] = docid;

/* added by stoneshim start */
		if( du.h.dst[0] == 'I' )
		{
			t_lvexist = 1;

			ds_splitpath( du.h.data, tmppath, dummy, 1 );

			for( i = 0; i < lvcnt; i++ )
			{
				if(!strcmp( t_lv[i].dir, tmppath ) )
				{
					t_lv[i].filecnt++;
					break;
				}
			}

			if( i >= lvcnt )
			{
				if( lvcnt )
				{
					tmpaddr = (struct DS_DIRVINFO *)realloc
						( t_lv, (lvcnt + 1)*sizeof
						(struct DS_DIRVINFO));
					if( tmpaddr == (struct DS_DIRVINFO *)0 )
					{
						l_dsmlsethyerrno(EDS_NOMORE_MEM);
						free( deldocids );
						return( -1 );
					}
				}
				else
				{
					t_lv = (struct DS_DIRVINFO *)malloc
						( sizeof
						(struct DS_DIRVINFO ) );
					if( t_lv == (struct DS_DIRVINFO *)0 )
					{
						l_dsmlsethyerrno(EDS_NOMORE_MEM);
						free( deldocids );
						return( -1 );
					}
				}	 

				strcpy( t_lv[lvcnt].dir, tmppath );
				t_lv[lvcnt].filecnt = 1;

				lvcnt++;
			}
			cdircnt = lvcnt;
		}
/* added by stoneshim end */

		for( ; docid==readdocid; )
		{
			cchgblkcnt++;
			pchgblkcnt++;

			if( isdelcurr( pisfd ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				isclose( cisfd );
				free( deldocids );
				return( -1 );
			}
			

			if( iswrite( cisfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				isclose( cisfd );
				free( t_lv );
				free( deldocids );
				return( -1 );
			}

			if( isread( pisfd, (char *)&du, ISNEXT ) < 0 )
			{
				if( iserrno != EENDFILE && iserrno != ENOREC )
				{
					l_dsmlsethyerrno( iserrno );
					isclose( cisfd );
					free( t_lv );
					free( deldocids );
					return( -1 );
				}

				readdocid = lastdoc + 2;
				break;
			}

			readdocid = (int)ldlong( (char *)&du.h.id );

		} /* end of for ( move document page ) */

	} /* end of for ( move document ) */

	/*---------------------------------------------------------------
	** change delete page of parent volume
	**-------------------------------------------------------------*/
	datasize = dsfi[fd].blksz * 1024 - DS_DEL_HEADSZ - 1;
	seq = startdoc / ( datasize * 8 );

	if( startdoc % ( datasize * 8 ) )
	{
		stlong( (long)0, (char *)&du.o.id );
		stlong( (long)seq, (char *)&du.o.seq );

		if( isread( pisfd, (char *)&du, ISEQUAL+ISLCKW ) >= 0 )
		{
			int	i, j;

			i = startdoc % ( datasize * 8 );

			if( i % 8 )
			{
				for( j=i%8; j<8; j++ )
					du.o.dfl[i] &= (unsigned char)~(1<<j);
			}

			if( i + 1 < datasize * 8 )
				memset( &du.o.dfl[i+1], 0,
							datasize * 8 - i - 1 );

			if( isrewcurr( pisfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				isclose( cisfd );
				free( t_lv );
				free( deldocids );
				return( -1 );
			}
		}

		seq++;

	} /* end of if( change a part of delete page ) */

	for( ; ; seq++ )
	{
		stlong( (long)0, (char *)&du.o.id );
		stlong( (long)seq, (char *)&du.o.seq );

		if( isread( pisfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
			break;

		if( isdelcurr( pisfd ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			isclose( cisfd );
			free( t_lv );
			free( deldocids );
			return( -1 );
		}
		pchgblkcnt++;
	}

	/*---------------------------------------------------------------
	** change delete page of child volume
	**-------------------------------------------------------------*/
	if( delcnt != 0 )
	{
		int	delix;
		int	outcnt;
		int	dflno;

		for( delix=0, seq=-1; delix<delcnt; delix++ )
		{
			if( seq != deldocids[delix] / ( datasize * 8 ) )
			{
				if( seq != -1 )
				{
					stlong( (long)outcnt,
							(char *)&du.o.outcnt );

					if( iswrite( cisfd, (char *)&du ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						isclose( cisfd );
						free( t_lv );
						free( deldocids );
						return( -1 );
					}

					cchgblkcnt++;
				}

				seq = deldocids[delix] / ( datasize * 8 );
				outcnt = 0;

				memset( &du, 0, sizeof du );
				stlong( (long)0, (char *)&du.o.id );
				stlong( (long)seq, (char *)&du.o.seq );

			} /* end of if( seq of delete page change ) */

			dflno = deldocids[delix] % ( datasize * 8 );

			du.o.dfl[dflno / 8] |= 1 << dflno % 8;
			outcnt++;
		}

		if( outcnt != 0 )
		{
			stlong( (long)outcnt, (char *)&du.o.outcnt );

			if( iswrite( cisfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				isclose( cisfd );
				free( t_lv );
				free( deldocids );
				return( -1 );
			}

			cchgblkcnt++;
		}

	} /* end of if( exist delete document id ) */

	free( deldocids );

/* added by stoneshim start */
	/*---------------------------------------------------------------
	** change lv
	**-------------------------------------------------------------*/
	if( t_lvexist )
	{
		/*---------------------------------------------------------------
		** change lv in child volume
		**-------------------------------------------------------------*/
		for( i = 0; i < lvcnt; i++ )
		{
			if( dirseq = ds_getdirseq( fd, i, &dirix ) < 0 )
			{
				free( t_lv ); 
				return( -1 );
			}

			stlong( (long)-3, (char *)&du.lv.id );
			stlong( (long)dirseq, (char *)&du.lv.seq ); 
			stlong( (long)lvcnt, (char *)&du.lv.thisdircnt ); 

			if( i == 0 )
				stlong( (long)lvcnt, (char *)&du.lv.totdircnt );
			
			if( dirix == 0 )
			{
				if( lvcnt < dircntperpage )
					stlong( (long)lvcnt,
						(char *)&du.lv.thisdircnt );
				else
				{
					stlong( (long)dircntperpage, 
						(char *)&du.lv.thisdircnt );
					lvcnt -= dircntperpage;
				}
			}

			if( dirseq == t_seq )
			{
				if( isread( cisfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					free( t_lv );
					return( -1 );
				}
			}	

			strcpy( du.lv.dirent[i].dir, t_lv[i].dir );
			stlong( (long)t_lv[i].filecnt, 
				(char *)&du.lv.dirent[i].filecnt ); 

			if( dirseq == t_seq )
			{
				if( isrewcurr( cisfd, (char *)&du ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					free( t_lv );
					return( -1 );
				}
			}
			else
			{
				if( iswrite( cisfd, (char *)&du ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					free( t_lv );
					return( -1 );
				}

				cchgblkcnt++;
			}
			t_seq = dirseq;
		}

		/*---------------------------------------------------------------
		** change lv in parent volume
		**-------------------------------------------------------------*/
		for( i = 0; i < lvcnt; i++ )
		{
			dirseq = ds_getdirseq( fd, i, &dirix );

			stlong( (long)-3, (char *)&du.lv.id );
			stlong( (long)dirseq, (char *)&du.lv.seq );

			if( isread( pisfd, (char *)&du, ISEQUAL ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( t_lv );
				return( -1 );
			}

			stlong( (long)(du.lv.dirent[dirix].filecnt - t_lv[i].filecnt),
				(char *)&du.lv.dirent[dirix].filecnt );

			if( isrewcurr( pisfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( t_lv );
				return( -1 );
			}
		}
		/*---------------------------------------------------------------
		** change lv in table
		**-------------------------------------------------------------*/
		dsfi[fd].vol[cvolno].lv = t_lv;	

		stlong( (long)-3 , (char *)&du.lv.id );
		stlong( (long)0, (char *)&du.lv.seq );

		if( isread( pisfd, (char *)&du, ISEQUAL ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			free( t_lv );
			return( -1 );
		}

		dirseq = 0;

		pdircnt = (int)ldlong( (char *)&du.lv.totdircnt );

		tmpaddr = (struct DS_DIRVINFO *)realloc( dsfi[fd].vol[pvolno].lv,
				pdircnt* sizeof(struct DS_DIRVINFO) );

		if( tmpaddr == (struct DS_DIRVINFO *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			free( t_lv );
			return( -1 );
		}

		dsfi[fd].vol[pvolno].lv = tmpaddr;

		for( i = 0; i < pdircnt ;i++ )
		{
			if( i/dircntperpage > dirseq )
			{
				dirseq++;
				memset( &du, 0, sizeof du );
				stlong( (long)-3, (char *)&du.lv.id );
				stlong( (long)dirseq, (char *)&du.lv.seq );

				if( isread( pisfd, (char *)&du, ISEQUAL ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					free( t_lv );
					return( -1 );
				}
			}

			dsfi[fd].vol[pvolno].lv[i].filecnt = 
			(int)ldlong((char*)&du.lv.dirent[i%dircntperpage].filecnt );	
			strcpy( dsfi[fd].vol[pvolno].lv[i].dir,
				 du.lv.dirent[i%dircntperpage].dir );
		}
	} /* end of change lv */	
/* added by stoneshim end */

	/*---------------------------------------------------------------
	** change volume page of parent volume
	**-------------------------------------------------------------*/
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	if( isread( pisfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		free( t_lv );
		isclose( cisfd );
		return( -1 );
	}

	stlong( ldlong( (char *)&du.m.doccnt ) - movedoccnt,
							(char *)&du.m.doccnt );
	stlong( (long)startdoc - 1, (char *)&du.m.maxdocid );
	stlong( ldlong( (char *)&du.m.usedblkcnt ) - pchgblkcnt,
						(char *)&du.m.usedblkcnt );
	stlong( ldlong( (char *)&du.m.reservblkcnt ) + pchgblkcnt,
						(char *)&du.m.reservblkcnt );

	if( isrewcurr( pisfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( cisfd );
		free( t_lv );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** change volume page of child volume
	**-------------------------------------------------------------*/
	if( isread( cisfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( cisfd );
		free( t_lv );
		return( -1 );
	}

	stlong( (long)movedoccnt, (char *)&du.m.doccnt );
	stlong( (long)startdoc, (char *)&du.m.mindocid );
	if( dsfi[fd].vol[pvolno].maxdocid == DS_MAX_DOC_ID )
		stlong( (long)DS_MAX_DOC_ID, (char *)&du.m.maxdocid );
	else
		stlong( (long)maxdocid, (char *)&du.m.maxdocid );
	stlong( ldlong( (char *)&du.m.usedblkcnt ) + cchgblkcnt,
						(char *)&du.m.usedblkcnt );
	if( (int)ldlong( (char *)&du.m.reservblkcnt ) <= cchgblkcnt )
		stlong( (long)0, (char *)&du.m.reservblkcnt );
	else
		stlong( ldlong( (char *)&du.m.reservblkcnt ) - cchgblkcnt,
						(char *)&du.m.reservblkcnt );

	if( isrewcurr( cisfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( cisfd );
		free( t_lv );
		return( -1 );
	}

	isclose( cisfd );

	/*---------------------------------------------------------------
	** change volume information in table
	**-------------------------------------------------------------*/
	dsfi[fd].vol[cvolno].doccnt += movedoccnt;
	dsfi[fd].vol[cvolno].mindocid = startdoc;
	if( dsfi[fd].vol[pvolno].maxdocid == DS_MAX_DOC_ID )
		dsfi[fd].vol[cvolno].maxdocid = DS_MAX_DOC_ID;
	else
		dsfi[fd].vol[cvolno].maxdocid = maxdocid;
	dsfi[fd].vol[cvolno].usedblkcnt += cchgblkcnt;
	if( dsfi[fd].vol[cvolno].reservblkcnt <= cchgblkcnt )
		dsfi[fd].vol[cvolno].reservblkcnt = 0;
	else
		dsfi[fd].vol[cvolno].reservblkcnt -= cchgblkcnt;
	dsfi[fd].vol[cvolno].dircnt = cdircnt;

	dsfi[fd].vol[pvolno].doccnt -= movedoccnt;
	dsfi[fd].vol[pvolno].maxdocid = startdoc - 1;
	dsfi[fd].vol[pvolno].usedblkcnt -= pchgblkcnt;
	dsfi[fd].vol[pvolno].reservblkcnt += pchgblkcnt;
	dsfi[fd].vol[pvolno].dircnt = pdircnt;

	return( 0 );
}

/******* The end of ds_movedoc.c ***************************************/
