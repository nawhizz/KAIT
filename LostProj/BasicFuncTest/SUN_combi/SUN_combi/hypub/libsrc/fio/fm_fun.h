/* fm_fun.h */
/*----------------------------------------------------------------------*/
/* Common Header Internally Included within FIOLIB			*/
/*----------------------------------------------------------------------*/
/* FORMIO : FORMATTED OUTPUT FUNCTIONS */

#ifndef FM_FUN_H
#define FM_FUN_H

#include	<stdio.h>

/* 980422 for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/*  DEFINE VARIABLES							*/
/*----------------------------------------------------------------------*/
#define 	FM_PATHLEN     100	/* FORM file path length */
#define 	FM_IDLEN	 8	/* FORMIO file id length */
#define 	FM_MAXOPEN	30	/* max. no. of file open */
#define 	FM_LINESIZE	512	/* FORM line buffer size */
#define 	FM_FILEEXT	".frm"	/* FORM file extension len */
#define 	FM_SEGIDLEN	40	/* FORM file segmentid len */

/*----------------------------------------------------------------------*/
/*  DEFINE STRCUTURE							*/
/*----------------------------------------------------------------------*/
struct	FM_FILEINFO {
	char	filepath_sav[FM_PATHLEN];/* path + fileid + ext */
	FILE	*fd_sav;		/* sam file fd	*/
	char	*fbuff; 		/* file buffer */
	int	fsize;			/* file size ( buffer size ) */
};

/*----------------------------------------------------------------------*/
/*	FUNCTION PROTOTYPE						*/
/*----------------------------------------------------------------------*/
void	fm_errset CBD2(( char *retcode ));
int	fm_getfpath CBD2(( char *fileid, char *fileext, char *filepath ));
int	fm_getline CBD2(( char *src, int bsize, char *dest ));
int	fm_savefile CBD2(( char *filepath, FILE *fd, char *fbuff, int fsize ));

void	l_fiosethyerrno( int fio_hyerrno );

/*----------------------------------------------------------------------*/
/*  EXTERN VARIABLES							*/
/*----------------------------------------------------------------------*/
extern	int	fm_currfd;		/* next fd available to open */
extern	struct	FM_FILEINFO	fm_svfinfo[];

#endif
