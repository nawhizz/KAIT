/* wfm_extvar.c */
/*----------------------------------------------------------------------*/
/* external variable declare for WFMLIB 				*/
/*----------------------------------------------------------------------*/

#include	"wfm_fun.h"		/* WFMLIB internal header */

int	wfm_currfd = 0;		/* currently available form file no */
struct	WFM_FILEINFO	wfm_svfinfo[WFM_MAXOPEN] = {0};
char	*wfm_outbuf = (char *)0;	/* output data buffer to be allocated */
int	wfm_outbuf_size = 0;		/* allocated size of wfm_outbuf */

