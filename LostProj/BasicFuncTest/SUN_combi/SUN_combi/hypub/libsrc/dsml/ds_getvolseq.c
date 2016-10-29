/* ds_getvolseq() : LIB dsml internal function */
/************************************************************************
*	get seqence number and volume index from volume number		*
*-----------------------------------------------------------------------*
*	input	: int	fd			fileinfo index		*
*		  int	volno			volume index in table	*
*	output	: int	*volix			volume index in page	*
*	return	: int	seq			sequece of master page	*
************************************************************************/

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	get seqence number and volume index from volume number		|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_getvolseq( int fd, int volno, int *volix )
#else
ds_getvolseq( fd, volno, volix )
int	fd;
int	volno;
int	*volix;
#endif
{
	int	seq;
	int	volcntperpage;

	seq = 0;
	*volix = volno;

	volcntperpage = ( dsfi[fd].blksz * 1024 - 1 - DS_MAST_HEADSZ )
								/ DS_VOL_INFSZ;
	if( volno < volcntperpage )
		return( seq );

	seq++;
	*volix -= volcntperpage;
	volcntperpage = ( dsfi[fd].blksz * 1024 - 1 - DS_VOL_HEADSZ )
								/ DS_VOL_INFSZ;
	for( ; *volix>=volcntperpage; seq++, *volix -= volcntperpage ) ;

	return( seq );
}

/******* The end of ds_getvolseq.c *************************************/
