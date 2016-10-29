/*------------------------------------------------------------------------*
 *     FILE   LAYOUT      : xver.x     	Tue Sep  3 10:02:24 1996	  *
 *     FILE   DESCRIPTION : Version ���� Program ��� Start Format   	  *
 *     TOTAL  LENGTH      : 23 bytes                                      *
 *------------------------------------------------------------------------*/

 #ifndef XVER_X
 #define XVER_X

 struct xverFORM   {			/* Client -----> Server		  */
	char    dlen[4];                /* Data Length                    */
	char    cmd[1];                 /* Command = 'V'                  */
	char    asid[4];                /* Application System ID          */
	char    lverid[14];             /* Last Version ID	          */
 };

 #endif

/*------------------------------------------------------------------------*/
