/* PI_ADDDOC() : LIB dsml */
/************************************************************************
*	insert new document from sam file				*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  char	*docpath		file path of document	*
*		  strcut DSMLFORM *docdesc	information of document	*
*	output	: int	docid			ID of document		*
************************************************************************/

#include	<stdio.h>
#include	<string.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<fcntl.h>
#include	<time.h>
#include	<iswrap.h>
#include	<errno.h>

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
|	insert new document from sam file				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_ADDDOC( int fd, int *docid, char *docpath, struct DSMLFORM *docdesc )
#else
PI_ADDDOC( fd, docid, docpath, docdesc )
int			fd;
int			*docid;
char			*docpath;
struct	DSMLFORM	*docdesc;
#endif
{
	int		verno;
	int		docFD;
#ifdef	WIN32
	struct _stat	docstat;
	int		tmpflg=0;
	char		*tmpptr;
	char		TMPPATH[DS_PATHLEN];
#else
	struct	stat	docstat;
#endif
	int		fsize;
	int		seq;
	time_t		curtime;
	int		datasize;
	int		datapos;
	int		rb;
/* added by stoneshim start */
	char		dirpath[DS_PATHLEN];
	char		*randomfile;
/* added by stoneshim end */

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( docid == (int *)0 ||
	    docpath == (char *)0 ||
	    docdesc == (struct DSMLFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( verno == 1 && docdesc->dst[0] == 'I' )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}
 
	/*---------------------------------------------------------------
	** open and get size of the sam file
	**-------------------------------------------------------------*/
#ifdef	WIN32
	if( ( docFD = open( docpath, O_RDONLY | O_BINARY ) ) < 0 )
#else
	if( ( docFD = open( docpath, O_RDONLY ) ) < 0 )
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
		close( docFD );
		return -1;
	}
	if( docstat.st_size > 0x7FFFFFFF )
	{
		l_dsmlsethyerrno( EDS_TOOLARGE_DATA );
		close( docFD );
		return -1;
	}
	fsize = (int)docstat.st_size;
	if( docdesc->dst[0] != 'I' && ds_chkfsize( fd, verno, fsize ) < 0 )
	{
		l_dsmlsethyerrno( EDS_TOOLARGE_DATA );
		close( docFD );
		return -1;
	}

	/*---------------------------------------------------------------
	** get new document id
	**-------------------------------------------------------------*/
	if( verno )
	{
		if( docdesc->dst[0] != 'I' )
		{
			if( ( *docid = ds_newdocid( fd, verno, fsize ) ) <= 0 )
			{
				close( docFD );
				return (-1);
			}
		}
		else
		{
			if( ( *docid = ds_newdocid( fd, verno, 1 ) ) <= 0 )
			{
				close( docFD );
				return (-1);
			}
		}
	}
	else
	{
		if( ( *(short *)docid = ds_newdocid( fd, verno, fsize ) ) <= 0 )
		{
			close( docFD );
			return (-1);
		}
	}
	/*---------------------------------------------------------------
	** insert header record of the document
	**-------------------------------------------------------------*/
	/* set header record of the document */
	memset (&du, 0, sizeof (du));

	if( verno < 2 )
	{
		datasize = sizeof du.h1.data;
		datapos = du.h1.data - (char *)&du;

		if( verno )
			stint( (short)*docid, (char *)&du.h1.id );
		else
			stint( *(short *)docid, (char *)&du.h1.id );
		stint( 0, (char *)&du.h1.seq );
		stlong( (long)fsize, (char *)&du.h1.size );
		stlong( (long)time( &curtime ), (char *)&du.h1.atime );
		strncpy (du.h1.title, docdesc->title, sizeof du.h1.title);
		strncpy (du.h1.fname, docdesc->fname, sizeof du.h1.fname);
		memcpy (du.h1.type, docdesc->type, sizeof du.h1.type);
	}
	else if( docdesc->dst[0] != 'I' )
	{
		datasize = dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
		datapos = du.h.data - (char *)&du;

		stlong( (long)*docid, (char *)&du.h.id );
		stlong( (long)0, (char *)&du.h.seq );
		stlong( (long)fsize, (char *)&du.h.size );
		stlong( (long)time( &curtime ), (char *)&du.h.atime );
		strncpy (du.h.title, docdesc->title, sizeof du.h.title);
		strncpy (du.h.fname, docdesc->fname, sizeof du.h.fname);
		memcpy (du.h.type, docdesc->type, sizeof du.h.type);
		memcpy( du.h.userinf, docdesc->userinf, sizeof du.h.userinf );
		du.h.dst[0] = ' ';
	}

/* added by stoneshim start */
	/*---------------------------------------------------------------
	** Check whether dst is 'I' 
	**-------------------------------------------------------------*/

	if( docdesc->dst[0] != 'I' )
	{
/* added by stoneshim end */ 

		/* read header part data of the document */
		rb = fsize > datasize ? datasize : fsize;
		fsize -= rb;
		if( read( docFD, &((char *)&du)[datapos], rb ) != rb )
		{
			l_dsmlsethyerrno( EDS_READFAIL );
			close( docFD );
			return( -1 );
		}

		/* insert header record of the document */
		if( DP_INSERT( fd, verno, du ) < 0 )
		{
			if( verno )
				l_dsmlsethyerrno( iserrno );
			close (docFD);
			return( -1 );
		}

		/*---------------------------------------------------------------
		** read and insert next data
		**-------------------------------------------------------------*/
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
			/* calculate next read size */
			rb = fsize > datasize ? datasize : fsize;
			fsize -= rb;

			if( verno < 2 )
				stint( (short)seq, (char *)&du.d1.seq );
			else
				stlong( (long)seq, (char *)&du.d.seq );

			memset( &((char *)&du)[datapos], 0, datasize );
			if( read( docFD, &((char *)&du)[datapos], rb ) != rb )
			{
				l_dsmlsethyerrno( EDS_READFAIL );
				close( docFD );
				return( -1 );
			}

			if( DP_INSERT( fd, verno, du ) < 0 )
			{
				if( verno )
					l_dsmlsethyerrno( iserrno );
				close (docFD);
				return( -1 );
			}
		}
		close( docFD );
/* added by stoneshim start */
	}
	else /* docdesc.dst == 'I' */
	{
		int volno;
		char	*env;

		/* check environment ISLOGDIR */
		if( ( env = (char *)getenv( "ISLOGDIR" ) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOT_DEF_ISLOGDIR );
			return( -1 );
		}

		if( ( volno = ds_getvolno( fd, *docid ) ) < 0 )
			return( -1 );

		if( ds_getnewdir( fd, volno, dirpath  ) < 0 )
			return( -1 );

#ifdef	WIN32
		if( ( tmpptr = getenv( "TMP" ) ) != (char *)0 )
		{
			tmpflg = 1;
			strcpy( TMPPATH, "TMP=" );
			strcat( TMPPATH, tmpptr );
			putenv( "TMP=" );
		}
		if( ( randomfile = (char *)_tempnam( dirpath, "ds" ) ) == (char *)0 )
#else
		if( ( randomfile = (char *)tempnam( dirpath, "ds" ) ) == (char *)0 )
#endif
		{
			l_dsmlsethyerrno( EDS_FILEGEN_ERR );
#ifdef	WIN32
			if( tmpflg )
				putenv( TMPPATH );
#endif
			return( -1 );
		}

#ifdef	WIN32
		if( tmpflg )
			putenv( TMPPATH );
#endif
		sprintf( dirpath,"%s.%d", randomfile, *docid );
		free( randomfile );

		if( f_copy( docpath, dirpath, 'W' ) < 0 )
			return(-1);

		/* du.h.data¿¡ dirpath ÀúÀå. */
		memset (&du, 0, sizeof (du));

		stlong( (long)*docid, (char *)&du.h.id );
		stlong( (long)0, (char *)&du.h.seq );
		stlong( (long)fsize, (char *)&du.h.size );
		stlong( (long)time( &curtime ), (char *)&du.h.atime );
		strncpy (du.h.title, docdesc->title, sizeof du.h.title);
		strncpy (du.h.fname, docdesc->fname, sizeof du.h.fname);
		memcpy (du.h.type, docdesc->type, sizeof du.h.type);
		memcpy( du.h.userinf, docdesc->userinf, sizeof du.h.userinf );
		du.h.dst[0] = 'I';
		strcpy (du.h.data, dirpath );
		
		/* du.h write */	
		if( iswrite( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		seq = 1;

		/*---------------------------------------------------------------
		** add history to logfile
		**-------------------------------------------------------------*/
		if( ds_log( DS_ADD_CODE, (char *)0, dirpath ) < 0 )
			return( -1 );

		close( docFD );
	}
/* added by stoneshim end */		
	
	/*---------------------------------------------------------------
	** change used block count
	**-------------------------------------------------------------*/
	if( verno == 2 )
		if( ds_usedblkcnt( fd, seq, 1 ) < 0 )
			return( -1 );

	return( 0 );
}

/******* The end of PI_ADDDOC.c ****************************************/
