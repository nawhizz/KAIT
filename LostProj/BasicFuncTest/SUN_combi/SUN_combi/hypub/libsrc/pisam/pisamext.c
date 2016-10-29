/* pisamext() */
/*----------------------------------------------------------------------*/
/* external variable declare for PISAMLIB				*/
/*----------------------------------------------------------------------*/
#include	"pisam.h"
#include	"pisamdef.h"

/*---------------------------------------------------------------------------*/
/*  GLOABAL VARIABLES							     */
/*---------------------------------------------------------------------------*/
int	pi_currfd = 0;		/* next fd available. -1 = not available */
char	pi_logfpath[PI_PATHLEN];/* transaction log file path */
int	pi_transtart = 0;	/* 0:not 1:islogopen 2:isbegin */
struct	PI_FILEINFO	pi_fileinfo[PI_MAXOPEN] = {0};
