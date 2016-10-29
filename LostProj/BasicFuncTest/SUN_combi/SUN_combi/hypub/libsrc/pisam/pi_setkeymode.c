/* pi_setkeymode() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : set key mode							*/
/*----------------------------------------------------------------------*/
/* PISAM internal function */

#include	<string.h>
#include	<iswrap.h>

static	struct	PI_ISMODE {
	char	*smode;			/* defined string */
	short	imode;			/* isam key mode */
} k_mode[6] = {
		"DUP"  , ISDUPS,
		"NODUP", ISNODUPS,
		"LCOM" , LCOMPRESS,
		"DCOM" , DCOMPRESS,
		"TCOM" , TCOMPRESS,
		"COM"  , COMPRESS
	};
int
#if	defined( __CB_STDC__ )
pi_setkeymode( char *buff, short *keymode )
#else
pi_setkeymode( buff , keymode )
char	*buff;
short	*keymode;
#endif
{
	int	i, j;

	for ( i = 0; buff[i] != '\0'&& buff[i] != '\n'; i++ ) {
		if ( buff[i] == '+' || buff[i] == ' ' )
			continue;
		for ( j = 0; j < 6; j++ ) {
			if ( !memcmp( &buff[i], k_mode[j].smode,
					strlen( k_mode[j].smode ) ) ) {
				*keymode += k_mode[j].imode;
				i += strlen( k_mode[j].smode ) - 1;
				break;
			}
		}
	}
	return	0;
}
