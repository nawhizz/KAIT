/* wfm_dbgfunc.c : debugging functions for LIB wfm */
/*----------------------------------------------------------------------*/
/* multiple functions for WFM_FILEINFO structure debug			*/
/*----------------------------------------------------------------------*/
/* internal functions */

#include	<stdlib.h>
#include	"wfm_fun.h"

/*----------------------------------------------------------------------*/
/* print out WFM_FILEINFO into (FILE *)outFD for a FormFD		*/
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
wfm_prtforminfo( FILE *outFD, int FormFD )
#else
wfm_prtforminfo( outFD, FormFD )
FILE	*outFD;		/* output File Descriptor */
int	FormFD;		/* Form File FD by WFmOpen() */
#endif
{
	struct	WFM_FILEINFO 	*finfo;

	/* check args and if not an opened form */
	if ( FormFD < 0 || FormFD >= WFM_MAXOPEN )
		return -1; /* ERR. invalid FormFD */

	/* get form file info for the FormFD */
	finfo = &wfm_svfinfo[FormFD];

	/* check if form file opened */
	if ( !finfo->filepath_sav[0] )
		return -1; /*ERR. Form file not opened */

	fprintf( outFD, "------------------------------------\n" );
	fprintf( outFD, ".... Form File for FormFD = %d .....\n", FormFD );
	fprintf( outFD, "------------------------------------\n" );
	wfm_prtfinfo( outFD, finfo );

	return 0;	/* OK */
}

/*----------------------------------------------------------------------*/
/* print out WFM_FILEINFO into (FILE *)outFD for a WFM_FILEINFO		*/
/*----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
wfm_prtfinfo( FILE *outFD, struct WFM_FILEINFO *finfo )
#else
wfm_prtfinfo( outFD, finfo )
FILE	*outFD;			/* output File Descriptor */
struct WFM_FILEINFO	*finfo;	/* finfo to print out */
#endif
{
	fprintf( outFD, "\n" );
	fprintf( outFD, "<<<<<<<<<<<<<< WFM_FILEINFO >>>>>>>>>>>>>>\n" );
	fprintf( outFD, "\n" );

	fprintf( outFD, "fpath = [%s]\n", finfo->filepath_sav );
	fprintf( outFD, "fsize = %d bytes\n", finfo->fsize );

	wfm_prtseg( outFD, finfo->hseg, "(hseg)" );
	wfm_prtseg( outFD, finfo->cseg, "(cseg)" );
	wfm_prtseg( outFD, finfo->tseg, "(tseg)" );

	fprintf( outFD, "...... end of WFM_FILEINFO ..........\n" );
	fprintf( outFD, "\n" );

	return;	/* OK */
}

/*----------------------------------------------------------------------*/
/* print out WFM_SEGINFO into (FILE *)outFD for a WFM_SEGINFO		*/
/*----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
wfm_prtseg( FILE *outFD, struct WFM_SEGINFO *seg, char *title )
#else
wfm_prtseg( outFD, seg, title )
FILE	*outFD;			/* output File Descriptor */
struct WFM_SEGINFO *seg;	/* seg to print out */
char	*title;			/* segment title */
#endif
{
	struct WFM_SEGINFO *segptr;

	fprintf( outFD, "\n" );
	fprintf( outFD, "==================================\n" );
	if( !seg )
	{
		fprintf( outFD, "finfo->%s = NULL !!\n", title );
		fprintf( outFD, "\n" );
		return;	/* OK */
	}

	fprintf( outFD, "%s segment(s).\n", title );
	fprintf( outFD, "==================================\n" );

	for( segptr = seg; segptr; segptr = segptr->next )
	{
		fprintf( outFD, "--------------------------------\n" );
		if( !segptr->segnm ) fprintf( outFD, "segnm = NULL" );
		else fprintf( outFD, "segnm = [%s]", segptr->segnm );
		fprintf( outFD, "\tbeftxt_totlen = %d.\n", segptr->beftxt_totlen );
		fprintf( outFD, "--------------------------------\n" );

		wfm_prtblk( outFD, segptr->blk );
	}
	fprintf( outFD, "==================================\n" );
	fprintf( outFD, "end of %s segment(s).\n", title );
	fprintf( outFD, "==================================\n" );

	return;	/* OK */
}

/*----------------------------------------------------------------------*/
/* print out WFM_BLKINFO into (FILE *)outFD for a WFM_BLKINFO		*/
/*----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
wfm_prtblk( FILE *outFD, struct WFM_BLKINFO *blk )
#else
wfm_prtblk( outFD, blk )
FILE	*outFD;			/* output File Descriptor */
struct WFM_BLKINFO *blk;	/* blk to print out */
#endif
{
	struct WFM_BLKINFO *blkptr;

	if( !blk )
	{
		fprintf( outFD, "no contents (blk=NULL).\n" );
		fprintf( outFD, "\n" );
		return;	/* OK */
	}

	for( blkptr = blk; blkptr; blkptr = blkptr->next )
	{
		if( !blkptr->beftxt )
			fprintf( outFD, "[no beftxt]" );
		else
			fprintf( outFD, "%s", blkptr->beftxt );

		if( !blkptr->fldnm )
			fprintf( outFD, "[no field]" );
		else fprintf( outFD, "[#$%s]", blkptr->fldnm );

	}

	fprintf( outFD, "\n" );

	return;	/* OK */
}

/*----------------------------------------------------------------------*/
/* print out to logfile open/write/close when every time called		*/
/*----------------------------------------------------------------------*/
#include	<stdarg.h>
int
#if	defined( __CB_STDC__ )
lfprintf2( char *fpath, char *format, ... )
#else
lfprintf2( va_alist )
va_dcl
#endif
{
	va_list	lvar;
#if	!defined( __CB_STDC__ )
	char	*fpath;
	char	*format;
#endif
	FILE	*fd;
	int	ret;

	va_start( lvar, format );

#if	!defined( __CB_STDC__ )
	va_start( lvar );
	fpath = va_arg( lvar, char * );
	format = va_arg( lvar, char * );
#endif

	fd = fopen( fpath, "a" );
	if( !fd ) 
	{
		va_end( lvar );
		return -1;	/* ERR. in file open */
	}
	ret = vfprintf( fd, format, lvar );
	fclose( fd );

	va_end( lvar );

	return(ret);
}

/*----------------------------------------------------------------------*/
/* print out2 to logfile open/write/close when every time called	*/
/*----------------------------------------------------------------------*/
static	char	*_lfprintf_fpath = (char *)0;

int
#if	defined( __CB_STDC__ )
lfprintf_start( char *fpath, char *fopt, char *format, ... )
#else
lfprintf_start( va_alist )
va_dcl
#endif
/*	fopt =	"w" : truncate existing file
		"a" : append if file exist
*/
{
	va_list	lvar;
#if	!defined( __CB_STDC__ )
	char	*fpath;
	char	*fopt;
	char	*format;
#endif
	FILE	*fd;
	int	ret;

	va_start( lvar, format );

#if	!defined( __CB_STDC__ )
	va_start( lvar );
	fpath = va_arg( lvar, char * );
	fopt = va_arg( lvar, char * );
	format = va_arg( lvar, char * );
#endif

	if( !_lfprintf_fpath ) _lfprintf_fpath = malloc( 256 );
	if( !_lfprintf_fpath ) return -1;	/* no mem. for fpath */
	
	strcpy( _lfprintf_fpath, fpath );
	fd = fopen( _lfprintf_fpath, fopt );
	if( !fd ) 
	{
		va_end( lvar );
		return -1;	/* ERR. in file open */
	}
	ret = vfprintf( fd, format, lvar );
	fclose( fd );

	va_end( lvar );

	return(ret);
}

int
#if	defined( __CB_STDC__ )
lfprintf( char *format, ... )
#else
lfprintf( va_alist )
va_dcl
#endif
{
	va_list	lvar;
#if	!defined( __CB_STDC__ )
	char	*format;
#endif
	FILE	*fd;
	int	ret;

	va_start( lvar, format );

#if	!defined( __CB_STDC__ )
	va_start( lvar );
	format = va_arg( lvar, char * );
#endif

	if( !_lfprintf_fpath ) return -1;
		/* not init. first call lfprintf_init() */

	fd = fopen( _lfprintf_fpath, "a" );
	if( !fd ) 
	{
		va_end( lvar );
		return -1;	/* ERR. in file open */
	}
	ret = vfprintf( fd, format, lvar );
	fclose( fd );

	va_end( lvar );

	return(ret);
}
