/* PI_DIFIRST() : LIB dsml */
/************************************************************************
*	read information of the first document				*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*	output	: int	*docid			ID of document		*
*		  struct DSMIFORM di		information of document	*
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
|	read informatin of the first document				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DIFIRST( int fd, int *docid, struct DSMIFORM *di )
#else
PI_DIFIRST( fd, docid, di )
int			fd;
int			*docid;
struct	DSMIFORM	*di;
#endif
{
	int	verno;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( di == (struct DSMIFORM *)0 || docid == (int *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** search volume that first document exist
	**-------------------------------------------------------------*/
	if( verno == 2 )
	{
		int	volno;

		if( dsfi[fd].volsts == DS_MASTER_VOLUME )
		{
			int	firstvolno = -1;

			for( volno=0; volno<dsfi[fd].volcnt; volno++ )
			{
				if( dsfi[fd].vol[volno].volgen == DS_GEN_VOLUME
				 && dsfi[fd].vol[volno].doccnt > 0 )
				{
					if( firstvolno < 0 ||
					    dsfi[fd].vol[volno].mindocid <
					     dsfi[fd].vol[firstvolno].mindocid )
					{
						firstvolno = volno;
					}
				}
			}

			if( firstvolno < 0 )
			{
				l_dsmlsethyerrno( EDS_NOTFOUND );
				return( -1 );
			}
			volno = firstvolno;
		}
		else
			volno = 1;

		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );
	}

	/*---------------------------------------------------------------
	** read header of document
	**-------------------------------------------------------------*/
	if( verno < 2 )
	{
		stint( 1, (char *)&du.h1.id );
		stint( 0, (char *)&du.h1.seq );
	}
	else
	{
		stlong( (long)1, (char *)&du.h.id );
		stlong( (long)0, (char *)&du.h.seq );
	}

	if( DP_REDGE( fd, verno, du ) < 0 )
	{
		if( verno )
			l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( verno < 2 )
	{
		if( !verno )
			*(short *)docid = ldint( (char *)&du.h1.id );
		else
			*docid = ldint( (char *)&du.h1.id );
		di->size = (int)ldlong( (char *)&du.h1.size );
		di->atime = (int)ldlong( (char *)&du.h1.atime );
		di->utime = (int)ldlong( (char *)&du.h1.utime );
		memcpy( di->title, du.h1.title, sizeof du.h1.title );
		memcpy( di->fname, du.h1.fname, sizeof du.h1.fname );
		memcpy( di->type, du.h1.type, sizeof du.h1.type );
		if( verno )
			memset( di->userinf, 0, sizeof di->userinf );
	}
	else
	{
		*docid = (int)ldlong( (char *)&du.h.id );
		di->size = (int)ldlong( (char *)&du.h.size );
		di->atime = (int)ldlong( (char *)&du.h.atime );
		di->utime = (int)ldlong( (char *)&du.h.utime );
		memcpy( di->title, du.h.title, sizeof du.h.title );
		memcpy( di->fname, du.h.fname, sizeof du.h.fname );
		memcpy( di->type, du.h.type, sizeof du.h.type );
		memcpy( di->userinf, du.h.userinf, sizeof du.h.userinf );
/* added by stoneshim start */
		memcpy( di->dst, du.h.dst, sizeof du.h.dst );
/* added by stoneshim end */
	}

	return( 0 );
}

/******* The end of PI_DIFIRST.c ***************************************/
