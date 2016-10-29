/* PI_DELDOC() : LIB dsml */
/************************************************************************
*	delete a document						*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	docid			ID of document		*
************************************************************************/

#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	delete a document						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DELDOC( int fd, int docid )
#else
PI_DELDOC( fd, docid )
int	fd;
int	docid;
#endif
{
	int	verno;
	int	volno;
	int	datasize;
	int	seq;
	int	chgblkcnt = 0;
	int	delix;
/* added by stoneshim start */
	int	i;
	int	dstflg=0;
	char	t_buf[DS_PATHLEN];
/* added by stoneshim end */

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( verno < 2 )
	{
		if( docid < 0 || docid > 0x7fff )
		{
			l_dsmlsethyerrno( EDS_INVAL_ARG );
			return( -1 );
		}
	}
	else
	{
		if( docid < 0 || docid > DS_MAX_DOC_ID )
		{
			l_dsmlsethyerrno( EDS_INVAL_ARG );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** search volume that document exist
	**-------------------------------------------------------------*/
	if( verno == 2 )
	{
		if( ( volno = ds_getvolno( fd, docid ) ) < 0 )
			return( -1 );

		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );
	}

	/*---------------------------------------------------------------
	** delete document
	**-------------------------------------------------------------*/
	if( verno < 2 )
	{
		stint( (short)docid, (char *)&du.h1.id );
		stint( 0, (char *)&du.h1.seq );
	}
	else
	{
		stlong( (long)docid, (char *)&du.h.id );
		stlong( (long)0, (char *)&du.h.seq );
	}

	if( DP_RDUEQ( fd, verno, du ) < 0 )
	{
		if( verno )
			l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

/* added by stoneshim start */
	if( verno == 2 && du.h.dst[0] == 'I' )
	{
		char	dummy[DS_PATHLEN/2];
		char	*env;

		/* check environment ISLOGDIR */
		if( ( env = (char *)getenv( "ISLOGDIR" ) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOT_DEF_ISLOGDIR );
			return( -1 );
		}

		if( ds_splitpath( du.h.data, t_buf, dummy, 1 ) < 0 )
			return( -1 );

		dstflg = 1;

		if( ds_log( DS_DEL_CODE, du.h.data, (char *)0 ) < 0 )
			return( -1 );
	}
/* added by stoneshim end */

	for( ; ; )
	{
		if( verno < 2 )
		{
			if( ldint( (char *)&du.h1.id ) != docid )
				break;
		}
		else
		{
			if( (int)ldlong( (char *)&du.h.id ) != docid )
				break;
		}

		chgblkcnt--;

		if( DP_DELETE( fd, verno, du ) < 0 )
		{
			if( verno )
				l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		if( DP_REDNX( fd, verno, du ) < 0 )
			break;
	}
/* added by stoneshim start */
	/*---------------------------------------------------------------
	** change filecnt in directory page
	**-------------------------------------------------------------*/

	if( dstflg == 1 )
	{
		int	dirix;
		int	dirseq;

		/* find directory of removed file */
		for( i = 0; i < dsfi[fd].vol[volno].dircnt; i++ )
		{
			if( !strcmp( dsfi[fd].vol[volno].lv[i].dir, t_buf ) )
				break;
		}

		if( i == dsfi[fd].vol[volno].dircnt )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			return( -1 );
		}

		dirseq = ds_getdirseq( fd, i, &dirix );

		memset( &du, 0, sizeof du );
		stlong( (long)-3, (char *)&du.lv.id );
		stlong( (long)dirseq, (char *)&du.lv.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return(-1);
		}
		stlong( (long)(dsfi[fd].vol[volno].lv[i].filecnt - 1), 
			(char *)&du.lv.dirent[dirix].filecnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

	}
/* added by stoneshim end */

	/*---------------------------------------------------------------
	** change delete page
	**-------------------------------------------------------------*/
	if( verno < 2 )
	{
		datasize = sizeof du.o1.dfl;
		seq = docid / ( datasize * 8 );
		delix = docid % ( datasize * 8 );
		stint( 0, (char *)&du.o1.id );
		stint( (short)seq, (char *)&du.o1.seq );
	}
	else
	{
		datasize = dsfi[fd].blksz * 1024 - DS_DEL_HEADSZ - 1;
		seq = docid / ( datasize * 8 );
		delix = docid % ( datasize * 8 );
		stlong( (long)0, (char *)&du.o.id );
		stlong( (long)seq, (char *)&du.o.seq );
	}

	if( DP_RDUEQ( fd, verno, du ) < 0 )
	{
		if( verno < 2 )
		{
			stint( 1, (char *)&du.o1.outcnt );
			memset( du.o1.dfl, 0, sizeof du.o1.dfl );
			du.o1.dfl[delix/8] |= 1 << delix % 8;
		}
		else
		{
			stlong( (long)1, (char *)&du.o.outcnt );
			memset( du.o.dfl, 0, datasize );
			du.o.dfl[delix/8] |= 1 << delix % 8;
		}


		if( DP_INSERT( fd, verno, du ) < 0 )
		{
			if( verno )
				l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		chgblkcnt++;
	}
	else
	{
		if( verno < 2 )
		{
			stint( ldint( (char *)&du.o1.outcnt ) + 1,
							(char *)&du.o1.outcnt );
			du.o1.dfl[delix/8] |= 1 << delix % 8;
		}
		else
		{
			stlong( ldlong( (char *)&du.o.outcnt ) + 1,
							(char *)&du.o.outcnt );
			du.o.dfl[delix/8] |= 1 << delix % 8;
		}

		if( DP_UPDATE( fd, verno, du ) < 0 )
		{
			if( verno )
				l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}
	/*---------------------------------------------------------------
	** change lv.filecnt in Table
	**-------------------------------------------------------------*/
	if( dstflg == 1 )
		dsfi[fd].vol[volno].lv[i].filecnt--;

	/*---------------------------------------------------------------
	** change used block count
	**-------------------------------------------------------------*/
	if( verno == 2 )
		if( ds_usedblkcnt( fd, chgblkcnt, -1 ) < 0 )
			return( -1 );

	return( 0 );
}

/******* The end of PI_DELDOC.c ****************************************/
