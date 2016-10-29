/*------------------------------------------------------------------------*
 *     FILE   LAYOUT      : xstart.x     Tue Sep  3 10:02:24 1996	  *
 *     FILE   DESCRIPTION : Ελ½Ε Start Format           		  *
 *     TOTAL  LENGTH      : 9 bytes                                       *
 *------------------------------------------------------------------------*/

 #ifndef XSTART_X
 #define XSTART_X

 struct xstartFORM   {			/* Server <----> Client		  */
	char    dlen[4];                /* Data Length                    */
	char    cmd[1];                 /* Command = 'S'                  */
	char    asid[4];                /* Application System ID          */
 };

 #endif

/*------------------------------------------------------------------------*/
