/* dsmldef.h : LIB dsml */
/************************************************************************
*									*
*	Document Stoage Management Library V2				*
*									*
************************************************************************/

#ifndef	DSMLDEF_H
#define	DSMLDEF_H


/*----------------------------------------------------------------------+
|	Define								|
+----------------------------------------------------------------------*/
#define	DS_VERSION_1	"DSML V. 1.0"
#define	DS_VERSION	"DSML V. 2.0"
#define	DS_VERSION_2_1	"DSML V. 2.1"

#define	DS_MAX_VOLSZ	2048		/* Maximum size of a volume (in M) */
#define	DS_MAX_BLKSZ	32		/* Maximum size of a block (in K) */
#define	DS_DEF_BLKSZ	2		/* Default size of a block (in K) */

#define	DS_PATHLEN	128		/* Maximum size of a volume path */

#define	DS_MAX_DOC_ID	99999999	/* Maximum ID of document */

#define	DS_BASE_FD	128		/* Base number of open descripter */
#define	DS_MAX_OPEN	32		/* Maximum count of open descripter */

#define	DS_MAXFILENO	500		/* Maximum count of file in subdirectory */

#define	DS_MAST_HEADSZ	100		/* Header size of master page */
#define	DS_VOL_HEADSZ	12		/* Header size of volume page */
#define	DS_DOC_HEADSZ	256		/* Header size of document page */
#define	DS_DAT_HEADSZ	8		/* Header size of data page */
#define	DS_DEL_HEADSZ	12		/* Header size of delete page */
#define	DS_DIR_HEADSZ	16		/* Header size of directory page */
#define	DS_VOL_INFSZ	176		/* Size of volume information */
#define	DS_MAX_VOL_SEQ	0x7FFF		/* Maximum count of volume page */
#define	DS_VOL_FREE	10		/* percent of free of volume */
#define	DS_DIR_INFSZ	136		/* Size of directory information */

/*----------------------------------------------------------------------+
|	Define of volume character					|
+----------------------------------------------------------------------*/
#define	DS_MASTER_VOLUME	'M'	/* Master Volume */
#define	DS_SECOND_VOLUME	'S'	/* Second Volume */
#define	DS_CHILD_VOLUME		'C'	/* Child Volume */

/*----------------------------------------------------------------------+
|	Define of volume generate status				|
+----------------------------------------------------------------------*/
#define	DS_NOTGEN_VOLUME	'N'	/* not generated volume */
#define	DS_GEN_VOLUME		'G'	/* generated volume */
#define	DS_CGEN_VOLUME		'C'	/* child generated volume */
#define	DS_INVALID_VOLUME	'!'	/* can't open volume */
#define	DS_UNKNOWN_VOLUME	'?'	/* remainder when open second volume */

/*----------------------------------------------------------------------+
|	Define of log code						|
+----------------------------------------------------------------------*/
#define	DS_ADD_CODE		'A'
#define	DS_DEL_CODE		'D'
#define	DS_UPD_CODE		'U'

/*------ for V1 -------------------------------------------------------*/

struct	dsmh1FORM	{	/* Information page			511 */
	short	id;		/* ID of a Document(1~)			  0 */
	short	seq;		/* Sequence number(0) 			  2 */
	int	size;		/* Size of a Document			  4 */
	int	atime;		/* Add date & time			  8 */
	int	utime;		/* Update date & time			 12 */
	char	title	[ 32];	/* Title				 16 */
	char	fname	[  8];	/* Default file name			 48 */
	char	type	[  2];	/* Type of a Document			 56 */
	char	filler	[ 22];	/* Filler				 58 */
	char	data	[431];	/* 1st data of a Document		 80 */
};

struct	dsmd1FORM	{	/* Data page				511 */
	short	id;		/* ID of a Document(1~)			  0 */
	short	seq;		/* Sequence number(1~)			  2 */
	char	data[507];	/* 2nd data of a Document		  4 */
};

struct	dsmo1FORM	{		/* Delete page			511 */
	short	id;			/* ID of a Document(0)		  0 */
	short	seq;			/* Sequence number(1~)		  2 */
	short	outcnt;			/* delete ID count		  4 */
	unsigned char	dfl	[505];	/* delete flag (bit)		  6 */
};

struct	DSML1FORM	{	/* DSML document information		 42 */
	char	title	[32];	/* Title of a document			  0 */
	char	fname	[ 8];	/* Default file name of document	 32 */
	char	type	[ 2];	/* Type of a document			 40 */
};

struct	DSMI1FORM	{	/* DSML document information for read	 54 */
	int	size;		/* Size of a Document			  0 */
	int	atime;		/* Add date & time			  4 */
	int	utime;		/* Update date & time			  8 */
	char	title	[ 32];	/* Title				 12 */
	char	fname	[  8];	/* Default file name			 44 */
	char	type	[  2];	/* Type of a Document			 52 */
};

/*------ for V2 -------------------------------------------------------*/

struct	dsmhFORM	{	/* Document information page		??? */
	int	id;		/* ID of a document(1~)			  0 */
	int	seq;		/* Sequence number(0) 			  4 */
	int	size;		/* Size of a Document			  8 */
	int	atime;		/* Add date & time			 12 */
	int	utime;		/* Update date & time			 16 */
	char	title	[ 32];	/* Title				 20 */
	char	fname	[ 32];	/* Default file name			 52 */
	char	type	[  2];	/* Type of a Document			 84 */
	char	userinf	[128];	/* User information data		 86 */
/*added by stoneshim start */
	char	dst	[  1];	/* Document Storage Type		214 */
/*added by stoneshim end */
	char	filler	[ 41];	/* Filler				215 */
	char	data	[  1];	/* 1st data of a Document		256 */
				/* size = blocksize - 256 - 1		    */
};

struct	dsmdFORM	{	/* Data page				??? */
	int	id;		/* ID of a document(1~)			  0 */
	int	seq;		/* Sequence number(1~)			  4 */
	char	data	[1];	/* 2nd data of a Document		  8 */
				/* size = blocksize - 8 - 1		    */
};

struct	dsmoFORM	{		/* Delete page			??? */
	int	id;			/* ID of a document(0)		  0 */
	int	seq;			/* Sequence number(0~)		  4 */
	int	outcnt;			/* delete ID count		  8 */
	unsigned char	dfl	[1];	/* delete flag (bit)		 12 */
					/* size = blocksize - 12 - 1	    */
};

struct	volFORM		{	/* Volume information			176 */
	char	volpath	[128];	/* Path of volume			  0 */
	int	maxblkcnt;	/* Maximum count of block		128 */
	char	volgen;		/* Volume generate flag ('G'/'N' )	132 */
	char	filler	[ 43];	/* Filler				133 */
};

struct	dsmmFORM	{		/* Master page			??? */
	int	id;			/* ID of a document(-1)		  0 */
	int	seq;			/* Sequence number(0)		  4 */
	char	version	[31];		/* "DSML V2"			  8 */
	char	volsts;			/* Volume stauts		 39 */
	int	doccnt;			/* Count of document in a volumn 40 */
	int	mindocid;		/* Minimum document ID		 44 */
	int	maxdocid;		/* Maximum document ID		 48 */
	int	usedblkcnt;		/* Count of used block		 52 */
	int	reservblkcnt;		/* Count of reserved block	 56 */
	short	blksz;			/* Size of block (in K)		 60 */
	short	volcnt;			/* Count of volume		 62 */
					/* 'c', 's' always 2		    */
	short	thisvolcnt;		/* Count of volume in this page	 64 */
	char	filler	[34];		/* Filler			 66 */
	struct	volFORM	vol	[ 1];	/* Volume informations		100 */
					/* count = (blocksize-100)/176	    */
	/* char	dummy	[ 1];		* Dummy				... */
					/* size = bs - vc * vs - 100	    */
};

struct	dsmvFORM	{		/* Volume page			??? */
	int	id;			/* ID of a document(-1)		  0 */
	int	seq;			/* Sequence number(1~)		  4 */
	short	thisvolcnt;		/* Count of volume in this page	  8 */
	char	filler	[ 2];		/* Filler			 10 */
	struct	volFORM	vol	[ 1];	/* Volume informations		 12 */
					/* count = (blocksize-12)/176	    */
	/* char	dummy	[ 1];		* Dummy				... */
					/* size = bs - vc * vs - 12	    */
};

/* added by stoneshim start */
struct	lodmFORM	{		/* Dir Info for MasterVol	??? */
	int	id;			/* ID of a document(-2)		  0 */
	int	seq;			/* Sequence number(0~)		  4 */
	int	totdircnt;		/* Parent Directory Total Count	  8 */
	int	thisdircnt;		/* Parent Dir cnt in this page	 12 */
	struct	{
		char	dir[DS_PATHLEN];
		int	dircnt;
	}	dirent[1];		/* size = 136			    */
	char	filler	[ 4];
};

struct	lodvFORM	{		/* Dir Info for each Vol	??? */
	int	id;			/* ID of a document(-3)		  0 */
	int	seq;			/* Sequence number(0~)		  4 */
	int	totdircnt;		/* Directory Total Count	  8 */
	int	thisdircnt;		/* Directory cnt in this page	 12 */
	struct	{
		char	dir[DS_PATHLEN];
		int	filecnt;
	}	dirent[1];		/* size = 136			    */
	char	filler	[ 4];
}; 
/* added by stoneshim end */

union	dsmuFORM	{
	char			maxblk[DS_MAX_BLKSZ*1024];
	struct	dsmmFORM	m;	/* master page */
	struct	dsmvFORM	v;	/* volume page */
	struct	dsmhFORM	h;	/* document page */
	struct	dsmdFORM	d;	/* data page */
	struct	dsmoFORM	o;	/* delete page */
	struct	dsmh1FORM	h1;	/* document page for V1 */
	struct	dsmd1FORM	d1;	/* data page for V1 */
	struct	dsmo1FORM	o1;	/* delete page for V1 */
	struct	lodmFORM	lm;	/* directory page for master vol */
	struct	lodvFORM	lv;	/* directory page for each vol */
};

struct	DS_VOLINFO	{		/* Volume information at table	168 */
	int	doccnt;			/* Count of document in a volumn  0 */
	int	mindocid;		/* Minimum document ID		  4 */
	int	maxdocid;		/* Maximum document ID		  8 */
	int	usedblkcnt;		/* Count of used block		 12 */
	int	reservblkcnt;		/* Count of reserved block	 16 */
	char	volpath	[128];		/* Path of volume		 20 */
	int	maxblkcnt;		/* Maximum count of block	148 */
	char	volgen;			/* Volume generate status	152 */
	int	dircnt;			/* Directory count		153 */
	struct	DS_DIRVINFO	*lv;	/* Dir information at table	157 */
	char	filler	[ 7];		/* Filler			161 */
};

struct	DS_FILEINFO	{		/* DSML information		192 */
	char	filepath[DS_PATHLEN];	/* open path			  0 */
	char	version	[31];		/* version			128 */
	char	volsts;			/* master volume flag		159 */
	char	verno	[ 4];		/* version number		160 */
	int	isfd;			/* isam file desc.		164 */
	int	ismode;			/* open mode			168 */
	int	isvolno;		/* open volume number		172 */
	short	blksz;			/* Size of block		176 */
	short	volcnt;			/* Count of volume		178 */
	int	dircnt;			/* Parent Dir count		180 */
	struct	DS_VOLINFO	*vol;	/* volume information		184 */
	struct	DS_DIRMINFO	*lm;	/* Dir information at table 	188 */
};

/*----------------------------------------------------------------------+
|	Internal function prototype					|
+----------------------------------------------------------------------*/
int	ds_chkbuildinf CBD2(( struct BUILDFORM *sbuild_inf,
						struct BUILDFORM *dbuild_inf ));
int	ds_chkdocid CBD2(( int fd, int docid, int fsize ));
int	ds_chkvolinf CBD2(( struct VOLFORM *svol_inf,
						struct VOLFORM *dvol_inf ));
int	ds_convert CBD2(( int fd_v1, int fd_v2 ));
void	ds_erase CBD2(( char *filepath ));
int	ds_filegen CBD2(( char *filepath, struct BUILDFORM *build_inf, char *dirpath ));
int	ds_fileopen CBD2(( char *filepath, int mode ));
int	ds_fullpath CBD2(( char *filepath, char *fullpath ));
int	ds_getvolno CBD2(( int fd, int docid ));
int	ds_getvolseq CBD2(( int fd, int volno, int *volix ));
int	ds_movedoc CBD2(( int fd, int pvolno, int cvolno ));
int	ds_newdocid CBD2(( int fd, int pisamfl, int fsize ));
int	ds_newvolno CBD2(( int fd, int fsize ));
void	ds_nextfd CBD2(( void ));
int	ds_getver CBD2(( int fd, int *verno ));
void	ds_setver CBD2(( char *version, char *verno ));
int	ds_splitvol CBD2(( int fd, int volno ));
int	ds_usedblkcnt CBD2(( int fd, int blkcnt, int doccnt ));
int	ds_volgen CBD2(( int fd, int volno, char volsts ));
int	ds_volopen CBD2(( int fd, int volno ));
void	ds_errset CBD2(( char *retcode ));
int	ds_chkfsize CBD2(( int fd, int verno, int fsize ));
void	l_dsmlsethyerrno CBD2(( int dsml_hyerrno ));
int	ds_splitpath CBD2(( char *path, char *lpath, char *rpath, int n ));
int	ds_getnewdir CBD2(( int fd, int volno, char *newdir ));
int	ds_getdirseq CBD2(( int fd, int dirno, int *dirix ));
int	ds_log CBD2(( char code, char *bfname, char *afname ));
int	ds_chkfdavail CBD2(( void ));
int	ds_dprintf CBD2(( char *fpath, char *format, ... ));

/*----------------------------------------------------------------------+
|	DSML isam access function define				|
+----------------------------------------------------------------------*/
#define	DP_INSERT( fd, verno, buf ) \
	( verno ? iswrite( dsfi[fd].isfd, (char *)&buf ) \
		: PI_ADDIT( fd, (char *)&buf ) )
#define	DP_UPDATE( fd, verno, buf ) \
	( verno ? isrewcurr( dsfi[fd].isfd, (char *)&buf ) \
		: PI_UPTCUR( fd, (char *)&buf ) )
#define	DP_DELETE( fd, verno, buf ) \
	( verno ? isdelcurr( dsfi[fd].isfd ) \
		: PI_DELET( fd, (char *)&buf ) )
#define	DP_REDEQ( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISEQUAL ) \
		: PI_REDEQ( fd, "KA", (char *)&buf ) )
#define	DP_REDGE( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISGTEQ ) \
		: PI_REDGE( fd, "KA", (char *)&buf ) )
#define	DP_REDGT( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISGREAT ) \
		: PI_REDGT( fd, "KA", (char *)&buf ) )
#define	DP_REDNX( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISNEXT ) \
		: PI_REDNX( fd, (char *)&buf ) )
#define	DP_REDLE( fd, verno, buf ) \
	( !verno ? PI_REDLE( fd, "KA", (char *)&buf ) \
	         : isread( dsfi[fd].isfd, (char *)&buf, ISEQUAL ) >= 0 \
		   ? 0 \
		   : isread( dsfi[fd].isfd, (char *)&buf, ISGREAT ) < 0 \
		     ? isread( dsfi[fd].isfd, (char *)&buf, ISLAST ) \
		     : isread( dsfi[fd].isfd, (char *)&buf, ISPREV ) )
#define	DP_REDLT( fd, verno, buf ) \
	( !verno ? PI_REDLT( fd, "KA", (char *)&buf ) \
		 : isread( dsfi[fd].isfd, (char *)&buf, ISGTEQ ) < 0 \
		   ? isread( dsfi[fd].isfd, (char *)&buf, ISLAST ) \
		   : isread( dsfi[fd].isfd, (char *)&buf, ISPREV ) )
#define	DP_REDPR( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISPREV ) \
		: PI_REDPR( fd, "KA", (char *)&buf ) )
#define	DP_RDUEQ( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISEQUAL+ISLCKW ) \
		: PI_RDUEQ( fd, "KA", (char *)&buf ) )
#define	DP_REDFIRST( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISFIRST ) \
		: PI_REDFIRST( fd, (char *)&buf ) )
#define	DP_REDLAST( fd, verno, buf ) \
	( verno ? isread( dsfi[fd].isfd, (char *)&buf, ISLAST ) \
		: PI_REDLAST( fd, (char *)&buf ) )

#endif	/* DSMLDEF_H */

/*------ End of dsmldef.h -*-------------------------------------------*/
