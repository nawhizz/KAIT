/*#define	DEBUG 1 */
/* WFmFillData() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : fill data into one segment					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	FormFD		form file descriptor
		  char	*SegmentName		segment descriptor
		  char	*FieldData[]	field data pointer array
	return	: char *(output buffer merged)
*/

#include	<stdlib.h>
#include	<string.h>

#include	"wfm.h"
#include	"wfm_fun.h"

char * CBD1
#if	defined( __CB_STDC__ )
WFmFillData( int FormFD, char *SegmentName, char *FieldData[] )
#else
WFmFillData( FormFD, SegmentName, FieldData )
int	FormFD;
char	*SegmentName;
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
	if( !SegmentName || !SegmentName[0] )	/* segname not input */
	{
		if( finfo->cseg && finfo->cseg->next )
				/* form has multiple segments */
		{
			l_wfmsethyerrno( EWF_INVAL_ARG );
			return( char *)0; /* ERR. segname to be input */
		}
		else	seginfo = finfo->cseg;
	}
	else			/* segname was input by appl */
	{
		struct WFM_SEGINFO *segptr;	/* tmp segment ptr */

#ifdef	DEBUG
wfm_prtseg( stdout, finfo->cseg, "cseg"  );
#endif
		for( seginfo = (void *)0, segptr = finfo->cseg;
/*WWWWWWWWWWWWWWWWW  START  modify  WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW*/
					segptr; segptr = segptr->next )
/*WWWWWWWWWWWWWWWWWWW  END  modify  WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW*/
		{
			if( !segptr->segnm ) continue;
			if( strcmp( segptr->segnm, SegmentName ) ) continue;
			seginfo = segptr;
			break;
		}
		if( !seginfo )
		{
			l_wfmsethyerrno( EWF_NOMATCH_SEGNM );
			return( char *)0;	/* ERR. segname not found */
		}
		
	}
#ifdef	DEBUG
wfm_prtseg( stdout, seginfo,  ( SegmentName? SegmentName : "NULL") );
#endif

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

#ifdef	DEBUG
wfm_prtseg( stdout, seginfo,  ( SegmentName? SegmentName : "NULL") );
#endif

	/* merge for all fields (form block) */
	for(	blkptr = seginfo->blk,
		fieldptr = FieldData,
		outptr = wfm_outbuf,
		outptr[0] = '\0' ; blkptr; blkptr = blkptr->next  )
	{
		if( blkptr->beftxt )
		{
			strcat( outptr, blkptr->beftxt );
		}
		if( blkptr->fldnm && *fieldptr )
		{
			strcat( outptr, *fieldptr );
			fieldptr++;
		}
	}


	return (char *)wfm_outbuf;	/* OK. merged data ptr */
}
