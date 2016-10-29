/* vtpapi.h */
/************************************************************************
*	Header for VTPAPI						*
************************************************************************/

#ifndef	__VTPAPI_H
#define	__VTPAPI_H

#include	"cbuni.h"

/*----------------------------------------------------------------------+
|	Define Struct for VTPAPI					|
+----------------------------------------------------------------------*/
struct	hostinfFORM {
	char	proto[1];	/* protocol : '0' tcp-ip */
	char	filler[2];
	char	*hostname;
	int	portno;
	int	blocksize;
};

/*-----------------------------------------------------------------------+
|	Define Error NO. for VTPAPI					 |
/*----------------------------------------------------------------------*/
#define EVTP_APIINITALREADY	26300	/* Zvapiinit() already */
#define EVTP_ARGERR		26301	/* argument error */
#define EVTP_INVALIDPKT		26302	/* rcvd pktno invalid */
#define	EVTP_NOAPIINIT		26303	/* Zvapiinit() not called before */
#define EVTP_NOSETASID		26304	/* Not setenv $(ASID) */
#define EVTP_NOSETMYCLIID	26305	/* Not setenv $(MYCLIID) */
#define EVTP_NOSSLOGIN		26306	/* No Session Login */
#define	EVTP_NOTXSTART		26307	/* no TX Start */
#define EVTP_RECEIVETIMEOUT	26308	/* Receive Time Out */
#define	EVTP_SMALLBUFSIZE	26309	/* receive buffer size∞° ¿€¥Ÿ */
#define EVTP_SSLOGINALREADY	26310	/* Zvcmslogin() already */
#define EVTP_TXSTARTALREADY	26311	/* TX Start Already */

/*----------------------------------------------------------------------+
|	external function proto type					|
+----------------------------------------------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

/* for C */
void CBD1	Zvapiend CBD2( ( void ) );
int  CBD1	Zvapiinit CBD2( ( void ) );
int  CBD1	Zvcmslogin CBD2( ( struct hostinfFORM *, int *ssno ) );
int  CBD1	Zvcmslogout CBD2( ( int sockfd ) );
int  CBD1	Zvcslogin CBD2( ( int sockfd, char *ipaddr, char *uuid ) );
int  CBD1	Zvcslogout CBD2( ( int sockfd, int ssno, char *uuid ) );
void CBD1	Zvendtx CBD2( ( int sockfd ) );
void CBD1	Zvgeterrmsg CBD2( ( char *buf, int bufsize ) );
int  CBD1	Zvrecv CBD2( ( int sockfd, char *buf, int bufsize ) );
int  CBD1	Zvsend CBD2( ( int sockfd, char *data, int datalen ) );
int  CBD1	Zvstarttx CBD2( ( int sockfd, int ssno, char *uuid,
				  char *txid, char *data, int datalen ) );
int  CBD1	Zvsupertx CBD2( ( int sockfd, int ssno, char *uuid,
				  char *txid, char *data, int datalen ) );

#ifdef	__cplusplus
}
#endif

#endif	/* __VTPAPI_H */

/************************************************************************
*	End of Header							*
************************************************************************/
