/* pisamdef.h */
/*----------------------------------------------------------------------*/
/* COMMON Header Included internally within PISAMLIB			*/
/*----------------------------------------------------------------------*/

#ifndef PISAMDEF_H
#define PISAMDEF_H

/* 980423 for compatibility */
#include	"cbuni.h"

/*----------------------------------------------------------------------*/
/* SYSTEM HEADER FILE							*/
/*----------------------------------------------------------------------*/
/*
#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<unistd.h>
#include	<iswrap.h>
*/

/*----------------------------------------------------------------------*/
/*  DEFINE VARIABLES							*/
/*----------------------------------------------------------------------*/
#define		PI_PATHLEN    128	/* file path length incl. NULL */
#define		PI_IDLEN	8	/* file path length except NULL */
#define		PI_EXTLEN      10	/* file extension length except NULL */
#define		PI_MAXOPEN     32	/* number of files	 */
#define		PI_MAXKEY      16	/* max. no of key for 1 file */
#define		PI_MAXKEYPART	8	/* max. no of column for 1 key */

/*----------------------------------------------------------------------*/
/*  STRCUTURE								*/
/*----------------------------------------------------------------------*/
struct	PI_KEYPART {
	short	pi_kpstart;		/* start position of key_part */
	short	pi_kpleng;		/* length of key_part */
	short	pi_kptype;		/* type of key_part */
};

struct	PI_KEYINFO {
	char	kname[3];	/* key name "KA", "AA", "KK"... */
	short	imode;		/* key mode ISDUPS, ISNODUPS, COMPRESS..*/
	short	pi_nkeyparts;	/* No of keyparts */
	struct	PI_KEYPART	/* elements of key */
		pi_keypart[PI_MAXKEYPART];
};

struct	PI_FILEINFO {
	char	filepath_sav[PI_PATHLEN];/* path + fileid + ext */
	char	infpath_sav[PI_PATHLEN]; /* inf, key file path */
	int	isfd_sav;		/* isam file desc. */
	char	keyname_sav[3];		/* curren key name */
	int	pi_nkeys;		/* No of keys */
	struct	PI_KEYINFO		/* key information. */
		pi_keyinfo[PI_MAXKEY];
};

/*----------------------------------------------------------------------*/
/*  EXTERN VARIABLES							*/
/*----------------------------------------------------------------------*/
extern	int	pi_currfd;	/* next fd available. -1 = not available */
extern	char	pi_logfpath[];	/* transaction log file path */
extern	int	pi_transtart;
extern	struct	PI_FILEINFO	pi_fileinfo[];

/*----------------------------------------------------------------------*/
/*  MACRO FUNCITON							*/
/*----------------------------------------------------------------------*/
#define pi_getdatapath( fileid, fileext, filepath )\
	f_getfpath( fileid, fileext, "ISDATACFG", filepath )

/*----------------------------------------------------------------------*/
/*  FUNCITON PROTOTYPE							*/
/*----------------------------------------------------------------------*/
int	pi_erasefile CBD2(( char *filepath ));
void	pi_errset CBD2(( char *retcode ));
int	pi_filegen CBD2(( char *filepath, char *infpath, int mode ));
int	pi_getinfpath CBD2(( char *fileid, char *infpath ));
int	pi_savefile CBD2(( char *filepath, int isfd, char *infpath ));
int	pi_setkeymode CBD2(( char *buff, short *keymode ));

void	l_pisamsethyerrno( int pisam_hyerrno );

#endif
