/* ds_getnewdir() : LIB dsml internal function */
/************************************************************************
*	Get new directory from lodmFORM & lodvFORM			*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	volno			volume number		*
*	output	: char	*newdirpath		new directory path	*
************************************************************************/

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<iswrap.h>
#include	<sys/types.h>
#include	<sys/stat.h>

#ifdef	WIN32
#include	<windows.h>
#include	<direct.h>
#else
#include	<dirent.h>
#endif

#include	<errno.h>

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
union		dsmuFORM	dui;

/*----------------------------------------------------------------------+
|	Get new directory from lodmFORM & lodvFORM			|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_getnewdir( int fd, int volno, char *newdirpath )
#else
ds_getnewdir( fd, volno, newdirpath )
int	fd;
int	volno;
char	*newdirpath;
#endif
{
	int	i;
	int	dirix, dirseq, fulldircnt, seldirfd;
#ifdef	WIN32
	struct	_stat	buf;
	char		*tmpptr;
	char		TMPPATH[DS_PATHLEN];
	int		tmpflg=0;
#else
	struct	stat	buf;
#endif
	char	temppath[DS_PATHLEN];
	char	*randomdir;
	int	mdirgenflg = 0;

	/*---------------------------------------------------------------
	** check whether all dir is full in lv
	**-------------------------------------------------------------*/
	fulldircnt = 0;

	if( dsfi[fd].vol[volno].dircnt == 0 
	   || dsfi[fd].vol[volno].lv == ( struct DS_DIRVINFO *)0 )	/* not exist lv */ 
	{
		if( ds_volopen( fd, 0 ) < 0 )
			return( -1 );

		/* if lv not exist, check lm */
		if( dsfi[fd].dircnt == 0 || dsfi[fd].lm == (struct DS_DIRMINFO *)0 ) 
		{
			/* if lm not exist, make lm */
			strcpy( temppath, dsfi[fd].filepath );

			memset( &dui, 0, sizeof dui );
			stlong( (long)-2, (char *)&dui.lm.id );
			stlong( (long)0, (char *)&dui.lm.seq );
			stlong( (long)1, (char *)&dui.lm.totdircnt ); 		
			stlong( (long)1, (char *)&dui.lm.thisdircnt ); 		
			strcpy( dui.lm.dirent[0].dir, temppath );
			stlong( (long)0, (char *)&dui.lm.dirent[0].dircnt ); 		

			if( iswrite( dsfi[fd].isfd, (char *)&dui ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			if( ds_usedblkcnt( fd, 1, 0 ) < 0 )
				return( -1 );

			/* make parent directory */
#ifdef	WIN32
			if( _stat( temppath, &buf ) < 0 )
#else
			if( stat( temppath, &buf ) < 0 )
#endif
			{
#ifdef	WIN32
			 	if( mkdir( temppath ) != 0 ) 
#else
			 	if( mkdir( temppath, 0775 ) != 0 ) 
#endif
				{
					l_dsmlsethyerrno( errno );
					return( -1 );
				}
				mdirgenflg = 1;
			}
#ifdef	WIN32
			else if( !( buf.st_mode & _S_IFDIR ) )
#else
			else if( !S_ISDIR( buf.st_mode ) )
#endif
			{
				l_dsmlsethyerrno( EDS_INVALID_DIR );
				return( -1 );
			}

			/* save lm to Table */
			dsfi[fd].lm = (struct DS_DIRMINFO *)malloc(
					sizeof( struct DS_DIRMINFO ) );

			if( dsfi[fd].lm == (struct DS_DIRMINFO *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				if( mdirgenflg )
					rmdir( temppath );
				return( -1 );
			}	
	
			dsfi[fd].dircnt = 1;
			dsfi[fd].lm[0].dircnt = 0;
			strcpy( dsfi[fd].lm[0].dir, temppath );
		}

		/*-------------------------------------------------- 
		**	find smallest dir in lm & update lm 
		--------------------------------------------------*/
		seldirfd = 0;
		for( i = 1; i < dsfi[fd].dircnt; i++ )
		{
			if( dsfi[fd].lm[seldirfd].dircnt > dsfi[fd].lm[i].dircnt ) 
				seldirfd = i; 
		}

		dsfi[fd].lm[seldirfd].dircnt++;

		/* check lmdir exist and make parent directory if not */
#ifdef	WIN32
		if( _stat( dsfi[fd].lm[seldirfd].dir, &buf ) < 0 )
#else
		if( stat( dsfi[fd].lm[seldirfd].dir, &buf ) < 0 )
#endif
		{
#ifdef	WIN32
			if( mkdir( dsfi[fd].lm[seldirfd].dir ) != 0 )
#else
			if( mkdir( dsfi[fd].lm[seldirfd].dir, 0775 ) != 0 )
#endif
			{
				l_dsmlsethyerrno( errno );
				return( -1 );
			}
		}
#ifdef	WIN32
		else if( !( buf.st_mode & _S_IFDIR ) )
#else
		else if( !S_ISDIR( buf.st_mode ) )
#endif
		{
			l_dsmlsethyerrno( EDS_INVALID_DIR );
			return( -1 );
		}

#ifdef	WIN32
		if( ( tmpptr = getenv( "TMP" ) ) != (char *)0 )
		{
			tmpflg = 1;
			strcpy( TMPPATH, "TMP=" );
			strcat( TMPPATH, tmpptr );
			putenv( "TMP=" );
		}
		if( ( randomdir = (char *)_tempnam( dsfi[fd].lm[seldirfd].dir, "ds" ) )
			 == (char *)0 )
#else
		if( ( randomdir = (char *)tempnam( dsfi[fd].lm[seldirfd].dir, "ds" ) )
			 == (char *)0 )
#endif
		{
			l_dsmlsethyerrno( errno );
#ifdef	WIN32
			if( tmpflg )
				putenv( TMPPATH );
#endif
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			return( -1 );
		}

#ifdef	WIN32
		if( tmpflg )
			putenv( TMPPATH );
#endif
		strcpy( newdirpath, randomdir );
		free( randomdir );

		dirseq = ds_getdirseq( fd, seldirfd, &dirix );

		memset( &dui, 0, sizeof dui );
		stlong( (long)-2, (char *)&dui.lm.id );
		stlong( (long)dirseq, (char *)&dui.lm.seq );

		if( isread( dsfi[fd].isfd, (char *)&dui, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			return( -1 );
		}

		stlong( (long)dsfi[fd].lm[seldirfd].dircnt, 
					(char *)&dui.lm.dirent[dirix].dircnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&dui ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			return( -1 );
		}

		/*----------------------------------- 
		**	make lv 
		------------------------------------*/	
	 	if( ds_volopen( fd, volno ) < 0 )
			return( -1 );

		memset (&dui, 0, sizeof (dui));
		stlong( (long)-3, (char *)&dui.lv.id );
		stlong( (long)0, (char *)&dui.lv.seq );
		stlong( (long)1, (char *)&dui.lv.totdircnt );
		stlong( (long)1, (char *)&dui.lv.thisdircnt );
		stlong( (long)1, (char *)&dui.lv.dirent[0].filecnt );
		strcpy( dui.lv.dirent[0].dir, newdirpath );
		
		if( iswrite( dsfi[fd].isfd, (char *)&dui ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			return( -1 );
		}

#ifdef	WIN32
		if( mkdir( newdirpath ) != 0 ) 
#else
		if( mkdir( newdirpath, 0775 ) != 0 ) 
#endif
		{
			l_dsmlsethyerrno( errno );
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			return( -1 );
		}

		if( ds_usedblkcnt( fd, 1, 0 ) < 0 )
		{
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			return( -1 );
		}

		/* save lv to Table */
		dsfi[fd].vol[volno].lv = (struct DS_DIRVINFO *)malloc(
					sizeof( struct DS_DIRVINFO ) );

		if( dsfi[fd].vol[volno].lv == (struct DS_DIRVINFO *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			if( mdirgenflg )
			{
				rmdir( temppath );
				free( dsfi[fd].lm );
			}
			rmdir( newdirpath );
			return( -1 );
		}	

		dsfi[fd].vol[volno].dircnt = 1;
		dsfi[fd].vol[volno].lv[0].filecnt = 1;
		strcpy( dsfi[fd].vol[volno].lv[0].dir, newdirpath );

		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );

		return( 0 );
	}  /* end of if( not exist lv ) */

	for( i = 0; i < dsfi[fd].vol[volno].dircnt; i++ )
	{
		if( dsfi[fd].vol[volno].lv[i].filecnt >= DS_MAXFILENO )
			fulldircnt++;
	}
	
	/*---------------------------------------------------
	** if filecnt >= 500 in all directory of lv
	** find dir in lm & update lm
	** and add new dir in lv
	----------------------------------------------------*/
	if( fulldircnt == dsfi[fd].vol[volno].dircnt )
	{
		struct	DS_DIRVINFO	*tmpaddr;

		/*--------------------------------
		** find dir in lm and update lm  
		--------------------------------*/
	 	if( ds_volopen( fd, 0 ) < 0 )
			return( -1 ); 	

		seldirfd = 0;
		for( i = 1; i < dsfi[fd].dircnt; i++ )
		{
			if( dsfi[fd].lm[seldirfd].dircnt > dsfi[fd].lm[i].dircnt )
				seldirfd = i; 
		}

		dsfi[fd].lm[seldirfd].dircnt++;

#ifdef	WIN32
		if( ( tmpptr = getenv( "TMP" ) ) != (char *)0 )
		{
			tmpflg = 1;
			strcpy( TMPPATH, "TMP=" );
			strcat( TMPPATH, tmpptr );
			putenv( "TMP=" );
		}
		if( ( randomdir = (char *)_tempnam( dsfi[fd].lm[seldirfd].dir, "ds" ) )
			 == (char *)0 )
#else
		if( ( randomdir = (char *)tempnam( dsfi[fd].lm[seldirfd].dir, "ds" ) )
			 == (char *)0 )
#endif
		{
			l_dsmlsethyerrno( errno );
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
		strcpy( newdirpath, randomdir );
		free( randomdir );

		dirseq = ds_getdirseq( fd, seldirfd, &dirix );

		memset (&dui, 0, sizeof (dui));
		stlong( (long)-2, (char *)&dui.lm.id );
		stlong( (long)dirseq, (char *)&dui.lm.seq );

		if( isread( dsfi[fd].isfd, (char *)&dui, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			return( -1 );
		}

		stlong( (long)dsfi[fd].lm[seldirfd].dircnt, 
					(char *)&dui.lm.dirent[dirix].dircnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&dui ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return(-1);
		}
		
		/*----------------------------
		** update lv in Table 
		----------------------------*/
		seldirfd = dsfi[fd].vol[volno].dircnt++;
			/* seldirfd is dirno that a new dir is added to */

		tmpaddr = (struct DS_DIRVINFO *)realloc( dsfi[fd].vol[volno].lv,
			sizeof(struct DS_DIRVINFO)*(dsfi[fd].vol[volno].dircnt + 1 ) );

		if( tmpaddr == (struct DS_DIRVINFO *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			return( -1 );
		}
		dsfi[fd].vol[volno].lv = tmpaddr;

		memset( &dsfi[fd].vol[volno].lv[seldirfd], 0,
			sizeof( struct DS_DIRVINFO ) ); 
		dsfi[fd].vol[volno].lv[seldirfd].filecnt++;
		strcpy( dsfi[fd].vol[volno].lv[seldirfd].dir, newdirpath );

		/*---------------------------------*/
		/* add new dir to lv 
		/*---------------------------------*/
		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );

		dirseq = ds_getdirseq( fd, seldirfd, &dirix );

		memset (&dui, 0, sizeof (dui));
		stlong( (long)-3, (char *)&dui.lv.id );
		stlong( (long)dirseq, (char *)&dui.lv.seq );

		if( dirix )	/* directory page exist */
		{
			if( isread( dsfi[fd].isfd, (char *)&dui, ISEQUAL + ISLCKW ) < 0 )
			{
				l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
				return( -1 );
			}
		}

		if( dirseq == 0 )	/* new dir insert to first directory page */
		{
			stlong( (long)dsfi[fd].vol[volno].dircnt, (char *)&dui.lv.totdircnt );
			stlong( (long)dsfi[fd].vol[volno].dircnt, (char *)&dui.lv.thisdircnt );

			strcpy( dui.lv.dirent[dirix].dir, newdirpath );
			stlong( (long)1, (char *)&dui.lv.dirent[dirix].filecnt );
		}
		else	/* new dir insert to second dir page */
		{
			stlong( (long)dirix + 1, (char *)&dui.lv.thisdircnt );
			memset( dui.lv.dirent[dirix].dir, 0, DS_PATHLEN );
			strcpy( dui.lv.dirent[dirix].dir, newdirpath );
			stlong( (long)1, (char *)&dui.lv.dirent[dirix].filecnt );
		}

		if( dirix )
		{
			if( isrewcurr( dsfi[fd].isfd, (char *)&dui ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}
		}
		else
		{
			if( iswrite( dsfi[fd].isfd, (char *)&dui ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			if( ds_usedblkcnt( fd, 1, 0 ) < 0 )
			{
				return( -1 );
			}
		}

		if( dirseq )
		{
			int totdircnt;

			stlong( (long)-3, (char *)&dui.lv.id );
			stlong( (long)0, (char *)&dui.lv.seq );

			if( isread( dsfi[fd].isfd, (char *)&dui, ISEQUAL + ISLCKW ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			totdircnt = (int)ldlong( (char *)&dui.lv.totdircnt );
			totdircnt++;
			stlong( (long)totdircnt, (char *)&dui.lv.totdircnt ); 

			if( isrewcurr( dsfi[fd].isfd, (char *)&dui ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}
		}
	}
	else  /* dir exist that filecnt < 500 in lv*/
	{ /* filecnt가 가장 적은 dir을 찾아 newdirpath에 저장한다. */
		seldirfd = 0;
		for( i = 1; i < dsfi[fd].vol[volno].dircnt ; i++ )
		{
			if( dsfi[fd].vol[volno].lv[seldirfd].filecnt
			   > dsfi[fd].vol[volno].lv[i].filecnt )
				seldirfd = i; 
		}
		
		dsfi[fd].vol[volno].lv[seldirfd].filecnt++;

		dirseq = ds_getdirseq( fd, seldirfd, &dirix );

		stlong( (long)-3, (char *)&dui.lv.id );
		stlong( (long)dirseq, (char *)&dui.lv.seq );

		if( isread( dsfi[fd].isfd, (char *)&dui, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			return( -1 );
		}

		stlong( (long)dsfi[fd].vol[volno].lv[seldirfd].filecnt, 
					(char *)&dui.lv.dirent[dirix].filecnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&dui ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		strcpy( newdirpath, dsfi[fd].vol[volno].lv[seldirfd].dir );
	}
	
#ifdef	WIN32
	if( _stat( newdirpath, &buf ) < 0 )
#else
	if( stat( newdirpath, &buf ) < 0 )
#endif
	{
#ifdef	WIN32
		if( mkdir( newdirpath ) != 0 ) 
#else
		if( mkdir( newdirpath, 0775 ) != 0 ) 
#endif
		{
			l_dsmlsethyerrno( errno );
			return( -1 );
		}
	}
#ifdef	WIN32
	else if( !( buf.st_mode & _S_IFDIR ) )
#else
	else if( !S_ISDIR( buf.st_mode ) )
#endif
	{
		l_dsmlsethyerrno( EDS_INVALID_DIR );
		return( -1 );
	}

	if( ds_volopen( fd, volno ) < 0 )
		return( -1 );	

	return( 0 );
}
