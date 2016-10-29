/* PI_DICHK() : LIB dsml */
/************************************************************************
*	read information of the document				*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	docid			ID of document		*
************************************************************************/

#include	<string.h>
#include	<iswrap.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<errno.h>
#include	<fcntl.h>

#ifdef	WIN32
#include	<io.h>
#else
#include	<unistd.h>
#endif

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
|	check document information					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DICHK( int fd, int docid )
#else
PI_DICHK( fd, docid )
int			fd;
int			docid;
#endif
{
	int	verno;
	int	seq;
	int	seqno;
	int	hdatasize;
	int	bdatasize;
	int	lastsize;
	int	datapos;
	int	fsize;
	int	volno;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( verno < 2 )
	{
		if( docid < 1 || docid > 0x7fff )
		{
			l_dsmlsethyerrno( EDS_NOTFOUND );
			return( -1 );
		}

		stint( (short)( docid + 1 ), (char *)&du.h1.id );
		stint( 0, (char *)&du.h1.seq );
	}
	else
	{
		if( docid < 1 || docid > DS_MAX_DOC_ID )
		{
			l_dsmlsethyerrno( EDS_NOTFOUND );
			return( -1 );
		}

		stlong( (long)( docid + 1 ), (char *)&du.h.id );
		stlong( (long)0, (char *)&du.h.seq );
	}

	/*---------------------------------------------------------------
	** search document
	**-------------------------------------------------------------*/
	if( verno == 2 )
	{
		if( ( volno = ds_getvolno( fd, docid ) ) < 0 )
			return( -1 );

		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );
	}

	if( DP_REDLT( fd, verno, du ) < 0 ||
            ( verno == 2 ? (int)ldlong( (char *)&du.h.id )
			 : ldint( (char *)&du.h1.id ) ) != docid )
	{
		l_dsmlsethyerrno( EDS_NOTFOUND );
		return( -1 );
	}

/* added by stoneshim start */
	if( verno == 2 && (int)ldlong( (char *)&du.h.dst[0] ) == 'I' )
	{
		int	docFD;
#ifdef	WIN32
		struct	_stat	statbuf;
#else
		struct	stat	statbuf;
#endif
#ifdef	WIN32
		if( ( docFD = open( du.h.data, O_RDONLY | O_BINARY ) ) < 0 )
#else
		if( ( docFD = open( du.h.data, O_RDONLY ) ) < 0 )
#endif
		{
			l_dsmlsethyerrno( EDS_OPENFILE );
			return( -1 );
		}		

#ifdef	WIN32
		if( _fstat( docFD, &statbuf ) )
#else
		if( fstat( docFD, &statbuf ) )
#endif
		{
			l_dsmlsethyerrno( errno );
			close( docFD );
			return( -1 );
		}

		if( statbuf.st_size != du.h.size )
		{
			stlong( (long)statbuf.st_size, (char *)&du.h.size );
			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				close( docFD );
				return( -1 );
			}
		}

		close( docFD );
		return( 0 );
	}
/* added by stoneshim end */

	if( verno < 2 )
	{
		seq = ldint( (char *)&du.h1.seq );
		if( seq == 0 )
		{
			hdatasize = sizeof du.h1.data;
			datapos = du.h1.data - (char *)&du;
		}
		else
		{
			hdatasize = sizeof du.h1.data;
			bdatasize = sizeof du.d1.data;
			datapos = du.d1.data - (char *)&du;
		}
	}
	else
	{
		seq = (int)ldlong( (char *)&du.h.seq );
		if( seq == 0 )
		{
			hdatasize = dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
			datapos = du.h.data - (char *)&du;
		}
		else
		{
			hdatasize = dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
			bdatasize = dsfi[fd].blksz * 1024 - DS_DAT_HEADSZ - 1;
			datapos = du.d.data - (char *)&du;
		}
	}

	lastsize = seq ? bdatasize : hdatasize;
	lastsize--;
	for( ; lastsize>=0; lastsize-- )
		if( ((char *)&du)[datapos + lastsize] != (char)0 )
			break;
	lastsize++;

	if( verno < 2 )
		stint( 0, (char *)&du.h1.seq );
	else
		stlong( (long)0, (char *)&du.h.seq );

	if( DP_REDEQ( fd, verno, du ) < 0 )
	{
		if( verno )
			l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( verno < 2 )
		fsize = (int)ldlong( (char *)&du.h1.size );
	else
		fsize = (int)ldlong( (char *)&du.h.size );

	fsize -= hdatasize;
	for( seqno=0; fsize>0; seqno++ )
		fsize-=bdatasize;

	if( seqno != seq )
	{
		fsize = hdatasize;
		for( seqno=1; seqno<seq; seqno++ )
			fsize += bdatasize;
		fsize += lastsize;

		if( verno < 2 )
			stlong( (long)fsize, (char *)&du.h1.size );
		else
			stlong( (long)fsize, (char *)&du.h.size );

		if( DP_UPDATE( fd, verno, du ) < 0 )
		{
			if( verno )
				l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}

	return( 0 );
}

/******* The end of PI_DICHK.c *****************************************/
