/* clmapi.h */ 
/*----------------------------------------------------------------------------*/
/*	HEADER for LIBCLMAPI						      */
/*----------------------------------------------------------------------------*/
#ifndef	CLMAPI_H
#define	CLMAPI_H

#include	"cbuni.h"

#ifndef	WIN32
#include	<sys/types.h>
#include	<sys/ipc.h>
#include	<sys/sem.h>
#else
#endif

#include	"lmt.h"
#include	"lmtfun.h"

/* for 'C' */

#ifdef	__cplusplus
extern "C" {
#endif
/* instance 사용/free */

/* return value : 0 OK, -1 Error */

/* instance usage */
int lm_gettpmins CBD2(( pid_t p_tsess, int portno ));
int lm_getdbcins CBD2(( pid_t p_dlmast, key_t shmkey ));
int lm_getwebins CBD2(( key_t shmkey ));
/* free instances */
void lm_freetpmins CBD2(( pid_t p_tsess));
void lm_freedbcins CBD2(( key_t p_dlmast));
void lm_freewebins CBD2(( key_t shmkey));
/* concurrent user 사용 / free  */
int lm_gettpmusr CBD2(( int sessno , int portno));
int lm_getdbcusr CBD2(( pid_t p_dlserv, key_t shmkey ));
int lm_getwebusr CBD2(( pid_t p_wbk, key_t shmkey ));
/* free users */
void lm_freetpmusr CBD2((int sessno));
void lm_freedbcusr CBD2((pid_t p_dlserv));
void lm_freewebusr CBD2((pid_t p_wbroker));
/*remain concurrent user 조회 */
int lm_querytpmrem CBD2((void));
int lm_querydbcrem CBD2((void));
int lm_querywebrem CBD2((void));
#ifdef	__cplusplus
}
#endif

#endif	/* CLMAPI_H */
