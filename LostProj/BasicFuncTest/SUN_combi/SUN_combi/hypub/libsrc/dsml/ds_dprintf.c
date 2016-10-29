#include	"dsml.h"
#include	"dsmldef.h"
#include        <stdarg.h>
#include        <stdlib.h>
#include        <stdio.h>
#include	<sys/types.h>
#include	<fcntl.h>

int
#if     defined( __CB_STDC__ )
ds_dprintf( char *fpath, char *format, ... )
#else
ds_dprintf( va_alist )
va_dcl
#endif
{
        va_list lvar;
#if     !defined( __CB_STDC__ )
        char    *fpath;
        char    *format;
#endif
        FILE    *fd;
        int     ret;

        va_start( lvar, format );

#if     !defined( __CB_STDC__ )
        va_start( lvar );
        fpath = va_arg( lvar, char * );
        format = va_arg( lvar, char * );
#endif

        fd = fopen( fpath, "a" );
        if( !fd )
        {
                va_end( lvar );
                return -1;      /* ERR. in file open */
        }
        ret = vfprintf( fd, format, lvar );
        fclose( fd );

        va_end( lvar );

        return(ret);
}
