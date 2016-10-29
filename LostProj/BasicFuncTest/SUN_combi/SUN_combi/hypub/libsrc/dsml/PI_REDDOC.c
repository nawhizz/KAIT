/* PI_REDDOC() : LIB dsml */
/************************************************************************
*	read a document to sam file					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	docid			ID of document		*
*		  char	*docpath		file path of document	*
************************************************************************/

#include	<string.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<fcntl.h>
#include	<iswrap.h>
#include	<errno.h>

#ifdef	WIN32
#include	<io.h>
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
|	read a document to sam file					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_REDDOC( int fd, int docid, char *docpath )
#else
PI_REDDOC( fd, docid, docpath )
int	fd;
int	docid;
char	*docpath;
#endif
{
	int		verno;
	int		volno;
	int		docFD;
	int		fsize;
	char		l_docpath[DS_PATHLEN];

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

	if( docpath == (char *)0 || docpath[0] == 0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}
	else
	{
		if( ds_fullpath( docpath, l_docpath ) < 0 )
			return(-1);
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
	** read header of document
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

	if( DP_REDEQ( fd, verno, du ) < 0 )
	{
		if( verno )
			l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** If dst == [I] chk size & copy to docpath
	**-------------------------------------------------------------*/
/* added by stoneshim start */
	if( verno == 2 && du.h.dst[0] == 'I' )
	{
#ifdef	WIN32
		struct _stat	docstat;
#else
		struct	stat	docstat;
#endif

#ifdef	WIN32
		if( ( docFD = open( du.h.data, O_RDONLY | O_BINARY ) ) < 0 )
#else
		if( ( docFD = open( du.h.data, O_RDONLY ) ) < 0 )
#endif
		{
			l_dsmlsethyerrno( EDS_OPENFILE );
			return -1;
		}

#ifdef	WIN32
		if( _fstat( docFD, &docstat ) )
#else
		if( fstat( docFD, &docstat ) )
#endif
		{
			l_dsmlsethyerrno( errno );
			return -1;
		}

		close( docFD );

		fsize = (int)docstat.st_size;

		if( fsize != (int)ldlong( (char *)&du.h.size ) )
		{
			l_dsmlsethyerrno( EDS_NOMATCH_FILE );
			return( -1 );
		} 

		if( f_copy( du.h.data, l_docpath, 'W' ) < 0 )
			return( -1 );

	}
	else
	{
		int		datasize;
		int		datapos;
		int		rb;
		int		seq;
/* added by stoneshim end */

		/*---------------------------------------------------------------
		** open and get size of the sam file
		**-------------------------------------------------------------*/
#ifdef	WIN32
		if( ( docFD = open( docpath, O_CREAT | O_WRONLY | O_TRUNC | O_BINARY,
									0666 ) ) < 0 )
#else
		if( ( docFD = open( docpath, O_CREAT | O_WRONLY | O_TRUNC,
									0666 ) ) < 0 )
#endif
		{
			l_dsmlsethyerrno( EDS_OPENFILE );
			return( -1 );
		}

		if( verno < 2 )
		{
			datasize = sizeof du.h1.data;
			datapos = du.h1.data - (char *)&du;
			fsize = (int)ldlong( (char *)&du.h1.size );
		}
		else
		{
			datasize = dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
			datapos = du.h.data - (char *)&du;
			fsize = (int)ldlong( (char *)&du.h.size );
		}
		if( fsize <= 0 )
		{
			close( docFD );
			return( 0 );
		}

		rb = fsize > datasize ? datasize : fsize;
		fsize -= rb;

		if( write( docFD, &((char *)&du)[datapos], rb ) != rb )
		{
			l_dsmlsethyerrno( EDS_WRITEFAIL );
			close( docFD );
			return( -1 );
		}

		if( verno < 2 )
		{
			datasize = sizeof du.d1.data;
			datapos = du.d1.data - (char *)&du;
		}
		else
		{
			datasize = dsfi[fd].blksz * 1024 - DS_DAT_HEADSZ - 1;
			datapos = du.d.data - (char *)&du;
		}

		for( seq=1; fsize; seq++ )
		{
			if( verno < 2 )
				stint( (short)seq, (char *)&du.h1.seq );
			else
				stlong( (long)seq, (char *)&du.h.seq );

			if( DP_REDEQ( fd, verno, du ) < 0 )
			{
				if( verno )
					l_dsmlsethyerrno( iserrno );
				close (docFD);
				return( -1 );
			}

			rb = fsize > datasize ? datasize : fsize;
			fsize -= rb;

			if( write( docFD, &((char *)&du)[datapos], rb ) != rb )
			{
				l_dsmlsethyerrno( EDS_WRITEFAIL );
				close( docFD );
				return( -1 );
			}
		}
		close( docFD );
	}
	return( 0 );
}

/******* The end of PI_REDDOC.c ****************************************/
