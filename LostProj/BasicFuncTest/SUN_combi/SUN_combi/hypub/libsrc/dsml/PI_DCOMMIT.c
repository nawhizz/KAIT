/* PI_DCOMMIT() : LIB dsml */
/************************************************************************
*	Commit DSML Transaction.
************************************************************************/
/*-------------------------------------------------------------------
add : |nsize(2)|aleng(1)|code(1)|afname(aleng)|psize(2)|
upd : |nsize(2)|bleng(1)|code(1)|aleng(1)|bfname(bleng)|afname(aleng)|psize(2)|
del : |nsize(2)|bleng(1)|code(1)|bfname(bleng)|psize(2)|
-------------------------------------------------------------------*/

#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#ifdef		WIN32
#include	<io.h>
#else
#include	<unistd.h>
#endif
#include	<fcntl.h>
#include	<errno.h>

#include	"dsml.h"
#include	"dsmldef.h"
#include	"pisam.h"

extern	char	dsml_logpath[DS_PATHLEN];
/*----------------------------------------------------------------------+
*	Commit DSML Transaction
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DCOMMIT( void )
#else
PI_DCOMMIT()
#endif
{
	int		logFD;
	char		*logbuf;
	char		*bufaddr;
	char		*tmpaddr;
	char		code;
	unsigned char	bleng;
	unsigned char	aleng;
	char		bfname[DS_PATHLEN];
	short		nsize;

	/*-----------------------------------------------------
	** check whether dsml_logpath[0] == 0 
	-----------------------------------------------------*/
	if( dsml_logpath[0] == 0 )
	{
		PI_COMMIT();
		return 0;
	}

	/*-----------------------------------------------------
	** open dsmllogfile & read first nsize 
	-----------------------------------------------------*/
#ifdef	WIN32
	if( ( logFD = open( dsml_logpath, O_RDONLY | O_BINARY ) ) < 0 )
#else
	if( ( logFD = open( dsml_logpath, O_RDONLY ) ) < 0 )
#endif
	{
		l_dsmlsethyerrno( EDS_OPENLOG_FAIL );
		return( -1 );
	}
	
	if( ( logbuf = (char *)malloc( sizeof( int ) ) ) == (char *)0  ) 
	{
		l_dsmlsethyerrno( EDS_NOMORE_MEM );
		return( -1 );
	}

	if( read( logFD, logbuf, sizeof( int ) )  != sizeof( int ) )
	{
		l_dsmlsethyerrno( errno );
		free( logbuf );
		return( -1 );
	}

	memcpy( &nsize, &logbuf[sizeof (short)], sizeof( short ) );

	for( ; nsize; )
	{
		/*-----------------------------------------------------
		** read reacord & operate according to code 
		-----------------------------------------------------*/
		tmpaddr = (char *)realloc( logbuf, nsize );
		if( tmpaddr == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOMORE_MEM );
			return( -1 );
		}
		logbuf = tmpaddr; 

		if( read( logFD, logbuf, nsize ) !=  nsize )
		{
			l_dsmlsethyerrno( errno );
			free( logbuf );
			return( -1 );
		}

		bufaddr = logbuf;
		bufaddr += sizeof( unsigned char );
		code = *bufaddr;
		bufaddr -= sizeof( unsigned char ); 
		
		switch( code )
		{
		case	DS_ADD_CODE:
			memcpy( &aleng, bufaddr, sizeof aleng );	
			bufaddr += (sizeof(aleng)+sizeof(code)+aleng+sizeof(nsize));
			break;	
		case	DS_DEL_CODE:
			memcpy( &bleng, bufaddr, sizeof bleng );	
			bufaddr += ( sizeof(bleng) + sizeof(code) );

			memcpy( bfname, bufaddr, bleng );
			bufaddr += (bleng + sizeof(nsize) );

			remove( bfname );
			break;
		case	DS_UPD_CODE:
			memcpy( &bleng, bufaddr, sizeof bleng );	
			bufaddr += ( sizeof(bleng) + sizeof(code) );

			memcpy( &aleng, bufaddr, sizeof aleng );
			bufaddr += sizeof( aleng );

			memcpy( bfname, bufaddr, bleng );
			bufaddr += ( bleng + aleng + sizeof(nsize) );	

			remove( bfname );
			break;
		default		   :
			return( -1 );
		}

		/*-----------------------------------------------------
		** get last nsize  
		-----------------------------------------------------*/
		memcpy( &nsize, bufaddr, sizeof( nsize ) );
	}

	free( logbuf );
	close( logFD );	
	PI_COMMIT();
	remove( dsml_logpath );
	dsml_logpath[0] = 0;
	return 0;
}
