/* WFmFillTail() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : fill data into Tail segment					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	FormFD		form file descriptor
		  char	*FieldData[]	field data pointer array
	return	: char *(output buffer merged)
*/

#include	<stdlib.h>
#include	<string.h>

#include	"wfm.h"
#include	"wfm_fun.h"

char * CBD1
#if	defined( __CB_STDC__ )
WFmFillTail( int FormFD, char *FieldData[] )
#else
WFmFillTail( FormFD, FieldData )
int	FormFD;
char	*FieldData[];
#endif
{
	struct WFM_FILEINFO *finfo;	/* for this form file */
	struct WFM_SEGINFO *seginfo;	/* for this segment */

	struct	WFM_BLKINFO *blkptr;	/* form block ptr */
	char	**fieldptr;		/* input FieldData ptr */
	register char	*outptr;	/* wfm_outbuf pointer */
	int	outbufsize;	/* size of out buffer to allocate */

	/* check args and if not an opened form */
	if ( FormFD < 0 || FormFD >= WFM_MAXOPEN )
	{
		l_wfmsethyerrno( EWF_INVAL_FD );
		return (char *)0; /* ERR. invalid FormFD */
	}

	/* get form file info for the FormFD */
	finfo = &wfm_svfinfo[FormFD];

	/* check if form file opened */
	if ( !finfo->filepath_sav[0] )
	{
		l_wfmsethyerrno( EWF_INVAL_FD );
		return (char *)0; /*ERR. Form file not opened */
	}

	/* search segment ( get seginfo ptr ) */
		/* 1. case no Tail segment */
	if( !finfo->tseg )
		return ( char *)"";	/* ERR. no Tail segment */
		/* 2. get Tail segment ( get seginfo ptr ) */
	seginfo = finfo->tseg;

	/* calculate output buffer size to allocate */
	outbufsize = seginfo->beftxt_totlen + 1;
	if( FieldData ) for( fieldptr=FieldData ; *fieldptr ; fieldptr++ )
		outbufsize += strlen(*fieldptr);

	/* allocate output buffer.  previously allocated buffer
		might be reallocated. */
	if( !wfm_outbuf || wfm_outbuf_size < outbufsize )
	{
		if( wfm_outbuf ) free( wfm_outbuf );
		wfm_outbuf_size = 0;

		wfm_outbuf = (char *)malloc( outbufsize );
		if( !wfm_outbuf )
		{
			l_wfmsethyerrno( EWF_NOMORE_MEM );
			return (char *)0;
		}
		wfm_outbuf_size = outbufsize;
	}

	/* merge for all fields (form block) */
	for(	blkptr = seginfo->blk,
		fieldptr = FieldData,
		outptr = wfm_outbuf,
		outptr[0] = '\0' ; blkptr; blkptr = blkptr->next  )
	{
		if( blkptr->beftxt ) strcat( outptr, blkptr->beftxt );
		if( blkptr->fldnm && *fieldptr )
		{
			strcat( outptr, *fieldptr );
			fieldptr++;
		}
	}

	return (char *)wfm_outbuf;	/* OK. merged data ptr */
}
