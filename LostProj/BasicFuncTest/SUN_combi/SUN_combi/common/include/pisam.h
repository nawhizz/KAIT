/* pisam.h */
/*----------------------------------------------------------------------*/
/* HEADER for PISAMLIB							*/
/*----------------------------------------------------------------------*/
#ifndef PISAM_H
#define PISAM_H

/* 980422 for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/* ERROR NUMBER 							*/
/*----------------------------------------------------------------------*/
#define EPI_NOPEN	30201	/* PISAM: file not opened */
#define EPI_FDERR	30202	/* PISAM: file not opened ( FD value err ) */
#define EPI_FDFULL	30203	/* PISAM: nomore FD availalbe to open */
#define EPI_NOINFENV	30204	/* PISAM: not exist env variable for inf */
#define EPI_NODATAFILE	30205	/* PISAM: get datapath err for fileid */
#define EPI_NOINFFILE	30206	/* PISAM: no inf file ( open err ) */
#define EPI_INFDATAERR	30207	/* PISAM: INF data err */
#define EPI_INFRECSIZE	30208	/* PISAM: INF data err( recsize err ) */
#define EPI_INFKEYDEF	30209	/* PISAM: INF data err( key define err ) */
#define EPI_INFKEYPOS	30210	/* PISAM: INF data err( key pos def err ) */
#define EPI_INFKEYPART	30211	/* PISAM: INF data err(keypart morethan avail)*/
#define EPI_LOGDIRNDEF	30212	/* PISAM: isamlogdir(PISAMLOGDIR)env.undefined*/
#define EPI_LOGOPENERR	30213	/* PISAM: pisam log file open err */
#define EPI_TRANNSTART	30214	/* PISAM: transantion not started. PI_TRANmiss*/
#define EPI_NOTUSEKEY	30215	/* PISAM: Not Use Keyname */
#define EPI_INPUTERR 	30216	/* PISAM: filepath/fileid input error */
#define EPI_GETOWNERERR	30217	/* PISAM: get ownerid, groupid error */

/*----------------------------------------------------------------------*/
/* FUNCTION PROTOTYPE							*/
/*----------------------------------------------------------------------*/
/* inf path : using "ISINFO" : possible multiple diretory
   log path : using "ISLOGDIR"
*/

#ifdef	__cplusplus
extern "C" {
#endif

/* for 'C' */
int CBD1	PI_ADDIT CBD2(( int, char * ));
int CBD1	PI_ALLCLOSE CBD2(( void ));
int CBD1	PI_BUILD CBD2(( char *, char * ));
int CBD1	PI_CLOSE CBD2(( int ));
void CBD1	PI_COMMIT CBD2(( void ));
int CBD1	PI_CRLOCKOPEN CBD2(( char *, char * ));
int CBD1	PI_CROPEN CBD2(( char *, char * ));
int CBD1	PI_DELET CBD2(( int, char * ));
int CBD1	PI_DROP CBD2(( char *, char * ));
void CBD1	PI_ENDTRAN CBD2(( void ));
int CBD1	PI_INFPATH CBD2(( char *, char * ));
int CBD1	PI_LOCKOPEN CBD2(( char *, char * ));
int CBD1	PI_OPEN CBD2(( char *, char * ));
int CBD1	PI_RDUEQ CBD2(( int, char *, char * ));
int CBD1	PI_RDUGE CBD2(( int, char *, char * ));
int CBD1	PI_RECNO CBD2(( int, int * ));
int CBD1	PI_RECSIZE CBD2(( char * ));
int CBD1	PI_RECLENGTH CBD2(( int ));
int CBD1	PI_REDEQ CBD2(( int, char *, char * ));
int CBD1	PI_REDFIRST CBD2(( int, char * ));
int CBD1	PI_REDGE CBD2(( int, char *, char * ));
int CBD1	PI_REDGT CBD2(( int, char *, char * ));
int CBD1	PI_REDLE CBD2(( int, char *, char * ));
int CBD1	PI_REDLT CBD2(( int, char *, char * ));
int CBD1	PI_REDLAST CBD2(( int, char * ));
int CBD1	PI_REDNX CBD2(( int, char * ));
int CBD1	PI_REDPR CBD2(( int, char * ));
void CBD1	PI_ROLLBACK CBD2(( void ));
int CBD1	PI_SETKEY CBD2(( int, char * ));
int CBD1	PI_START CBD2(( int, char *, char *, int ));
int CBD1	PI_TRAN CBD2(( void ));
int CBD1	PI_TRBEGIN CBD2(( void ));
int CBD1	PI_TRBUILD CBD2(( char *, char * ));
int CBD1	PI_TRCROPEN CBD2(( char *, char * ));
void CBD1	PI_TRLOGCLOSE CBD2(( void ));
int CBD1	PI_TRLOGOPEN CBD2(( void ));
int CBD1	PI_TROPEN CBD2(( char *, char * ));
int CBD1	PI_UOPEN CBD2(( char *, char * ));
int CBD1	PI_UPDAT CBD2(( int, char * ));
int CBD1	PI_UPTCUR CBD2(( int, char * ));
int CBD1	PI_CHMOD CBD2(( char *, int ));
int CBD1	PI_CHOWN CBD2(( char *, char * ));
int CBD1	PI_ISTRAN CBD2(( void ));
int CBD1	PI_KEYLENGTH CBD2(( int, char * ));

/* Extended PISAM : using "ISDATACFG" */
int CBD1	PI_EBUILD CBD2(( char *, char * ));
int CBD1	PI_ECRLOCKOPEN CBD2(( char *, char * ));
int CBD1	PI_ECROPEN CBD2(( char *, char * ));
int CBD1	PI_EDROP CBD2(( char *, char * ));
int CBD1	PI_ELOCKOPEN CBD2(( char *, char * ));
int CBD1	PI_EOPEN CBD2(( char *, char * ));
int CBD1	PI_ETRBUILD CBD2(( char *, char * ));
int CBD1	PI_ETRCROPEN CBD2(( char *, char * ));
int CBD1	PI_ETROPEN CBD2(( char *, char * ));
int CBD1	PI_EUOPEN CBD2(( char *, char * ));


/* for 'COBOL' */
void CBD1	OPI_ADDIT CBD2(( char *, int *, char * ));
void CBD1	OPI_ALLCLOSE CBD2(( char * ));
void CBD1	OPI_BUILD CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_CLOSE CBD2(( char *, int * ));
void CBD1	OPI_COMMIT CBD2(( void ));
void CBD1	OPI_CRLOCKOPEN CBD2(( char *, int *, char*, char * ));
void CBD1	OPI_CROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_DELET CBD2(( char *, int *, char * ));
void CBD1	OPI_DROP CBD2(( char *, char *, char * ));
void CBD1	OPI_ENDTRAN CBD2(( void ));
void CBD1	OPI_LOCKOPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_OPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_RDUEQ CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_RDUGE CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_RECNO CBD2(( char *, int *, int * ));
void CBD1	OPI_RECSIZE CBD2(( char *, char *, int * ));
void CBD1	OPI_RECLENGTH CBD2(( char *, int*, int * ));
void CBD1	OPI_REDEQ CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_REDFIRST CBD2(( char *, int *, char * ));
void CBD1	OPI_REDGE CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_REDGT CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_REDLAST CBD2(( char *, int *, char * ));
void CBD1	OPI_REDLE CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_REDLT CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_REDNX CBD2(( char *, int *, char * ));
void CBD1	OPI_REDPR CBD2(( char *, int *, char * ));
void CBD1	OPI_ROLLBACK CBD2(( void ));
void CBD1	OPI_SETKEY CBD2(( char *, int *, char * ));
void CBD1	OPI_START CBD2(( char *, int *, char *, char *, int * ));
void CBD1	OPI_TRAN CBD2(( char * ));
void CBD1	OPI_TRBEGIN CBD2(( char * ));
void CBD1	OPI_TRBUILD CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_TRCROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_TRLOGCLOSE CBD2(( void ));
void CBD1	OPI_TRLOGOPEN CBD2(( char * ));
void CBD1	OPI_TROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_UOPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_UPDAT CBD2(( char *, int *, char * ));
void CBD1	OPI_UPTCUR CBD2(( char *, int *, char * ));
void CBD1	OPI_CHMOD CBD2(( char *, char *, int * ));
void CBD1	OPI_CHOWN CBD2(( char *, char *, char * ));
void CBD1	OPI_ISTRAN CBD2(( int * ));
void CBD1	OPI_KEYLENGTH CBD2(( char *, int *, char *, int * ));

void CBD1	OPI_EBUILD CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_ECRLOCKOPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_ECROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_EDROP CBD2(( char *, char *, char * ));
void CBD1	OPI_ELOCKOPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_EOPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_ETRBUILD CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_ETRCROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_ETROPEN CBD2(( char *, int *, char *, char * ));
void CBD1	OPI_EUOPEN CBD2(( char *, int *, char *, char * ));

#ifdef	__cplusplus
}
#endif

#endif

/*----------------------------------------------------------------------*/
/* end of pisam.h */
