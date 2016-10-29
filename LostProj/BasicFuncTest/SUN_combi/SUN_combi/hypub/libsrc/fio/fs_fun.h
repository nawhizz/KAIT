/* fs_fun.h */
/*----------------------------------------------------------------------*/
/* Common Header Internally Included within FIOLIB			*/
/*----------------------------------------------------------------------*/
/* FSAM : FORMATTED SAMFILE I/O FUNCTIONS */

#ifndef FS_FUN_H
#define FS_FUN_H

/* 980423 for compatibility */
#include	"cbuni.h"

#include	<stdio.h>
#include	"gps.h"

/*----------------------------------------------------------------------*/
/*  DEFINE VARIABLES							*/
/*----------------------------------------------------------------------*/
#define 	FS_PATHLEN     100	/* FSAM file path length */
#define 	FS_EXTLEN	40	/* FSAM file extension length */
#define 	FS_IDLEN	 8	/* FSAM file id length */
#define 	FS_MAXOPEN	30	/* max. no. of file open */
#define 	FS_LINESIZE	8192	/* FSAM line buffer size */

/*----------------------------------------------------------------------*/
/*  DEFINE STRCUTURE							*/
/*----------------------------------------------------------------------*/
struct	FS_FILEINFO {
	char	filepath_sav[FS_PATHLEN];/* path + fileid + ext */
	FILE	*fd_sav;		/* sam file fd	*/
};

/*----------------------------------------------------------------------*/
/*	FUNCTION PROTOTYPE						*/
/*----------------------------------------------------------------------*/
void	fs_errset CBD2(( char *retcode ));
int	fs_savefile CBD2(( char *filepath, FILE *fd ));

void	l_fiosethyerrno( int fio_hyerrno );

/*----------------------------------------------------------------------*/
/*  EXTERN VARIABLES							*/
/*----------------------------------------------------------------------*/
extern	int	fs_currfd;		/* next fd available to open */
extern	struct	FS_FILEINFO	fs_svfinfo[];

/*----------------------------------------------------------------------*/
/*  MACRO FUNCTIONS							*/
/*----------------------------------------------------------------------*/
#define fs_getfpath( fileid, fileext, filepath )\
	f_getfpath( fileid, fileext, "SAMCFG", filepath )

#endif
