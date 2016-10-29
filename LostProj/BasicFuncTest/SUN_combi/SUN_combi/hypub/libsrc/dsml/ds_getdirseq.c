/* ds_getdirseq() : LIB dsml internal function */
/************************************************************************
*	get seqence number and volume index from volume number		*
*-----------------------------------------------------------------------*
*	input	: int	fd			fileinfo index		*
*		  int	dirno			direc index in table	*
*	output	: int	*dirix			volume index in page	*
*	return	: int	seq			sequece of dir page	*
************************************************************************/

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	get seqence number and directory index from directory number	|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_getdirseq( int fd, int dirno, int *dirix )
#else
ds_getdirseq( fd, dirno, dirix )
int	fd;
int	dirno;
int	*dirix;
#endif
{
	int	seq;
	int	dircntperpage;

	*dirix = dirno;

	dircntperpage = ( dsfi[fd].blksz * 1024 - 1 - 16 ) / DS_DIR_INFSZ;
	for( seq=0; *dirix>=dircntperpage; seq++, *dirix -= dircntperpage ) ;

	return( seq );
}

/******* The end of ds_getdirseq.c *************************************/
