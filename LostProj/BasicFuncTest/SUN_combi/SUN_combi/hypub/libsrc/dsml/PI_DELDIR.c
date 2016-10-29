/* PI_DELDIR() : LIB dsml */
/************************************************************************
*	delete exist internal directory					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  char	deldirpath		directory path		*
************************************************************************/

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<iswrap.h>

#ifdef	WIN32
#include	<direct.h>
#else
#include	<unistd.h>
#endif

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	delete directory						|
+----------------------------------------------------------------------*/
int	CBD1
#if	defined( __CB_STDC__ )
PI_DELDIR( int fd, char *deldirpath )
#else
PI_DELDIR( fd,deldirpath )
int	fd;
char	*deldirpath;
#endif
{
	int			verno;
	char			l_deldirpath[DS_PATHLEN];
	char			*t_delf;
	char			*t_newf;
	char			*t_deld;
	char			tmpdir[DS_PATHLEN];
	char			dummy[DS_PATHLEN];
	char			filename[56];
	int			i, j, k, l;
	int			deldirexist = 0;
	int			cnt = 0;
	int			doccnt = 0;
	char			*tmpaddr;
	int			thisdircnt;
	int			dirseq, dirix, seqno, tdirix, maxdirseq, volno;
	int			*arrfd;
	int			*tmpintaddr;
	struct	DS_DIRMINFO	lm_dir;
	struct	DS_DIRVINFO	lv_dir;

	/*---------------------------------------------------------------
	** check arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( verno != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( deldirpath == (char *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_fullpath( deldirpath, l_deldirpath ) < 0 )
		return( -1 );

	if( dsfi[fd].dircnt < 2 )
	{
		l_dsmlsethyerrno( EDS_ONEDIR_REMAIN );
		return( -1 );
	}

	for( i = 0; i < dsfi[fd].dircnt; i++ )
	{
		if( strcmp( l_deldirpath, dsfi[fd].lm[i].dir ) )
			continue;
		else
			break;
	}
	if( i == dsfi[fd].dircnt )
	{
		l_dsmlsethyerrno( EDS_NOTEXIST_DIR );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** delete dirpage in master volume
	**-------------------------------------------------------------*/	
	/* directory page in master vol delete */
	if( maxdirseq = ds_getdirseq( fd, dsfi[fd].dircnt - 1, &dirix ) < 0 )
		return( -1 );

	if( dirseq = ds_getdirseq( fd, i, &dirix ) < 0 )
		return( -1 );
	
	if( ds_volopen( fd, 0 ) < 0 )
		return( -1 );


	for( seqno=dirseq, tdirix=dirix; seqno<=maxdirseq; seqno++, tdirix=0 )
	{
		/* copy first directory informatin of next directory page */
		if( seqno != maxdirseq )
		{
			stlong( (long)-2, (char *)&du.lm.id );
			stlong( (long)(seqno + 1), (char *)&du.lm.seq );

			if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
			{
				l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
				return( -1 );
			}

			memcpy( &lm_dir, &du.lm.dirent[0], sizeof lm_dir );
		}
		else
			memset( &lm_dir, 0, sizeof lm_dir );

		/* read current directory page */
		stlong( (long)-2, (char *)&du.lm.id );
		stlong( (long)seqno, (char *)&du.lm.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			return( -1 );
		}

		/* delete directory information from current directory page */
		if( seqno == 0 )
		{
			stlong( ldlong( (char *)&du.lm.totdircnt ) - 1,
						(char *)&du.lm.totdircnt );
		}

		thisdircnt = (int)ldlong( (char *)&du.lm.thisdircnt );

		for( i=tdirix; i<thisdircnt-1; i++ )
		{
			memcpy( &du.lm.dirent[i], &du.lm.dirent[i+1],
					sizeof du.lm.dirent[i] );
		}

		memcpy( &du.lm.dirent[i], &lm_dir, sizeof lm_dir );

		if( seqno == maxdirseq )
		{
			thisdircnt--;
			stlong( (long)thisdircnt,
					(char *)&du.lm.thisdircnt );
		}
		
		if( thisdircnt == 0 ) /* last directory page */
		{
			if( isdelcurr( dsfi[fd].isfd ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			if( ds_usedblkcnt( fd, -1, 0 ) < 0 )
				return( -1 );
		}
		else
		{
			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}
		}
	} /* end of for ( delete directory information ) */

	/* if directory deleted to second directory page, */
	/* decrease count of all directory in first directory page. */
	/* if directory deleted to first directory page, decreased it already */
	if( dirseq != 0 )
	{
		stlong( (long)-2, (char *)&du.lm.id );
		stlong( (long)0, (char *)&du.lm.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			return( -1 );
		}

		stlong( ldlong( (char *)&du.lm.totdircnt ) - 1,
						(char *)&du.lm.totdircnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}

	/*--------------------------------------------------/
	** delete lm in Table
	---------------------------------------------------*/
	for( i = 0; i < dsfi[fd].dircnt; i++ )
	{
		if( strcmp( dsfi[fd].lm[i].dir, l_deldirpath ) )
			continue;
	
		for( j = i; j < dsfi[fd].dircnt-1; j++ )
		{
			memcpy( &dsfi[fd].lm[j], &dsfi[fd].lm[j+1],
				sizeof( struct DS_DIRMINFO ) );
		}
		memset( &dsfi[fd].lm[j], 0, sizeof( struct DS_DIRMINFO ) ) ;
		dsfi[fd].dircnt--;
	}

	/*---------------------------------------------------------------
	** delete dirpage in each volume & del l_deldirpath
	**-------------------------------------------------------------*/
	for( i = 0; i < dsfi[fd].volcnt; i++ )
	{

		if( ( dsfi[fd].vol[i].volgen != DS_GEN_VOLUME &&
			dsfi[fd].vol[i].volgen != DS_CGEN_VOLUME ) ||
			dsfi[fd].vol[i].dircnt == 0 )
		{
			continue;
		}

		volno = i;
		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );

		memset( &du, 0, sizeof( du ) );
		stlong( (long)-3, (char *)&du.lv.id );
		stlong( (long)0, (char *)&du.lv.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
			continue;

		cnt = 0;
		arrfd = (int *)malloc(1);
		if( arrfd == (int *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			return( -1 );
		}
		for( j = 0; j < dsfi[fd].vol[volno].dircnt; j++ )
		{
			/*----------------------------------------------------
			** delete lv in Table
			**--------------------------------------------------*/
			if( ds_splitpath( dsfi[fd].vol[volno].lv[j].dir,
							tmpdir, dummy, 1 ) < 0 )
			{
				free( arrfd );
				return ( -1 );
			}

 			if( strcmp( tmpdir, l_deldirpath ) )
				continue;
			
			for( k = j; k < dsfi[fd].vol[volno].dircnt -1; k++ )
			{
				memcpy( &dsfi[fd].vol[volno].lv[k],
					&dsfi[fd].vol[volno].lv[k+1],
					sizeof( struct DS_DIRVINFO ) );
			}
			memset( &dsfi[fd].vol[volno].lv[k], 0,
				sizeof( struct DS_DIRVINFO ) );

			dsfi[fd].vol[volno].dircnt--;

			tmpintaddr = (int *)realloc( arrfd, 4*(cnt + 1));
			if( tmpintaddr == (int *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				return( -1 );
			}
			arrfd = tmpintaddr;

			arrfd[cnt] = j;	
			cnt++;
		}

		if( !cnt )
		{
			free( arrfd );
			continue;
		}	

		/*----------------------------------------------------
		** delete dir lv (isam)
		**--------------------------------------------------*/
		for( j = 0; j < cnt; j++ )
		{
			/* directory page in each vol delete */
			if( maxdirseq = ds_getdirseq( fd, 
				dsfi[fd].vol[volno].dircnt+cnt-1, &dirix ) < 0 )
			{
				free( arrfd );
				return( -1 );
			}

			if( dirseq = ds_getdirseq( fd, arrfd[j], &dirix ) < 0 )
			{
				free( arrfd );
				return( -1 );
			}
			
			for( seqno=dirseq, tdirix=dirix; seqno<=maxdirseq; 
								seqno++, tdirix=0 )
			{
				/* copy first directory info of next directory page */
				if( seqno != maxdirseq )
				{
					stlong( (long)-3, (char *)&du.lv.id );
					stlong( (long)(seqno + 1), (char *)&du.lv.seq );

					if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
					{
						l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
						free( arrfd );
						return( -1 );
					}

					memcpy( &lv_dir, &du.lv.dirent[0],sizeof lv_dir );
				}
				else
					memset( &lv_dir, 0, sizeof lv_dir );

				/* read current directory page */
				stlong( (long)-3, (char *)&du.lv.id );
				stlong( (long)seqno, (char *)&du.lv.seq );

				if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
				{
					l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
					free( arrfd );
					return( -1 );
				}

				/* delete directory information from current directory page */
				if( seqno == 0 )
				{
					stint( (int)ldlong( (char *)&du.lv.totdircnt ) - 1,
								(char *)&du.lv.totdircnt );
				}

				thisdircnt = (int)ldlong( (char *)&du.lv.thisdircnt );

				for( l=tdirix; l<thisdircnt-1; l++ )
					memcpy( &du.lv.dirent[i], &du.lv.dirent[i+1],
							sizeof du.lv.dirent[i] );

				memcpy( &du.lv.dirent[i], &lv_dir, sizeof lv_dir );

				if( seqno == maxdirseq )
				{
					thisdircnt--;
					stlong( (long)(short)thisdircnt,
							(char *)&du.lv.thisdircnt );
				}
				
				if( thisdircnt == 0 ) /* last directory page */
				{
					if( isdelcurr( dsfi[fd].isfd ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						free( arrfd );
						return( -1 );
					}

					if( ds_usedblkcnt( fd, -1, 0 ) < 0 )
					{
						free( arrfd );
						return( -1 );
					}
				}
				else
				{
					if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
					{
						l_dsmlsethyerrno( iserrno );
						free( arrfd );
						return( -1 );
					}
				}
			} /* end of for ( delete directory information ) */

		} /* end of for ( j < cnt ) */

		/*---------------------------------------------
		**	update du.lv.totdircnt and free arrfd
		**--------------------------------------------*/
		memset( &du, 0, sizeof( du ) );
		stlong( (long)-3, (char *)&du.lv.id );
		stlong( (long)0, (char *)&du.lv.seq );

		if( !(isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 ))
		{
			stlong( ldlong( (char *)&du.lv.totdircnt ) -cnt,
					(char *)&du.lv.totdircnt );

			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( arrfd );
				return( -1 );
			}
		}

		free( arrfd );

		/*---------------------------------------------
		**	initialize t_newf....
		**--------------------------------------------*/
		if( ( t_newf = (char *)malloc(1) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			return( -1 );
		}

		if( ( t_delf = (char *)malloc(1) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			free( t_newf );
			return( -1 );
		}

		if( ( t_deld = (char *)malloc(1) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			free( t_newf );
			free( t_delf );
			return( -1 );
		}

		doccnt = 0;
		/*--------------------------------------------------/
		** update document
		---------------------------------------------------*/
		for( k = dsfi[fd].vol[volno].mindocid;
		     k <= dsfi[fd].vol[volno].maxdocid; )
		{
			memset( &du, 0, sizeof( du ) );
			stlong( (long)k, (char *)&du.h.id );
			stlong( (long)0, (char *)&du.h.seq );

			/* continue for skipping deleted page */
			if( isread( dsfi[fd].isfd, (char *)&du, ISGTEQ ) < 0 )
				break;

			k = (int)ldlong( (char *)&du.h.id ) + 1;

			if( du.h.dst[0] != 'I' )
				continue;
			
			if( ds_splitpath( du.h.data, tmpdir, dummy, 2 ) < 0 )
			{
				return( -1 );
			}

			if( strcmp( tmpdir, l_deldirpath ) )
				continue;
			
			/* move each newfile, delfile to t_newf, t_delf */
			/*---------------------------------------------------
			**	realloc t_newf, t_deld, t_delf
			---------------------------------------------------*/
			tmpaddr = (char *)realloc(t_newf, (doccnt+1)*DS_PATHLEN );
			if( tmpaddr == (char *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}
			t_newf = tmpaddr;

			tmpaddr = (char *)realloc(t_deld, (doccnt+1)*DS_PATHLEN );
			if( tmpaddr == (char *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}
			t_deld = tmpaddr;

			tmpaddr = (char *)realloc(t_delf, (doccnt+1)*DS_PATHLEN );
			if( tmpaddr == (char *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}
			t_delf = tmpaddr;

			if( ds_splitpath( du.h.data, tmpdir, filename, 1 ) < 0 )
			{	
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}

			strcpy( &t_delf[doccnt*DS_PATHLEN], du.h.data );
			strcpy( &t_deld[doccnt*DS_PATHLEN], tmpdir );

			if( ds_getnewdir( fd, volno, tmpdir ) < 0 )
			{
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}

			strcpy( &t_newf[doccnt*DS_PATHLEN], tmpdir );
			strcat( &t_newf[doccnt*DS_PATHLEN], "/" );
			strcat( &t_newf[doccnt*DS_PATHLEN], filename );

			memset( &du, 0, sizeof( du ) );
			stlong( (long)(k - 1), (char *)&du.h.id );
			stlong( (long)0, (char *)&du.h.seq );

			if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}

			strcpy( du.h.data, &t_newf[doccnt*DS_PATHLEN] );
			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				free( t_delf );
				free( t_newf );
				free( t_deld );
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			doccnt++;
			
		} /* end of for( k = dsfi[fd].vol[i]...) */

		for( k = 0; k < doccnt; k++ )
		{
			ds_log( DS_UPD_CODE, &t_delf[k*DS_PATHLEN],
						&t_newf[k*DS_PATHLEN] );

			if(f_copy( &t_delf[k*DS_PATHLEN],&t_newf[k*DS_PATHLEN], 'W' )<0 ) 
			{	
				for( l = 0; l <= k; l++ )
					remove( &t_newf[l*DS_PATHLEN] );
				free( t_delf );
				free( t_newf );
				free( t_deld );
				return( -1 );
			}
		}	
				
		for( k = 0; k < doccnt; k++ )
			remove( &t_delf[k*DS_PATHLEN] );

		for( k = 0; k < doccnt; k++ )
			rmdir( &t_deld[k*DS_PATHLEN] );	

		free( t_newf );
		free( t_delf );
		free( t_deld );

	} /* end of for( i = dsfi[fd].volcnt ) */

	return( 0 );
}

/* end of PI_DELDIR.c */
