/* HFmOpen() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : open file							*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*FormFilePath	filepath of form file
	return	: >=0 (file descriptor)
		  -1
*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<errno.h>

#include	"wfm.h"
#include	"wfm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
WFmOpen( char *FormFilePath )
#else
WFmOpen( FormFilePath )
char	*FormFilePath;
#endif
{
	char	*fbuff;
	int	ffd, fsize;
	FILE	*fd;
	int	i;

	/* check arguments */
	if( FormFilePath == (char *)0 )
	{
		l_wfmsethyerrno( EWF_INVAL_ARG );
		return -1;
	}

	/* check if already opened */
	for ( i=0; i < WFM_MAXOPEN ; i++ )
	{
		if( !wfm_svfinfo[i].filepath_sav[0] ) continue;
		if( !strcmp( wfm_svfinfo[i].filepath_sav, FormFilePath ) )
			return( i );	/* already opened */
	}

	if( wfm_currfd < 0 )
	{
		l_wfmsethyerrno( EWF_FULLFD );
		return -1;
	}

	if( ( fd = fopen( FormFilePath, "r" ) ) == (FILE *)0 )
	{
		l_wfmsethyerrno( EWF_OPENFILE );
		return -1;
	}

	fseek( fd, 0, SEEK_END );
	fsize = ftell( fd );
	if( ( fbuff = (char *)malloc( fsize + 64 ) ) == (char *)0 )
		/* 64 means 1 byte for NULL and 63 for margin (no meaning) */
	{
		fclose( fd );
		l_wfmsethyerrno( EWF_NOMORE_MEM );
		return -1;
	}

	fseek( fd, 0L, SEEK_SET );
#ifdef WIN32
	if ( (fsize = (int)fread( fbuff, 1, fsize, fd )) <= 0 )
#else
	if ( (int)fread( fbuff, fsize, 1, fd ) <= 0 )
#endif
	{
		fclose( fd );
		free( fbuff );
		l_wfmsethyerrno( EWF_READFILE );
		return -1;
	}
	fbuff[ fsize ] = '\0';	/* for NULL term. */

	if( (ffd = wfm_savefile( FormFilePath, fbuff, fsize )) < 0 )
	{
		fclose( fd );
		free( fbuff );
		return -1;
	}

	return ffd;
}
