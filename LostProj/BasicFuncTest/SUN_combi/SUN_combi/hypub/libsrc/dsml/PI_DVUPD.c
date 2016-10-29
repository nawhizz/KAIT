/* PI_DVUPD() : LIB dsml */
/************************************************************************
*	update volume information 					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  struct VOLFORM *vol_inf	volume information	*
************************************************************************/

#include	<string.h>
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
|	add new volume							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DVUPD( int fd, struct VOLFORM *vol_inf )
#else
PI_DVUPD( fd, vol_inf )
int		fd;
struct	VOLFORM	*vol_inf;
#endif
{
	struct	VOLFORM	l_vol_inf;
	int		verno;
	int		seq;
	int		chgvolno;
	int		volno;
	int		volix;
	int		n_maxblkcnt;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return -1;

	if( !dsfi[fd].filepath[0] )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}

	if( dsfi[fd].verno[0] != 2)
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( dsfi[fd].volsts != DS_MASTER_VOLUME )
	{
		l_dsmlsethyerrno( EDS_MUST_OPEN_MASTER );
		return( -1 );
	}

	if( vol_inf == (struct VOLFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_chkvolinf( vol_inf, &l_vol_inf ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** find volume index in master table
	**-------------------------------------------------------------*/
	for( chgvolno=0;
	     strcmp(dsfi[fd].vol[chgvolno].volpath, l_vol_inf.volpath); )
	{
		if( ++chgvolno >= dsfi[fd].volcnt )
		{
			l_dsmlsethyerrno( EDS_INVAL_ARG );
			return( -1 );
		}
	}

	if( dsfi[fd].vol[chgvolno].volgen != DS_GEN_VOLUME &&
	    dsfi[fd].vol[chgvolno].volgen != DS_CGEN_VOLUME &&
	    dsfi[fd].vol[chgvolno].volgen != DS_NOTGEN_VOLUME )
	{
		l_dsmlsethyerrno( EDS_INVAL_VOLUME );
		return( -1 );
	}


	/*---------------------------------------------------------------
	** check whether changed members exist
	**-------------------------------------------------------------*/
	n_maxblkcnt = l_vol_inf.maxvolsz * 1024 / dsfi[fd].blksz;
	if( dsfi[fd].vol[chgvolno].maxblkcnt == n_maxblkcnt )
	{
		/* not changed volume informations */
		return( 0 );
	}

	/*---------------------------------------------------------------
	** check whether changed members is valid
	**-------------------------------------------------------------*/
	if( n_maxblkcnt < dsfi[fd].vol[chgvolno].usedblkcnt +
					dsfi[fd].vol[chgvolno].reservblkcnt )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** storing changed volume information to isam file
	**-------------------------------------------------------------*/
	seq = ds_getvolseq( fd, chgvolno, &volix );

	for( volno=0; ; volno=chgvolno, seq=0, volix=1 )
	{
		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );

		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)seq, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			return( -1 );
		}

		if( seq == 0 )	/* the volume exist in first volume page */
			stlong( (long)n_maxblkcnt,
					(char *)&du.m.vol[volix].maxblkcnt );
		else	/* the volume exist in second volume page */
			stlong( (long)n_maxblkcnt,
					(char *)&du.v.vol[volix].maxblkcnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		if( volno == chgvolno )
			break;

		if( dsfi[fd].vol[chgvolno].volgen == DS_NOTGEN_VOLUME )
			break;

	} /* end of for ( for generated volume ) */

	/*---------------------------------------------------------------
	** storing changed volume information to master table
	**-------------------------------------------------------------*/
	dsfi[fd].vol[chgvolno].maxblkcnt = n_maxblkcnt;

	return( 0 );
}

/******* The end of PI_DVUPD.c *****************************************/
