/*------------------------------------------------------------------------*
 *     FILE   LAYOUT      : xack.x     Tue Sep  3 10:02:02 1996		  *
 *     FILE   DESCRIPTION : ack(or nak) Ελ½Ε Format           		  *
 *     TOTAL  LENGTH      : 6 bytes                                       *
 *------------------------------------------------------------------------*/

 #ifndef XACK_X
 #define XACK_X

 struct xackFORM   {			/* Server <----> Client		  */
	char    cmd[1];                 /* Command = 'A' or 'E'           */
	char    msg[101];                /* O.K or Error Message           */
 };

 #endif

/*------------------------------------------------------------------------*/
