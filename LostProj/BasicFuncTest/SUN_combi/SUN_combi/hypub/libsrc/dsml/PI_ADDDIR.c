/* PI_ADDDIR() : LIB dsml */
/************************************************************************
*	add new internal directory					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  char	*dirpath		directory path		*
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
|	add new directory						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_ADDDIR( int fd, char *dirpath )
#else
PI_ADDDIR( fd, dirpath )
int	fd;
char	*dirpath;
#endif
{
	int	verno;
	int	dirseq, dirix, dircntperpage;
	int	i, j;
	char	l_dirpath[DS_PATHLEN];
	struct	DS_DIRMINFO	*tmpaddr;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( dirpath == (char *)0 || dirpath[0] == 0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_fullpath( dirpath, l_dirpath ) < 0 )
		return( -1 );

	for( i = 0; i < dsfi[fd].dircnt; i++ )
	{
		if( !strcmp( l_dirpath, dsfi[fd].lm[i].dir ) )
		{
			l_dsmlsethyerrno( EDS_EXIST_DIR );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** Reload dsfi[fd].lm from lm in isam for syncronization.
	**-------------------------------------------------------------*/
	if( ds_volopen( fd, 0 ) < 0 )
		return( -1 );

	memset( &du, 0, sizeof du );
	stlong( (long)-2, (char *)&du.lm.id );
	stlong( (long)0, (char *)&du.lm.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
	{
		if( ( dsfi[fd].lm = (struct DS_DIRMINFO *)malloc( 
			sizeof( struct DS_DIRMINFO ) ) ) == 
			(struct DS_DIRMINFO *) 0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			return( -1 );
		}

		dsfi[fd].dircnt = 0;
	}
	else
	{
		/*---------------------------------------------------------------
		** allocate memory for parent directory information
		**-------------------------------------------------------------*/
		dircntperpage = ( dsfi[fd].blksz * 1024 - 1 -
				 DS_DIR_HEADSZ ) / DS_DIR_INFSZ;

		dsfi[fd].dircnt = (int)ldlong( (char *)&du.lm.totdircnt );

		if( dsfi[fd].lm == (struct DS_DIRMINFO *)0 )
		{
			if( ( dsfi[fd].lm = (struct DS_DIRMINFO *)malloc( 
				sizeof( struct DS_DIRMINFO ) ) ) ==
				(struct DS_DIRMINFO *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				return( -1 );
			}
		}
		else
		{	
			tmpaddr = (struct DS_DIRMINFO *)realloc( dsfi[fd].lm,
				sizeof( struct DS_DIRMINFO )*(dsfi[fd].dircnt+1) );

			if( tmpaddr == (struct DS_DIRMINFO *)0 )
			{
				l_dsmlsethyerrno( EDS_NOMORE_MEM );
				return( -1 );
			}

			dsfi[fd].lm = tmpaddr;
		}

		/*---------------------------------------------------------------
		** Read parent directory information
		**-------------------------------------------------------------*/
		dirseq = 0;
		for( j = 0; j < dsfi[fd].dircnt ;j++ )
		{
			if( j/dircntperpage > dirseq )
			{
				dirseq++;
				memset( &du, 0, sizeof du );
				stlong( (long)-2, (char *)&du.lm.id );
				stlong( (long)dirseq, (char *)&du.lm.seq );

				if( isread( dsfi[fd].isfd, (char *)&du,
					ISEQUAL+ISLCKW ) < 0 )
				{
					l_dsmlsethyerrno( iserrno );
					return( -1 );
				}
			}

			dsfi[fd].lm[j].dircnt =
			(int)ldlong((char *)&du.lm.dirent[j%dircntperpage].dircnt );	
			strcpy( dsfi[fd].lm[j].dir,
				 du.lm.dirent[j%dircntperpage].dir );
		}
	}

	/*---------------------------------------------------------------
	** add directory on Table. 
	**-------------------------------------------------------------*/	
	dsfi[fd].lm[dsfi[fd].dircnt].dircnt = 0;
	strcpy( dsfi[fd].lm[dsfi[fd].dircnt].dir, l_dirpath );

	/*---------------------------------------------------------------
	** add directory on directory page in master volume
	**-------------------------------------------------------------*/	
	if( dirseq = ds_getdirseq( fd, dsfi[fd].dircnt, &dirix ) < 0 )
		return( -1 );

	dsfi[fd].dircnt++;

	memset (&du, 0, sizeof (du));
	stlong( (long)-2, (char *)&du.lm.id );
	stlong( (long)dirseq, (char *)&du.lm.seq );

	if( dirix )	/* directory page exist */
	{
		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_DIRPAGE );
			dsfi[fd].dircnt--;
			return( -1 );
		}
	}

	if( dirseq == 0 )	/* new dir insert to first directory page */
	{
		stlong( (long)dsfi[fd].dircnt, (char *)&du.lm.totdircnt );
		stlong( (long)dsfi[fd].dircnt, (char *)&du.lm.thisdircnt );
		strcpy( du.lm.dirent[dirix].dir, l_dirpath );
		stlong( (long)0, (char *)&du.lm.dirent[dirix].dircnt );
	}
	else	/* new dir insert to second dir page */
	{
		stlong( (long)dirix + 1, (char *)&du.lm.thisdircnt );
		strcpy( du.lm.dirent[dirix].dir, l_dirpath );
		stlong( (long)0, (char *)&du.lm.dirent[dirix].dircnt );
	}

	if( dirix )
	{
		if( isrewrite( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			dsfi[fd].dircnt--;
			return( -1 );
		}
	}
	else
	{
		if( iswrite( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			dsfi[fd].dircnt--;
			return( -1 );
		}

		if( ds_usedblkcnt( fd, 1, 0 ) < 0 )
		{
			dsfi[fd].dircnt--;
			return( -1 );
		}
	}

	if( dirseq )
	{
		stlong( (long)-2, (char *)&du.lm.id );
		stlong( (long)0, (char *)&du.lm.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		stlong( (long)dsfi[fd].dircnt, (char *)&du.lm.totdircnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}

	return( 0 );
}

/******* The end of PI_ADDDIR.c ****************************************/
