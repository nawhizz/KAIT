/* f_chown() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change owner and group of file or directory			*/
/*----------------------------------------------------------------------*/

#include	<sys/types.h>

#ifndef		WIN32
#include	<unistd.h>
#include	<pwd.h>
#else
#include	<io.h>
#endif

#include	<errno.h>

#include	"gps.h"

#ifndef		WIN32
static	int	l_getownerid CBD2(( char *owner, uid_t *ownid, gid_t *grpid ));
#else
extern	int	l_ntchown( char *fpath, char *owner );
#endif
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
extern	void	l_gpssethyerrno( int gps_hyerrno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

int CBD1
#if	defined( __CB_STDC__ )
f_chown( char *filepath, char *owner )
#else
f_chown( filepath, owner )
char	*filepath;
char	*owner;
#endif
{
#ifndef	WIN32
	uid_t	ownerid;
	gid_t	groupid;

	if( filepath == 0 || owner == 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_INPUTERR;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_INPUTERR );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}

	/* search file existence */
	if( access( filepath, F_OK ) < 0 ) 
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = errno;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( errno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}

	/* get owner id and group id */
	if( l_getownerid( owner, &ownerid, &groupid ) < 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno =  EGP_GETOWNERERR;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_GETOWNERERR );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}

	/* change owner, group of file or directory */
	if( chown( filepath, ownerid, groupid ) < 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno =  errno;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( errno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}
#else
	int	ret;

	if( filepath == 0 || owner == 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_INPUTERR;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_INPUTERR );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}

	/* search file existence */
	if( access( filepath, 0 ) < 0 ) 
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = errno;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( errno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}

	/* change owner, group of file or directory */
/*	98.09.16 for MultiThread by JJH ( Delete )
	if( hyerrno = l_ntchown( filepath, owner ) )
		return -1;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
	ret = l_ntchown( filepath, owner );
	l_gpssethyerrno( ret );
	if( ret )
		return -1;
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
#endif

	return 0;
}

#ifndef	WIN32
static	int
#if	defined( __CB_STDC__ )
l_getownerid( char *owner, uid_t *ownid, gid_t *grpid )
#else
l_getownerid( owner, ownid, grpid )
char	*owner;
uid_t	*ownid;
gid_t	*grpid;
#endif
{
	struct	passwd	*pwd;

	if( ( pwd = getpwnam( owner ) ) == (struct passwd *)0 )
		return -1;

	*ownid = pwd->pw_uid;
	*grpid = pwd->pw_gid;

	return 0;
}
#endif
