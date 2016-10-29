/* cweb.h : LIB cweb */
/*----------------------------------------------------------------------*
|									|
|	Combi Webbroker api library	V1.0				|
|									|
*----------------------------------------------------------------------*/

#ifndef	CWEB_H
#define	CWEB_H

#include        "cbuni.h"

/*------ define error number ------------------------------------------*/

#define		CW_INVAL_HTTPHEAD	-90001	/* invalid method */
#define		CW_NOSUCH_FLD		-90002	/* no such fieldname */
#define		CW_NOCFG_FLD		-90003	/* no cfg fieldname */
#define		CW_NO_COOKIE		-90004	/* no cookie */
#define		CW_NOSUCH_COOKIE	-90005	/* no such cookie */
#define		CW_GETENVERR		-90006	/* getenv error */
#define		CW_SETCFGENV		-90007	/* cfg setenv error */

/*------ declare function prototype -----------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

int	CBD1	CWapiinit CBD2(( void ));
void	CBD1	CWapiend CBD2(( void ));
void	CBD1	CWwritehead CBD2(( char * ));
void	CBD1	CWwrite CBD2(( char * ));
int	CBD1	CWgetfld CBD2(( char *, char * ));
char *	CBD1	CWgetfldval CBD2(( char * ));
int	CBD1	CWchkcache CBD2(( char * ));
int	CBD1	CWpostcache CBD2(( char *, char * ));
int	CBD1	CWgetcuca CBD2(( char * ));
int	CBD1	CWsetcuca CBD2(( char * ));
int	CBD1	CWgetcookie CBD2(( char *, char * ));
char *	CBD1	CWgetcookieval CBD2(( char * ));
int	CBD1	CWsetcookie CBD2(( char *, char * ));

#ifdef	__cplusplus
}
#endif

#endif

/*------ End of the header ( cweb.h ) ---------------------------------*/
