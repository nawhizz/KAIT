/* fio.h */
/*----------------------------------------------------------------------*/
/* HEADER for FIOLIB							*/
/*----------------------------------------------------------------------*/

#ifndef FIO_H
#define FIO_H

#include    <stdio.h>

/* 980422 for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/* ERROR NUMBER 							*/
/*----------------------------------------------------------------------*/
/* for FM function */
#define EFM_CFGNDEF	30401	/* FORMIO: environment variable not defined */
#define EFM_NOPEN	30402	/* FORMIO: file not opened ( no file ) */
#define EFM_NODATA	30403	/* FORMIO: no data in form file */
#define EFM_OVERFLOW	30404	/* FORMIO: form data greater than buffer */
#define EFM_NOSEGID	30405	/* FORMIO: no segid in form file */
#define EFM_FDFULL	30406	/* FORMIO: no more file available to open */
#define EFM_FDERR	30407	/* FORMIO: invalid FD value */
#define	EFM_NOMEM	30408	/* FORMIO: no more memory */

/* for FS function */
#define EFS_FILENDEF	30421	/* FSAM: fileid not defined in CFG file */
#define EFS_NOPEN	30422	/* FSAM: file not opened ( no file ) */
#define EFS_OVERFLOW	30423	/* FSAM: read line data more than buffer */
#define EFS_FDFULL	30424	/* FSAM: no more file available to open */
#define EFS_FDERR	30425	/* FSAM: invalid FD value */
#define EFS_FSEEK	30426	/* FSAM: fseek error */
#define EFS_WRITE	30427	/* FSAM: write error value */
#define EFS_READ	30428	/* FSAM: read error */

/* for SM function */
#define ESM_OPTION	30441	/* SAM: option error */
#define ESM_NOPEN	30442	/* SAM: file not opened ( no file ) */
#define	ESM_INVAL	30443	/* SAM: invalid parameter */
#define ESM_OVERFLOW	30444	/* SAM: read line data more than buffer */
#define ESM_FSEEK	30446	/* SAM: fseek error */
#define ESM_WRITE	30447	/* SAM: write error value */
#define ESM_READ	30448	/* SAM: read error */

/*----------------------------------------------------------------------*/
/* FUNTION PROTOTYPE							*/
/*----------------------------------------------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

int CBD1	FM_ALLCLOSE CBD2((void));
int CBD1	FM_CLOSE CBD2(( int ));
int CBD1	FM_FILLFRM CBD2(( int, char [], int, char [], int, char ));
int CBD1	FM_FILLSEG CBD2(( int, char *, char [], int, char [], int,
                                                                        char ));
int CBD1	FM_GETPATH CBD2(( char *, char *, char * ));
int CBD1	FM_GETSIZE CBD2(( int ));
int CBD1	FM_OPEN CBD2(( char * ));

int CBD1	FS_ALLCLOSE CBD2(());
int CBD1	FS_APPEND CBD2(( int, char *, int ));
int CBD1	FS_BUILD CBD2(( char *, char * ));
int CBD1	FS_CLOSE CBD2(( int ));
int CBD1	FS_CROPEN CBD2(( char *, char * ));
int CBD1	FS_DROP CBD2(( char *, char * ));
int CBD1	FS_GETPATH CBD2(( char *, char *, char * ));
int CBD1	FS_OPEN CBD2(( char *, char * ));
int CBD1	FS_READ CBD2(( int, char *, int, int ));
int CBD1	FS_RECNUM CBD2(( int, int ));
int CBD1	FS_REDFIRST CBD2(( int, char *, int ));
int CBD1	FS_REDLAST CBD2(( int, char *, int ));
int CBD1	FS_REDLN CBD2(( int, char *, int ));
int CBD1	FS_REDNX CBD2(( int, char *, int ));
int CBD1	FS_REDPR CBD2(( int, char *, int ));
int CBD1	FS_UPDAT CBD2(( int, char *, int, int ));
int CBD1	FS_UPDATCUR CBD2(( int, char *, int ));
int CBD1	FS_WRITE CBD2(( int, char *, int ));

int CBD1	SM_APPEND CBD2(( FILE *, char *, int ));
int CBD1	SM_BUILD CBD2(( char *, FILE ** ));
int CBD1	SM_CLOSE CBD2(( FILE * ));
int CBD1	SM_CROPEN CBD2(( char *, FILE ** ));
int CBD1	SM_DROP CBD2(( char * ));
int CBD1	SM_OPEN CBD2(( char *, char *, FILE ** ));
int CBD1	SM_READ CBD2(( FILE *, char *, int, int ));
int CBD1	SM_REDFIRST CBD2(( FILE *, char *, int ));
int CBD1	SM_REDLAST CBD2(( FILE *, char *, int ));
int CBD1	SM_REDLN CBD2(( FILE *, char *, int ));
int CBD1	SM_REDNX CBD2(( FILE *, char *, int ));
int CBD1	SM_REDPR CBD2(( FILE *, char *, int ));
int CBD1	SM_UPDAT CBD2(( FILE *, char *, int, int ));
int CBD1	SM_UPDATCUR CBD2(( FILE *, char *, int ));
int CBD1	SM_WRITE CBD2(( FILE *, char *, int ));

int CBD1	bp_prtdata CBD2(( int, char *, int ));
int CBD1	bp_prtff CBD2(( int ));
int CBD1	bp_prtform CBD2(( int, int, char *, int, char ));
int CBD1	bp_prtlf CBD2(( int ));
int CBD1	bp_prtline CBD2(( int, char *, int ));
int CBD1	bp_prtseg CBD2(( int, int, char *, char *, int, char ));
int CBD1	bp_prtsegf CBD2(( int, int, char * ));

/* for 'COBOL' */
void CBD1	OBP_PRTDATA CBD2(( int *, char *, int *, char * ));
void CBD1	OBP_PRTFF CBD2(( int *, char * ));
void CBD1	OBP_PRTFORM CBD2(( int *, int *, char *, int *, char *,
                                                                char * ));
void CBD1	OBP_RTLF CBD2(( int *, char * ));
void CBD1	OBP_RTLINE CBD2(( int *, char *, int *, char * ));
void CBD1	OBP_PRTSEG CBD2(( int *, int *, char *, char *, int *, char *,
                                                                char * ));
void CBD1	OBP_PRTSEGF CBD2(( int *, int *, char *, char * ));

void CBD1	OFM_ALLCLOSE CBD2(( char * ));
void CBD1	OFM_CLOSE CBD2(( char *, int * ));
void CBD1	OFM_FILLFRM CBD2(( char *, int *, char *, int *, char *, int *,
                                                        char *, int * ));
void CBD1	OFM_FILLSEG CBD2(( char *, int *, char *, char *, int *,
                                                char *, int *, char *, int * ));
void CBD1	OFM_GETPATH CBD2(( char *, char *, char *, char * ));
void CBD1	OFM_GETSIZE CBD2(( char *, int *, int * ));
void CBD1	OFM_OPEN CBD2(( char *, int *, char * ));

void CBD1	OFS_ALLCLOSE CBD2(( char * ));
void CBD1	OFS_APPEND CBD2(( char *, int *, char *, int * ));
void CBD1	OFS_BUILD CBD2(( char *, int *, char *, char * ));
void CBD1	OFS_CLOSE CBD2(( char *, int * ));
void CBD1	OFS_CROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OFS_DROP CBD2(( char *, char *, char * ));
void CBD1	OFS_GETPATH CBD2(( char *, char *, char *, char * ));
void CBD1	OFS_OPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OFS_READ CBD2(( char *, int *, char *, int *, int * ));
void CBD1	OFS_REDFIRST CBD2(( char *, int *, char *, int * ));
void CBD1	OFS_REDLN CBD2(( char *, int *, char *, int *, int * ));
void CBD1	OFS_REDNX CBD2(( char *, int *, char *, int * ));
void CBD1	OFS_REDPR CBD2(( char *, int *, char *, int * ));
void CBD1	OFS_UPDAT CBD2(( char *, int *, char *, int *, int * ));
void CBD1	OFS_UPDATCUR CBD2(( char *, int *, char *, int * ));
void CBD1	OFS_WRITE CBD2(( char *, int *, char *, int * ));

void CBD1	OSM_APPEND CBD2(( char *, FILE **, char *, int * ));
void CBD1	OSM_BUILD CBD2(( char *, char *, FILE ** ));
void CBD1	OSM_CLOSE CBD2(( char *, FILE ** ));
void CBD1	OSM_CROPEN CBD2(( char *, char *, FILE ** ));
void CBD1	OSM_DROP CBD2(( char *, char * ));
void CBD1	OSM_OPEN CBD2(( char *, char *, char *, FILE ** ));
void CBD1	OSM_READ CBD2(( char *, FILE **, char *, int *, int * ));
void CBD1	OSM_REDFIRST CBD2(( char *, FILE **, char *, int * ));
void CBD1	OSM_REDLAST CBD2(( char *, FILE **, char *, int * ));
void CBD1	OSM_REDLN CBD2(( char *, FILE **, char *, int *, int * ));
void CBD1	OSM_REDNX CBD2(( char *, FILE **, char *, int * ));
void CBD1	OSM_REDPR CBD2(( char *, FILE **, char *, int * ));
void CBD1	OSM_UPDAT CBD2(( char *, FILE **, char *, int *, int * ));
void CBD1	OSM_UPDATCUR CBD2(( char *, FILE **, char *, int * ));
void CBD1	OSM_WRITE CBD2(( char *, FILE **, char *, int * ));

#ifdef	__cplusplus
}
#endif

#endif

/*----------------------------------------------------------------------*/
/* end of fio.h */
