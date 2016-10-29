/* PI_UPDDIRINFO() : LIB dsml */
/************************************************************************
*	update directory information in DSML file			*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  char	*olddirpath		directory path		*
*		  char	*newdirpath		directory path		*
************************************************************************/

#include	<stdlib.h>
#include	<string.h>
#include	<iswrap.h>
#include	<sys/types.h>
#include	<sys/stat.h>

#ifdef	WIN32
#include	<direct.h>
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
|	update directory information					|
+----------------------------------------------------------------------*/
int	CBD1
#if	defined( __CB_STDC__ )
PI_UPDDIRINFO( int fd, char *olddirpath, char *newdirpath )
#else
PI_UPDDIRINFO( fd, olddirpath, newdirpath )
int	fd;
char	*olddirpath;
char	*newdirpath;
#endif
{
	int	verno;
#ifdef	WIN32
	struct	_stat	buf;
#else
	struct	stat	buf;
#endif
	char	l_olddirpath[DS_PATHLEN];
	char	l_newdirpath[DS_PATHLEN];
	char	lv_newdirpath[DS_PATHLEN];
	char	*t_newf;
	char	*t_newd;
	char	temppath[DS_PATHLEN], tempfile[DS_PATHLEN];
	char	*tmpaddr;
	int	cnt = 0;
	int	t_cnt = 0;
	int	dirseq, dirix;
	int	*arrfd, *tmpintaddr;
	int	i, j, k;
	int	volno;

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

	if( olddirpath == (char *)0 || olddirpath[0] == 0 || 
		newdirpath == (char *)0 || newdirpath[0] == 0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

#ifdef	WIN32
	if( olddirpath[0] != '/' )
#else
	if( olddirpath[1] != ':' || olddirpath[2] != '\\' )
#endif
	{
		if( ds_fullpath( olddirpath, l_olddirpath ) < 0 )
			return( -1 );
	}
	else
	{
		strcpy( l_olddirpath, olddirpath );
	}

	if( ds_fullpath( newdirpath, l_newdirpath ) < 0 )
		return( -1 );

	for( i = 0; i < dsfi[fd].dircnt; i++ )
	{
		if( !strcmp( l_newdirpath, dsfi[fd].lm[i].dir ) )
		{
			l_dsmlsethyerrno( EDS_EXIST_DIR );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** get index of lm to be changed 
	**-------------------------------------------------------------*/	
	for( i = 0; i < dsfi[fd].dircnt; i++ )
	{
		if( strcmp( l_olddirpath, dsfi[fd].lm[i].dir ) )
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
	** update directory on directory page in master volume
	**-------------------------------------------------------------*/	
	if( dirseq = ds_getdirseq( fd, i, &dirix ) < 0 )
		return( -1 );

	if( ds_volopen( fd, 0 ) < 0 )
		return -1;

	memset( &du, 0, sizeof( du ) );
	stlong( (long)-2, (char *)&du.lm.id );
	stlong( (long)dirseq, (char *)&du.lm.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL+ISLCKW ) )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	strcpy( du.lm.dirent[dirix].dir, l_newdirpath ); 

	if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}
	
	if( du.lm.dirent[dirix].dircnt == 0 )
	{
		/*-----------------------------------------------------------------
		**	 update lm in Table
		-----------------------------------------------------------------*/
		for( i = 0; i < dsfi[fd].dircnt; i++ )
		{
			if( !strcmp( dsfi[fd].lm[i].dir, l_olddirpath ) )
			{
				strcpy( dsfi[fd].lm[i].dir, l_newdirpath );
				break;
			}
		}
		return 0;
	}

#ifdef	WIN32
	if( _stat( l_newdirpath, &buf ) < 0 || !( buf.st_mode & _S_IFDIR ) )
#else
	if( stat( l_newdirpath, &buf ) < 0 || !S_ISDIR( buf.st_mode ) )
#endif
	{
		l_dsmlsethyerrno( EDS_NOTEXIST_DIR );
		return( -1 );
	}
			
	/*---------------------------------------------------------------
	** update directory on directory page in each volume
	**-------------------------------------------------------------*/	
	for( i = 0; i < dsfi[fd].volcnt; i++ )
	{
		if( ( dsfi[fd].vol[i].volgen != DS_GEN_VOLUME &&
			dsfi[fd].vol[i].volgen != DS_CGEN_VOLUME )||
			dsfi[fd].vol[i].dircnt == 0 )
		{
			continue;
		}

		volno = i;
		if( ds_volopen( fd, volno ) < 0 )
			return -1;

		/*-----------------------------------------------------------------
		**	get index of lv to be changed 
		-----------------------------------------------------------------*/
		arrfd = (int *)malloc(1);
		if( arrfd == (int *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			return( -1 );
		}
		t_cnt = 0;
		for( j = 0; j < dsfi[fd].vol[volno].dircnt; j++ )
		{
			if( ds_splitpath( dsfi[fd].vol[volno].lv[j].dir,
						 temppath, tempfile, 1 ) < 0 )
			{
				free( arrfd );
				return( -1 );
			}
			
			if( strcmp( temppath, l_olddirpath ) )
				continue;
				
			tmpintaddr = (int *)realloc( arrfd, 4*(t_cnt + 1));
			if( tmpintaddr == (int *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				free( arrfd );
				return( -1 );
			}
			arrfd = tmpintaddr;

			arrfd[t_cnt] = j;	
			t_cnt++;
		}

		if( !t_cnt )
		{
			free( arrfd );
			continue;
		}

		/*-----------------------------------------------------------------
		**	 update lv
		-----------------------------------------------------------------*/
		for( j = 0; j < t_cnt; j++ )
		{
			if( dirseq = ds_getdirseq( fd, arrfd[j], &dirix ) < 0 )
			{
				free( arrfd );
				return( -1 );
			}

			memset( &du, 0, sizeof( du ) );
			stlong( (long)-3, (char *)&du.lv.id );
			stlong( (long)dirseq, (char *)&du.lv.seq );

			if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL+ISLCKW ) < 0 )
				continue;

			if( ds_splitpath( dsfi[fd].vol[volno].lv[j].dir,
						 temppath, tempfile, 1 ) < 0 )
			{
				free( arrfd );
				return( -1 );
			}
				
			strcpy( lv_newdirpath, l_newdirpath );
			strcat( lv_newdirpath, "/" );
			strcat( lv_newdirpath, tempfile );

			memset( du.lv.dirent[dirix].dir, 0, DS_PATHLEN );
			strcpy( du.lv.dirent[dirix].dir, lv_newdirpath );
			
			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( arrfd );
				return( -1 );
			}	
		}
		
		/*---------------------------------------------
		**	initialize t_newf....
		**--------------------------------------------*/
		if( ( t_newf = (char *)malloc(1) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			free( arrfd );
			return( -1 );
		}
		
		if( ( t_newd = (char *)malloc(1) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			free( arrfd );
			free( t_newf );
			return( -1 );
		}

		/*-----------------------------------------------------------------
		**	 update document
		-----------------------------------------------------------------*/
		cnt = 0;
		for( k = dsfi[fd].vol[i].mindocid; k <= dsfi[fd].vol[i].maxdocid; )
		{
			memset( &du, 0, sizeof( du ) );
			stlong( (long)k, (char *)&du.h.id );
			stlong( (long)0, (char *)&du.h.seq );

			if( isread( dsfi[fd].isfd, (char *)&du, ISGTEQ ) )
				break;
				
			k = (int)ldlong( (char *)&du.h.id ) + 1;

			if( du.h.dst[0] != 'I' )
				continue;
			
			if( ds_splitpath( du.h.data, temppath, tempfile, 2 ) < 0 )
			{
				free( t_newd );
				free( t_newf );
				free( arrfd );
				return( -1 );
			}
				
			if( strcmp( temppath, l_olddirpath ) )
				continue;
			
			/*---------------------------------------------------
			**	realloc t_newf, t_deld, t_delf
			---------------------------------------------------*/
			tmpaddr = (char *)realloc(t_newf, (cnt+1)*DS_PATHLEN );
			if( tmpaddr == (char *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				free( t_newf );
				free( t_newd );
				free( arrfd );
				return( -1 );
			}
			t_newf = tmpaddr;
			
			tmpaddr = (char *)realloc(t_newd, (cnt+1)*DS_PATHLEN );
			if( tmpaddr == (char *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				free( t_newf );
				free( t_newd );
				free( arrfd );
				return( -1 );
			}
			t_newd = tmpaddr;

			strcpy( &t_newf[cnt*DS_PATHLEN], l_newdirpath );
			strcat( &t_newf[cnt*DS_PATHLEN], "/" );
			strcat( &t_newf[cnt*DS_PATHLEN], tempfile );

			if( ds_splitpath( &t_newf[cnt*DS_PATHLEN], temppath, tempfile, 1 ) < 0 )
			{
				free( arrfd );
				free( t_newf );
				free( t_newd );
				return( -1 );
			}

			strcpy( &t_newd[cnt*DS_PATHLEN], temppath );

			strcpy( du.h.data, &t_newf[cnt*DS_PATHLEN] );

			if( isrewrite( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				free( arrfd );
				free( t_newf );
				free( t_newd );
				return( -1 );
			} 
			
			cnt++;
		} /* end of for( k = dsfi[fd].vol[i]...) */


		if( !cnt )
		{
			free( arrfd );
			free( t_newf );
			free( t_newd );
			continue;
		}

		for( k = 0; k < cnt; k++ )
		{
#ifdef	WIN32
			if( _stat( &t_newd[k*DS_PATHLEN], &buf )  < 0 ||
					!( buf.st_mode & _S_IFDIR ) )
#else
			if( stat( &t_newd[k*DS_PATHLEN], &buf )  < 0 ||
					 !S_ISDIR( buf.st_mode ) )
#endif
			{
				l_dsmlsethyerrno( EDS_NOTEXIST_DIR );
				free( arrfd );
				free( t_newf );
				free( t_newd );
				return( -1 );
			}

#ifdef	WIN32
			if( _stat( &t_newf[k*DS_PATHLEN], &buf ) < 0 ||
					( buf.st_mode & _S_IFDIR ) )
#else
			if( stat( &t_newf[k*DS_PATHLEN], &buf ) < 0 ||
					 S_ISDIR( buf.st_mode ) )
#endif
			{
				l_dsmlsethyerrno( EDS_NOTEXIST_FILE );
				free( arrfd );
				free( t_newf );
				free( t_newd );
				return( -1 );
			}
		}

		free( arrfd );
		free( t_newf );
		free( t_newd );

		/*-------------------------------------------------------------
		**	 update lv in Table
		-------------------------------------------------------------*/
		for( j = 0; j < t_cnt; j++ )
		{
			ds_splitpath( dsfi[fd].vol[i].lv[arrfd[j]].dir,
				temppath, tempfile, 1 );

			strcpy( dsfi[fd].vol[i].lv[arrfd[j]].dir,
				l_newdirpath );
			strcat( dsfi[fd].vol[i].lv[arrfd[j]].dir,
				tempfile );
		}

	} /* end of for( i = dsfi[fd].volcnt ) */

	/*-----------------------------------------------------------------
	**	 update lm in Table
	-----------------------------------------------------------------*/
	for( i = 0; i < dsfi[fd].dircnt; i++ )
	{
		if( !strcmp( dsfi[fd].lm[i].dir, l_olddirpath ) )
		{
			strcpy( dsfi[fd].lm[i].dir, l_newdirpath );
			break;
		}
	}
	
	return( 0 );
}

/* end of PI_UPDDIRINFO.c */
