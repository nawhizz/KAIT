/* wfm.h */
/*----------------------------------------------------------------------*/
/* HEADER for WFMLIB							*/
/*----------------------------------------------------------------------*/

#ifndef WFM_H
#define WFM_H

#include    <stdio.h>

/* for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/* ERROR NUMBER 							*/
/*----------------------------------------------------------------------*/
/* for WFM function */

#define EWF_INVAL_ARG		30501	/* Invalid arguments */
#define	EWF_FULLFD		30502	/* Formfile FD full */

#define EWF_OPENFILE		30503	/* File open failed */
#define EWF_READFILE		30504	/* File read failed */
#define EWF_WRITEFILE		30505	/* File write failed */
#define EWF_INVAL_FD		30506	/* Invalid FormFileFD */

#define EWF_NOMORE_MEM		30507	/* No more memory */

#define EWF_NOMATCH_SEGNM	30508	/* SegName Not Found in FormFile */

/*----------------------------------------------------------------------*/
/* FUNTION PROTOTYPE							*/
/*----------------------------------------------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

void CBD1	WFmAllClose CBD2((void));
int CBD1	WFmClose CBD2(( int ));
char * CBD1	WFmFillData CBD2(( int, char *, char *[] ));
char * CBD1	WFmFillHead CBD2(( int, char *[] ));
char * CBD1	WFmFillTail CBD2(( int, char *[] ));
int CBD1	WFmOpen CBD2(( char * ));

/* for 'COBOL' */

void CBD1	OWFM_ALLCLOSE CBD2((void));
void CBD1	OWFM_CLOSE CBD2(( char *, int * ));
void CBD1	OWFM_OPEN CBD2(( char *, int *, char * ));
void CBD1	OWFM_FILLDATA CBD2(( char *, int *, char *, char *, int *,
							char *, int * ));
void CBD1	OWFM_FILLHEAD CBD2(( char *, int *, char *, int *, char *,
								int * ));
void CBD1	OWFM_FILLTAIL CBD2(( char *, int *, char *, int *, char *,
								int * ));


#ifdef	__cplusplus
}
#endif

#endif

/*----------------------------------------------------------------------*/
/* end of wfm.h */
