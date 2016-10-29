/* sockcomm.h */
/*----------------------------------------------------------------------*/
/* HEADER for SOCKCOMMLIB						*/
/*----------------------------------------------------------------------*/
#ifndef SOCKCOMM_H
#define SOCKCOMM_H

/* 980424 for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/* ERROR NUMBER 							*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/* FUNCTION PROTOTYPE							*/
/*----------------------------------------------------------------------*/
/* for 'C' */
void CBD1	sock_close CBD2(( int sock ));
int CBD1	sock_connect CBD2(( int sock, char *hostname, unsigned portno,
                                                        int timeoutsec ));
int CBD1	sock_open CBD2(( void ));
int CBD1	sock_send CBD2(( int fd, char *data, int length,
                                                        int timeoutsec ));
int CBD1	sock_recv CBD2(( int fd, char *data, int length,
                                                        int timeoutsec ));
int CBD1	sock_getportno CBD2(( char *servicename, char *protocol ));
int CBD1	sock_select CBD2(( int fd, int opt, int timeoutsec ));
int CBD1	sock_startup CBD2(( int wMinorVersion, int wMajorVersion ));
int CBD1	sock_cleanup CBD2(( void ));

#endif

/*----------------------------------------------------------------------*/
/* end of sockcomm.h */
