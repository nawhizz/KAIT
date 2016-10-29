/* fioext.c */
/*----------------------------------------------------------------------*/
/* external variable declare for FIOLIB 				*/
/*----------------------------------------------------------------------*/

#include	"fio.h" 		/* common header */
#include	"fm_fun.h"		/* FORMIO header */
#include	"fs_fun.h"		/* FSAM header */

/* error number variable */
/* int	hyerrno; */

/* for FORMIO */
int	fm_currfd = 0;			/* current form file no */
struct	FM_FILEINFO	fm_svfinfo[FM_MAXOPEN];

/* for FSAM */
int	fs_currfd = 0;			/* current sam file no */
struct	FS_FILEINFO	fs_svfinfo[FS_MAXOPEN];

