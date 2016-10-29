/* ds_usedblkcnt() : LIB dsml internal function */
/************************************************************************
*	change used block count						*
*-----------------------------------------------------------------------*
*	input	: int	fd			fileinfo index		*
*		  int	blkcnt			change amount of blkcnt	*
*		  int	doccnt			change amount of doccnt	*
************************************************************************/

#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	change used block count						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_usedblkcnt( int fd, int blkcnt, int doccnt )
#else
ds_usedblkcnt( fd, blkcnt, doccnt )
int	fd;
int	blkcnt;
int	doccnt;
#endif
{
	int	usedblkcnt;
	int	reservblkcnt;

	if( blkcnt == 0 && doccnt == 0 )
		return( 0 );

	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
		return( -1 );
	}

	usedblkcnt = (int)ldlong( (char *)&du.m.usedblkcnt );
	reservblkcnt = (int)ldlong( (char *)&du.m.reservblkcnt );

	if( blkcnt > 0 )
	{
		if( reservblkcnt <= blkcnt )
			reservblkcnt = 0;
		else
			reservblkcnt -= blkcnt;

		usedblkcnt += blkcnt;
	}
	else
	{
		blkcnt *= -1;
		if( usedblkcnt <= blkcnt )
			usedblkcnt = 0;
		else
			usedblkcnt -= blkcnt;

		reservblkcnt += blkcnt;
	}

	stlong( ldlong( (char *)&du.m.doccnt ) + doccnt, (char *)&du.m.doccnt );
	stlong( (long)usedblkcnt, (char *)&du.m.usedblkcnt );
	stlong( (long)reservblkcnt, (char *)&du.m.reservblkcnt );

	if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	dsfi[fd].vol[dsfi[fd].isvolno].usedblkcnt = usedblkcnt;
	dsfi[fd].vol[dsfi[fd].isvolno].reservblkcnt = reservblkcnt;
	dsfi[fd].vol[dsfi[fd].isvolno].doccnt += doccnt;

	return( 0 );
}

/******* The end of ds_usedblkcnt.c ************************************/
