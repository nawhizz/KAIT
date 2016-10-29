/* PI_UPDDOC() : LIB dsml */
/************************************************************************
*	update a document from sam file or informations			*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	docid			ID of document		*
*		  char	*docpath		file path of document	*
*		  strcut DSMLFORM *docdesc	information of document	*
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
|	update a document from sam file or informations			|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_UPDDOC( int fd, int docid, char *docpath, struct DSMLFORM *docdesc )
#else
PI_UPDDOC( fd, docid, docpath, docdesc )
int			fd;
int			docid;
char			*docpath;
struct	DSMLFORM	*docdesc;
#endif
{
	int		verno;
	int		docFD;
#ifdef	WIN32
	struct	_stat	docstat;
	char		*tmpptr;
	char		TMPPATH[DS_PATHLEN];
	int		tmpflg=0;
#else
	struct	stat	docstat;
#endif
	time_t		curtime;
	int		datasize;
	int		datapos;
	int		rb;
	int		fsize;
	int		seq;
	int		chgblkcnt = 0;
	int		rets;
/* added by stoneshim start */
	int 		volno, i;
	char		dirpath[DS_PATHLEN];
	char		filepath[DS_PATHLEN];
	char		tmppath[DS_PATHLEN];
	char		tmppath2[DS_PATHLEN];
	char		dummy[DS_PATHLEN/2];
	int		dirix;
	int		dirseq;
	int		sam2isflg;
	char		*randomfile;
	char		*env;
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

	if( docpath == (char *)0 &&
	    ( docdesc == (struct DSMLFORM *)0 ||
	      ( docdesc->title[0] == (char)0 &&
		docdesc->fname[0] == (char)0 &&
		docdesc->type[0] == (char)0 &&
		verno == 2 ? docdesc->userinf[0] == (char)0 : 1 ) ) )
	{
		return( 0 );
	}

	if( verno != 2 && docdesc->dst[0] == 'I' )
	{
		l_dsmlsethyerrno( EDS_INVAL_VOLUME );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** open and get size of the sam file
	**-------------------------------------------------------------*/
	if( docpath != (char *)0 || docpath[0] != 0 )
	{
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
	}
	else
		fsize = -1;

	/*---------------------------------------------------------------
	** search volume that document exist
	**-------------------------------------------------------------*/
	if( verno == 2 )
	{
		if( docdesc->dst[0] != 'I' &&
		    ds_chkdocid( fd, docid, fsize ) < 0 )
		{
			if( docpath != (char *)0 )
				close( docFD );
			return( -1 );
		}

		volno = ds_getvolno( fd, docid );
		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );
	}

	/*---------------------------------------------------------------
	**
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
		if( docpath != (char *)0 )
			close( docFD );
		return( -1 );
	}

	if( verno < 2 )
	{
		datasize = sizeof du.h1.data;
		datapos = du.h1.data - (char *)&du;

		stlong( (long)time( &curtime ), (char *)&du.h1.utime );
		if( docpath != (char *)0 )
			stlong( (long)fsize, (char *)&du.h1.size );
		if( docdesc != (struct DSMLFORM *)0 )
		{
			if( docdesc->title[0] != (char)0 )
			{
				memcpy( du.h1.title, docdesc->title,
							sizeof du.h1.title );
			}
			if( docdesc->fname[0] != (char)0 )
			{
				memcpy( du.h1.fname, docdesc->fname,
							sizeof du.h1.fname );
			}
			if( docdesc->type[0] != (char)0 )
			{
				memcpy( du.h1.type, docdesc->type,
							sizeof du.h1.type );
			}
		}
	}
	else if( docdesc->dst[0] != 'I' )
	{
		datasize = dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
		datapos = du.h.data - (char *)&du;

		stlong( (long)time( &curtime ), (char *)&du.h.utime );
		if( docpath != (char *)0 )
			stlong( (long)fsize, (char *)&du.h.size );
		if( docdesc != (struct DSMLFORM *)0 )
		{
			if( docdesc->title[0] != (char)0 )
			{
				memcpy( du.h.title, docdesc->title,
							sizeof du.h.title );
			}
			if( docdesc->fname[0] != (char)0 )
			{
				memcpy( du.h.fname, docdesc->fname,
							sizeof du.h.fname );
			}
			if( docdesc->type[0] != (char)0 )
			{
				memcpy( du.h.type, docdesc->type,
							sizeof du.h.type );
			}
			if( docdesc->userinf[0] != (char)0 )
			{
				memcpy( du.h.userinf, docdesc->userinf,
							sizeof du.h.userinf );
			}

		}
	}

/* added by stoneshiim start */
	if( docdesc->dst[0] == 'I' )
	{
		int is2samflg;
		
		is2samflg = 0;

		if( du.h.dst[0] == 'I' && docpath != (char *)0 )
		{ /* copy docpath to Internal directory */
			/* check environment ISLOGDIR */
			if(( env = (char *)getenv( "ISLOGDIR" ) ) == (char *)0)
			{
				l_dsmlsethyerrno( EDS_NOT_DEF_ISLOGDIR );
				return( -1 );
			}

			if( ds_splitpath( du.h.data, tmppath, dummy, 1 ) < 0 )
				return( -1 );
#ifdef	WIN32
			if( ( tmpptr = getenv( "TMP" ) ) != (char *)0 )
			{
				tmpflg = 1;
				strcpy( TMPPATH, "TMP=" );
				strcat( TMPPATH, tmpptr );
				putenv( "TMP=" );
			}
			if((randomfile=(char *)_tempnam(tmppath, "ds"))==(char *)0)
#else
			if((randomfile=(char *)tempnam(tmppath, "ds"))==(char *)0)
#endif
			{
				close( docFD );
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
			sprintf( filepath,"%s.%d", randomfile, docid );
			
			free( randomfile );

			if( ds_log( DS_UPD_CODE, du.h.data, filepath ) < 0 )
				return( -1 );

			if( f_copy( docpath, filepath, 'W' ) < 0 )
			{
				close( docFD );
				return( -1 );
			}
		}
		if( du.h.dst[0] != 'I' )
		{ /* find directory to copy isam data */
			/* check environment ISLOGDIR */
			if(( env = (char *)getenv( "ISLOGDIR" ) ) == (char *)0)
			{
				l_dsmlsethyerrno( EDS_NOT_DEF_ISLOGDIR );
				return( -1 );
			}

			if( ds_getnewdir( fd, volno, dirpath ) < 0 )
			{
				if( docpath != (char *)0 )
					close( docFD );
				return( -1 );
			}

			is2samflg = 1;
	
#ifdef	WIN32
			if( ( tmpptr = getenv( "TMP" ) ) != (char *)0 )
			{
				tmpflg = 1;
				strcpy( TMPPATH, "TMP=" );
				strcat( TMPPATH, tmpptr );
				putenv( "TMP=" );
			}
			if((randomfile=(char *)_tempnam(dirpath, "ds"))==(char *)0)
#else
			if((randomfile=(char *)tempnam(dirpath, "ds"))==(char *)0)
#endif
			{
				if( docpath != (char *)0 )
					close( docFD );
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
			sprintf( filepath, "%s.%d", randomfile, docid );
			free( randomfile );

			if( docpath == (char *)0 )
			{ /* move isam data to Internal directory */

				if( PI_REDDOC( fd + DS_BASE_FD, docid, filepath ) < 0 )
					return( -1 );
			}
			else if( docpath[0] != 0 )
			{ /* copy docpath to Internal directory */

				if( f_copy( docpath, filepath, 'W' ) < 0 )
				{
					close( docFD );
					return( -1 );
				}
			}

			if( ds_log( DS_ADD_CODE, (char *)0, filepath ) < 0 )
				return( -1 );

		}
		/* du.h.data에 dirpath 저장. */
		memset( &du, 0, sizeof( du ) );
		stlong( (long)docid, (char *)&du.h.id );
        	stlong( (long)0, (char *)&du.h.seq );         
                                                                
                if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL+ISLCKW  ) < 0 )
                {                                               
			l_dsmlsethyerrno( iserrno );    
                	if( docpath != (char *)0 )              
                		close( docFD );                 
                	return( -1 );                           
                }                                               
                
		stlong( (long)time( &curtime ), (char *)&du.h.utime );
		if( docpath != (char *)0 )
			stlong( (long)fsize, (char *)&du.h.size );
		if( docdesc != (struct DSMLFORM *)0 )
		{
			if( docdesc->title[0] != (char)0 )
			{
				memcpy( du.h.title, docdesc->title,
							sizeof du.h.title );
			}
			if( docdesc->fname[0] != (char)0 )
			{
				memcpy( du.h.fname, docdesc->fname,
							sizeof du.h.fname );
			}
			if( docdesc->type[0] != (char)0 )
			{
				memcpy( du.h.type, docdesc->type,
							sizeof du.h.type );
			}
			if( docdesc->userinf[0] != (char)0 )
			{
				memcpy( du.h.userinf, docdesc->userinf,
							sizeof du.h.userinf );
			}
			if( docdesc->dst[0] != (char)0 )
			{
				memcpy( du.h.dst, docdesc->dst,
							sizeof du.h.dst );
			}

			memset( du.h.data, 0, ( 1024*dsfi[fd].blksz - 257 ) );
			strcpy( du.h.data, filepath );
		}
		
		/* du.h write */	
		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			if( docpath != (char *)0 )
				close( docFD );
			return( -1 );
		} 
		
		if( is2samflg )
		{
			for( seq = 1; ; seq++ )
			{
				memset( &du, 0, sizeof du );
				stlong( (long)docid, (char *)&du.d.id );
				stlong( (long)seq, (char *)&du.d.seq );
	
				if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
					break;
	
				if( isdelcurr( dsfi[fd].isfd ) < 0 )
				{
					if( docpath != (char *)0 || docpath[0] != 0 )
						close( docFD );
					return( -1 );
				}
			}

			if( ds_usedblkcnt( fd, -( seq - 1 ), 0 ) < 0 )
			{
				if( docpath != (char *)0 || docpath[0] != 0 )
					close ( docFD );
				return( -1 );
			}
		}
		close( docFD );
		return( 0 );
	}
	else /* docdesc->dst[0] != 'I' */
	{
		sam2isflg = 0;
		
		if( verno == 2 && du.h.dst[0] == 'I' )
		{
			char *env;

			sam2isflg = 1;

			if( ( env = (char *)getenv( "ISLOGDIR" ) ) == (char *)0 )
			{
				l_dsmlsethyerrno( EDS_NOT_DEF_ISLOGDIR );
				return( -1 );
			}

			sprintf( tmppath,"%s/%s", env, "dsmltmpfile.tmp" );
			strcpy( tmppath2, du.h.data );

			if( docpath == (char *)0 || docpath[0] == 0 )
			{
				if( f_copy( du.h.data, tmppath, 'W' ) < 0 )
					return( -1 );
									
				 /* docFD를 internal directory file로 대체 */ 
#ifdef	WIN32
				if( ( docFD = open( tmppath, O_RDONLY | O_BINARY ) ) < 0 )
#else
				if( ( docFD = open( tmppath, O_RDONLY ) ) < 0 )
#endif
				{
					l_dsmlsethyerrno( EDS_OPENFILE );
					remove( tmppath );
					return -1;
				}

#ifdef	WIN32
				if( _fstat( docFD, &docstat ) )
#else
				if( fstat( docFD, &docstat ) )
#endif
				{
					l_dsmlsethyerrno( errno );
					remove( tmppath );
					return -1;
				}
				fsize = (int)docstat.st_size;
				if( ds_chkdocid( fd, docid, fsize ) < 0 )
				{
					remove( tmppath );
					return -1;
				}
			}
			else
				strcpy( tmppath, docpath );
		}
		else
		{
			if( docpath == (char *)0 || docpath[0] == 0 )
				tmppath[0] = 0;
			else
				strcpy( tmppath, docpath );
		}
		
/* added by stoneshim end */
	/*---------------------------------------------------------------
	** update header record of the document
	**-------------------------------------------------------------*/
	if( docdesc->dst[0] == 'I' )
	{
		du.h.dst[0] = 'I';
	}
	else if( verno == 2 )
		du.h.dst[0] = ' ';

	if( tmppath[0] != 0 )
	{
		/* read header part data of the document */
		rb = fsize > datasize ? datasize : fsize;
		fsize -= rb;
		memset( &((char *)&du)[datapos], 0, datasize );
		if( read( docFD, &((char *)&du)[datapos], rb ) != rb )
		{
			l_dsmlsethyerrno( EDS_READFAIL );
			if( docpath != (char *)0 )
				close( docFD );
			remove( tmppath );
			return( -1 );
		}

	}

	/* update header record of the document */
	if( DP_UPDATE( fd, verno, du ) < 0 )
	{
		if( verno )
			l_dsmlsethyerrno( iserrno );
		if( tmppath[0] != 0 )
			close (docFD);
		remove( tmppath );
		return( -1 );
	}

	if( tmppath[0] != 0 )
	{
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

			rets = DP_RDUEQ( fd, verno, du );

			memset( &((char *)&du)[datapos], 0, datasize );
			if( read( docFD, &((char *)&du)[datapos], rb ) != rb )
			{
				l_dsmlsethyerrno( EDS_READFAIL );
				if( docpath != (char *)0 )
					close( docFD );
				remove( tmppath );
				return( -1 );
			}

			if( rets < 0 )
			{
				rets = DP_INSERT( fd, verno, du );

				chgblkcnt++;
			}
			else
				rets = DP_UPDATE( fd, verno, du );
			if( rets < 0 )
			{
				if( verno )
					l_dsmlsethyerrno( iserrno );
				if( docpath != (char *)0 )
					close (docFD);
				remove( tmppath );
				return( -1 );
			}
		}

		close( docFD );

		for( ; ; seq++ )
		{
			if( verno < 2 )
				stint( (short)seq, (char *)&du.d1.seq );
			else
				stlong( (long)seq, (char *)&du.d.seq );

			if( DP_RDUEQ( fd, verno, du ) < 0 )
				break;

			if( DP_DELETE( fd, verno, du ) < 0 )
			{
				if( verno )
					l_dsmlsethyerrno( iserrno );

				remove( tmppath );
				return( -1 );
			}

			chgblkcnt--;
		}
	}
/* added by stoneshim start */
		if( sam2isflg == 1 )
		{
			if( docpath == (char *)0 || docpath[0] == 0 )
			{
				remove( tmppath ); 
			}

			if( ds_splitpath( tmppath2, dirpath, dummy, 1 ) < 0 )
				return( -1 );
		
			for( i = 0; i < dsfi[fd].vol[volno].dircnt; i++ )
			{
				if( !strcmp( dsfi[fd].vol[volno].lv[i].dir, dirpath ) )
					break;
			}

			if( dirseq = ds_getdirseq( fd, i, &dirix ) < 0 )
				return( -1 );
			
			memset (&du, 0, sizeof (du));
			stlong( (long)-3, (char *)&du.lv.id );
			stlong( (long)dirseq, (char *)&du.lv.seq );

			if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 ) 
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			stlong( (long)(dsfi[fd].vol[volno].lv[i].filecnt - 1), 
					(char *)&du.lv.dirent[dirix].filecnt );

			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			if( ds_log( DS_DEL_CODE, tmppath2, (char *)0 ) < 0 )
				return( -1 );

			dsfi[fd].vol[volno].lv[i].filecnt--;
		}	
	}
/* added by stoneshim end */

	/*---------------------------------------------------------------
	** change used block count
	**-------------------------------------------------------------*/
	if( verno == 2 )
		if( ds_usedblkcnt( fd, chgblkcnt, 0 ) < 0 )
			return( -1 );

	return( 0 );
}

/******* The end of PI_UPDDOC.c ****************************************/
