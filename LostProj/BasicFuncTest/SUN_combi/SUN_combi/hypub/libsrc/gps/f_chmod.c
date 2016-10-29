/* f_chmod() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : change permission mode of file or directory			*/
/*----------------------------------------------------------------------*/

#include	<sys/types.h>
#include	<sys/stat.h>
#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif
#include	<errno.h>

#include	"gps.h"

#ifdef		WIN32
extern	int	l_ntchmod( char *fpath, int fmode, int attrset );
#endif
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
extern	void	l_gpssethyerrno( int gps_hyerrno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

int CBD1
#if	defined( __CB_STDC__ )
f_chmod( char *filepath, int mode )
#else
f_chmod( filepath, mode )
char	*filepath;
int	mode;
#endif
{
#ifdef	WIN32
	int	ret;
#endif

	if( filepath == 0 )
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
#ifndef	WIN32
	if( access( filepath, F_OK ) < 0 ) 
#else
	if( access( filepath, 0 ) < 0 ) 
#endif
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
#ifndef	WIN32
	if( chmod( filepath, mode ) < 0 )
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
/*	98.09.16 for MultiThread by JJH ( Delete )
	if( hyerrno = l_ntchmod( filepath, mode, 1 ) )
		return -1;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
	ret = l_ntchmod( filepath, mode, 1 );
	l_gpssethyerrno( ret );
	if( ret )
		return -1;
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
#endif

	return 0;
}

