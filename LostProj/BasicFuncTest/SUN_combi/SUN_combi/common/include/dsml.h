/* dsml.h : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	Document Stoage Management Library V2.0				|
|									|
*----------------------------------------------------------------------*/

#ifndef	DSML_H
#define	DSML_H

#include        "cbuni.h"

struct	BUILDFORM	{	/* DSML build information		 48 */
	int	maxvolsz;	/* Maximum primary volume size ( unit M ) 0 */
	short	blksz;		/* Block size ( unit K )		  4 */
	char	filler	[42];	/* Filler				  6 */
};

struct	VOLFORM		{	/* DSML second volumn information	176 */
	char	volpath	[128];	/* Second volume path			  0 */
	int	maxvolsz;	/* Maximum second volume size ( unit M )128 */
	char	filler	[ 44];	/* Filler				132 */
};

struct	DSMLFORM	{	/* DSML document information		236 */
	char	title	[ 32];	/* Title of a document			  0 */
	char	fname	[ 32];	/* Default file name of document	 32 */
	char	type	[  2];	/* Type of a document			 64 */
	char	userinf	[128];	/* User Defined Information		 66 */
/* added by stoneshim start */
	char	dst	[  1];	/* Document Storage Type		194 */
/* added by stoneshim end */
	char	filler	[ 41];	/* Filler				195 */
};

struct	DSMIFORM	{	/* DSML document information for read	248 */
	int	size;		/* Size of a document			  0 */
	int	atime;		/* Add date & time			  4 */
	int	utime;		/* Update date & time			  8 */
	char	title	[ 32];	/* Title of a document			 12 */
	char	fname	[ 32];	/* Default file name of document	 44 */
	char	type	[  2];	/* Type of a document			 76 */
	char	userinf	[128];	/* User Defined Information		 78 */
/* added by stoneshim start */
	char	dst	[  1];	/* Document Storage Type		206 */
/* added by stoneshim end */
	char	filler	[ 41];	/* Filler				207 */
};

struct	DSMVFORM	{	/* DSML volume information for read	192 */
	int	doccnt;		/* Count of documents in a volume	  0 */
	int	mindocid;	/* Minimum document ID of a volume	  4 */
	int	maxdocid;	/* Maximum document ID of a volume	  8 */
	int	usedblkcnt;	/* Count of used block in a volume	 12 */
	int	reservblkcnt;	/* Count of reserved block in a volume	 16 */
	char	volpath	[128];	/* Path of a volume			 20 */
	int	maxvolsz;	/* Maximum size of a volume ( unit M )	148 */
	char	volgen;		/* Volume generate flag ( 'G'/'N' )	152
	char	filler	[ 39];	/* Filler				153 */
};

struct	DSMMFORM	{	/* DSML information for read		 80 */
	char	version	[32];	/* DSML version information		  0 */
	short	blksz;		/* Block size ( unit K )		 32 */
	short	volcnt;		/* Count of volume in a DSML		 34 */
	char	filler	[44];	/* Filler				 36 */
};

/* added by stoneshim start */
struct	DS_DIRMINFO	{
	char	dir[128];
	int	dircnt;
};

struct	DS_DIRVINFO	{
	char	dir[128];
	int	filecnt;
};
/* added by stoneshim end */

/*------ define error number ------------------------------------------*/

#define		EDS_INVAL_ARG		30901	/* Invalid argument */
#define		EDS_INVAL_DOCID		30902	/* Invalid document ID */
#define		EDS_FULLID		30903	/* Full document ID */

#define		EDS_OPENFILE		30912	/* docpath : open failed */
#define		EDS_READFAIL		30913	/* docpath : read failed */
#define		EDS_WRITEFAIL		30914	/* docpath : write failed */

#define		EDS_NOTFOUND		30921	/* Not found a document */
#define		EDS_BADDELPAGE		30923	/* Bad delete page */
#define		EDS_TOOLARGE_DATA	30924	/* Too large document size */

#define		EDS_FDFULL		30931	/* Full open descriptor */
#define		EDS_FDERR		30932	/* Invalid open descriptor */

#define		EDS_EARLY_VERSION	30941	/* Not version 2 */
#define		EDS_NOT_DSML		30942	/* Not DSML file */
#define		EDS_MUST_OPEN_MASTER	30943	/* Not open master volume */
#define		EDS_INVAL_MAST_INFO	30944	/* Can't read master info */
#define		EDS_FATAL_DSML		30945	/* Invalid volume info */
#define		EDS_NOTEARLY_VERSION	30946	/* Not version 1 */

#define		EDS_TOOMANY_VOLUME	30951	/* Too many volume */
#define		EDS_INVAL_VOLUME	30952	/* Not open volume */
#define		EDS_EXIST_VOLUME	30953	/* exist volume */
#define		EDS_SECOND_VOLUME_MOVE	30954	/* Can't open 2nd volume */
#define		EDS_CHECK_VOLUME	30955	/* need checking volume */
#define		EDS_NOMORE_SPACE	30956	/* need 2nd volume */

#define		EDS_SAME_PATH		30961	/* same volume path */
#define		EDS_TOOLONG_FILEPATH	30962	/* too long volume path */

#define		EDS_MAST_FILE		30971	/* Can't change master volume */
#define		EDS_USED_FILE		30972	/* Using volume */

#define		EDS_NOMORE_MEM		30981	/* No More Memory */
#define		EDS_FILEGEN_ERR		30982	/* no more memory or disk full */

#define		EDS_EXIST_DIR		30991	/* dir already exist */	
#define		EDS_INVAL_DIRPAGE	30992	/* Invalid directory page */
#define		EDS_NOTEXIST_DIR	30993	/* dir not exist to del or change */
#define		EDS_NOMATCH_FILE	30994	/* file changed in internal dir */
#define		EDS_ONEDIR_REMAIN	30995	/* only 1 dir remain in master vol */
#define		EDS_INVALID_DIR		30996	/* Invalid dirpath. try another one */
#define		EDS_OPENLOG_FAIL	30997	/* logfile open error */
#define		EDS_NOT_DEF_ISLOGDIR	30998	/* not define 'ISLOGDIR' */
#define		EDS_NOTEXIST_FILE	30999	/* file not exist */

/*------ declear function prototype -----------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

int CBD1	PI_DBUILD CBD2(( char *, struct BUILDFORM * ));
int CBD1	PI_DCROPEN CBD2(( char *, struct BUILDFORM * ));
int CBD1	PI_DUOPEN CBD2(( char * ));
int CBD1	PI_DOPEN CBD2(( char * ));
int CBD1	PI_DCLOSE CBD2(( int ));
int CBD1	PI_DALLCLOSE CBD2(( void ));
int CBD1	PI_DVADD CBD2(( int, struct VOLFORM * ));
int CBD1	PI_DVUPD CBD2(( int, struct VOLFORM * ));
int CBD1	PI_DVREN CBD2(( int, char *, char * ));
int CBD1	PI_DVDEL CBD2(( int, char * ));
int CBD1	PI_DHREAD CBD2(( int, struct DSMMFORM * ));
int CBD1	PI_DVREAD CBD2(( int, int, struct DSMVFORM * ));
int CBD1	PI_DDCHK CBD2(( int ));
int CBD1	PI_DHCHK CBD2(( int ));
int CBD1	PI_DICHK CBD2(( int, int ));
int CBD1	PI_DVCHK CBD2(( int, int ));
int CBD1	PI_DCONV CBD2(( char *, char *, struct BUILDFORM * ));

int CBD1	PI_ADDDOC CBD2(( int, int *, char *, struct DSMLFORM * ));
int CBD1	PI_DELDOC CBD2(( int, int ));
int CBD1	PI_DIREAD CBD2(( int, int *, struct DSMIFORM * ));
int CBD1	PI_DIFIRST CBD2(( int, int *, struct DSMIFORM * ));
int CBD1	PI_DINEXT CBD2(( int, int *, struct DSMIFORM * ));
int CBD1	PI_DILAST CBD2(( int, int *, struct DSMIFORM * ));
int CBD1	PI_DIPREV CBD2(( int, int *, struct DSMIFORM * ));
int CBD1	PI_REDDOC CBD2(( int, int, char * ));
int CBD1	PI_UPDDOC CBD2(( int, int, char *, struct DSMLFORM * ));

/* added by stoneshim start */
int CBD1	PI_DBUILD2 CBD2(( char *, struct BUILDFORM *, char * ));
int CBD1	PI_ADDDIR CBD2(( int, char * ));
int CBD1	PI_UPDDIR CBD2(( int, char *, char * ));
int CBD1	PI_DELDIR CBD2(( int, char * ));
int CBD1	PI_DCOMMIT CBD2(( void ));
int CBD1	PI_DROLLBACK CBD2(( void ));
int CBD1	PI_UPDDIRINFO CBD2(( int, char *, char * ));
int CBD1	PI_DLMREAD CBD2(( int, int, struct DS_DIRMINFO * ));
int CBD1	PI_DLVREAD CBD2(( int, int, int, struct DS_DIRVINFO * ));
int CBD1	PI_DLFREAD CBD2(( int, int, char *, char * ));
/* added by stoneshim end */

void CBD1	OPI_DBUILD CBD2(( char *, struct BUILDFORM *, int *, char * ));
void CBD1	OPI_DCROPEN CBD2(( char *, struct BUILDFORM *, int *, char * ));
void CBD1	OPI_DUOPEN CBD2(( char *, int *, char * ));
void CBD1	OPI_DOPEN CBD2(( char *, int *, char * ));
void CBD1	OPI_DCLOSE CBD2(( int *, char * ));
void CBD1	OPI_DALLCLOSE CBD2(( char * ));
void CBD1	OPI_DVADD CBD2(( int *, struct VOLFORM *, char * ));
void CBD1	OPI_DVUPD CBD2(( int *, struct VOLFORM *, char * ));
void CBD1	OPI_DVREN CBD2(( int *, char *, char *, char * ));
void CBD1	OPI_DVDEL CBD2(( int *, char *, char * ));
void CBD1	OPI_DHREAD CBD2(( int *, struct DSMMFORM *, char * ));
void CBD1	OPI_DVREAD CBD2(( int *, int *, struct DSMVFORM *, char * ));
void CBD1	OPI_DDCHK CBD2(( int *, char * ));
void CBD1	OPI_DHCHK CBD2(( int *, char * ));
void CBD1	OPI_DICHK CBD2(( int *, char *, char * ));
void CBD1	OPI_DVCHK CBD2(( int *, int *, char * ));
void CBD1	OPI_DCONV CBD2(( char *, char *, struct BUILDFORM *, char * ));

void CBD1	OPI_ADDDOC CBD2(( int *, char *, char *, struct DSMLFORM *,
                                                                char * ));
void CBD1	OPI_DELDOC CBD2(( int *, char *, char * ));
void CBD1	OPI_DIREAD CBD2(( int *, char *, struct DSMIFORM *, char * ));
void CBD1	OPI_DIFIRST CBD2(( int *, char *, struct DSMIFORM *, char * ));
void CBD1	OPI_DINEXT CBD2(( int *, char *, struct DSMIFORM *, char * ));
void CBD1	OPI_DILAST CBD2(( int *, char *, struct DSMIFORM *, char * ));
void CBD1	OPI_DIPREV CBD2(( int *, char *, struct DSMIFORM *, char * ));
void CBD1	OPI_REDDOC CBD2(( int *, char *, char *, char * ));
void CBD1	OPI_UPDDOC CBD2(( int *, char *, char *, struct DSMLFORM *,
                                                                char * ));

/* added by stoneshim start */
void CBD1	OPI_DBUILD2 CBD2(( char *, struct BUILDFORM *, char *, int *,
								 char * ));
void CBD1	OPI_ADDDIR CBD2(( int *, char *, char * ));
void CBD1	OPI_UPDDIR CBD2(( int *, char *, char *, char * ));
void CBD1	OPI_DELDIR CBD2(( int *, char *, char * ));
void CBD1	OPI_DCOMMIT CBD2(( char * ));
void CBD1	OPI_DROLLBACK CBD2(( char * ));
void CBD1	OPI_UPDDIRINFO CBD2(( int *, char *, char *, char * ));
void CBD1	OPI_DLMREAD CBD2(( int *, int *, struct DS_DIRMINFO *, char * ));
void CBD1	OPI_DLVREAD CBD2(( int *, int *, int *, struct DS_DIRVINFO *, char * ));
void CBD1	OPI_DLFREAD CBD2(( int *, int *, char *, char *, char * ));
/* added by stoneshim end */

#ifdef	__cplusplus
}
#endif

#endif

/*------ End of the header ( dsml.h ) ---------------------------------*/
