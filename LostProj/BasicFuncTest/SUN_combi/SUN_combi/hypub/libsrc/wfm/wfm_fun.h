/* wfm_fun.h */
/*----------------------------------------------------------------------*/
/* Common Header Internally Included within FIOLIB			*/
/*----------------------------------------------------------------------*/
/* FORMIO : FORMATTED OUTPUT FUNCTIONS */

#ifndef WFM_FUN_H
#define WFM_FUN_H

#include	<stdio.h>

/* for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/*  DEFINE VARIABLES							*/
/*----------------------------------------------------------------------*/
#define 	WFM_MAXOPEN	32	/* max. no. of file open */
#define 	WFM_PATHLEN	128	/* max. len. of filepath */

/*----------------------------------------------------------------------*/
/*  DEFINE STRCUTURE							*/
/*----------------------------------------------------------------------*/
struct WFM_BLKINFO {
	char *beftxt;	/* static text before field([#$..]) */
			/* if no before-field text, then NULL ptr*/
	char *fldnm;	/* field name  string */
			/* if NULL ptr, then means no field */
			/* ( actually may be NULL only for
			   the last field in segment) */
			/* if "" then unnamed field */
	struct WFM_BLKINFO *next;
};

struct	WFM_SEGINFO {
	char	*segnm;		/* name of segment */
				/* NULL or "" if unnamed */
	int	beftxt_totlen;	/* total size of <beftxt>s */
	struct WFM_BLKINFO *blk;
	struct WFM_SEGINFO *next;
};

struct	WFM_FILEINFO {
	char	filepath_sav[WFM_PATHLEN];/* form file path */
					/* if empty record, then = "" */
	char	*fbuff; 		/* file buffer */
	int	fsize;			/* file size ( buffer size ) */
	struct	WFM_SEGINFO *hseg;	/* header segment without <FMSEG> tag */
					/* if no <FMSEG> tag in form,then NULL*/
	struct	WFM_SEGINFO *cseg;	/* body segment(s) witht <FMSEG> tag */
					/* if no <FMSEG> tag in form ,then this
					   will contain all the contents */
	struct	WFM_SEGINFO *tseg;	/* tail segment without <FMSEG> tag */
					/* if no <FMSEG> tag in form,then NULL*/

};

/*----------------------------------------------------------------------*/
/*	FUNCTION PROTOTYPE						*/
/*----------------------------------------------------------------------*/

int	wfm_savefile CBD2(( char *filepath, char *fbuff, int fsize ));
int	wfm_saveseginfo CBD2(( char *fbuff, int fsize, struct WFM_SEGINFO **hseg, struct WFM_SEGINFO **cseg, struct WFM_SEGINFO **tseg ));
void	wfm_freeseginfo CBD2(( struct WFM_SEGINFO *seg ));
void	wfm_freeblkinfo CBD2(( struct WFM_BLKINFO *blk ));
int	wfm_prtforminfo CBD2(( FILE *outFD, int FormFD ));
void	wfm_prtfinfo CBD2(( FILE *outFD, struct WFM_FILEINFO *finfo ));
void	wfm_prtseg CBD2(( FILE *outFD, struct WFM_SEGINFO *seg, char *title ));
void	wfm_prtblk CBD2(( FILE *outFD, struct WFM_BLKINFO *blk ));
int	wfm_str2strarr CBD2(( char *str, char *strarr[] ));
void	wfm_errset CBD2(( char *retcode ));
void	l_wfmsethyerrno CBD2(( int wfm_hyerrno ));

int	lfprintf_start CBD2(( char *fpath, char *fopt, char *format, ... ));
int	lfprintf CBD2(( char *format, ... ));
int	lfprintf2 CBD2(( char *fpath, char *format, ... ));

/*----------------------------------------------------------------------*/
/*  EXTERN VARIABLES							*/
/*----------------------------------------------------------------------*/
extern	int	wfm_currfd;		/* next fd available to open */
extern	struct	WFM_FILEINFO	wfm_svfinfo[];
extern	char	*wfm_outbuf;	/* output data buffer to be allocated */
extern	int	wfm_outbuf_size;	/* allocated size of wfm_outbuf */


#endif
