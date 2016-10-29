/* ds_volopen() : LIB dsml internal function */
/************************************************************************
*	open volume							*
*-----------------------------------------------------------------------*
*	input	: int	fd			fileinfo index		*
*		  int	volno			volume index in table	*
************************************************************************/

#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	open volume							|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_volopen( int fd, int volno )
#else
ds_volopen( fd, volno )
int	fd;
int	volno;
#endif
{
	/* opened already */
	if( dsfi[fd].isvolno == volno )
		return( 0 );

	/* close opened file */
	if( dsfi[fd].isfd >= 0 )
	{
		if( isclose( dsfi[fd].isfd ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}
	dsfi[fd].isvolno = -1;

	/* open isam file */
	if( dsfi[fd].vol[volno].volgen != DS_GEN_VOLUME &&
		dsfi[fd].vol[volno].volgen != DS_CGEN_VOLUME )
	{
		l_dsmlsethyerrno( EDS_INVAL_VOLUME );
		return( -1 );
	}

	if( ( dsfi[fd].isfd = isopen( dsfi[fd].vol[volno].volpath,
					dsfi[fd].ismode ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}
	dsfi[fd].isvolno = volno;

	return( 0 );
}

/******* The end of ds_volopen.c ***************************************/
