/* pi_filegen() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : generate file							*/
/*----------------------------------------------------------------------*/
/* PISAM internal function */

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int
#if	defined( __CB_STDC__ )
pi_filegen( char *filepath, char *infpath, int mode )
#else
pi_filegen( filepath, infpath, mode )
char	*filepath;
char	*infpath;
int	mode;
#endif
{
	char	input[80];
	char	keyno[3];
	int	isfd, reclen, i;
	FILE	*inf;
	struct	keydesc ckey;

	/* Open information file fileid.inf */
	if (( inf = fopen( infpath, "rb" )) == (FILE *)0 ) {
		l_pisamsethyerrno( EPI_NOINFFILE );
		return -1;
	}

	fscanf( inf, "%s", input );	/* get file length */
	reclen = atoi( input );
	if ( reclen <= 0 ) {
		fclose( inf );
		l_pisamsethyerrno( EPI_INFRECSIZE );
		return -1;
	}

	strcpy( keyno, "KA" );
	fscanf( inf, "%s", input );
	if ( strcmp( input, keyno ) ) {
		fclose( inf );
		l_pisamsethyerrno( EPI_INFKEYDEF );
		return -1;
	}

	/* Build isam file with primary key */
	ckey.k_flags = 0;
	fscanf( inf, "%s", input );
	if ( !memcmp( input, "K:", 2 ) ) {
		pi_setkeymode( &input[2], &ckey.k_flags );
		if ( !ckey.k_flags )
			ckey.k_flags = ISNODUPS;
	}
	else {
		ckey.k_flags = ISNODUPS;
		fseek( inf, (long)(-1*strlen(input)), SEEK_CUR );
	}

	for( i=0; ; i++ )
	{
		fscanf(inf, "%s", input);
		if ( feof(inf) ) {
			fclose( inf );
			l_pisamsethyerrno( EPI_INFKEYDEF );
			return -1;
		}
		if ( !strcmp(input,"end") )
			break;

		if (i == PI_MAXKEYPART ) {
			fclose(inf);
			l_pisamsethyerrno( EPI_INFKEYPART );
			return -1;
		}

		ckey.k_part[i].kp_start = 0;
		ckey.k_part[i].kp_leng	= 0;
		ckey.k_part[i].kp_type = 0;
		if( sscanf( input, "%hd,%hd,%hd", &ckey.k_part[i].kp_start,
			&ckey.k_part[i].kp_leng, &ckey.k_part[i].kp_type ) < 2 )
		{
			fclose(inf);
			l_pisamsethyerrno( EPI_INFKEYDEF );
			return -1;
		}
	}

	ckey.k_nparts = i;

	isfd = isbuild( filepath, reclen, &ckey, mode );
	if( isfd < 0 ) {
		l_pisamsethyerrno( iserrno );
		fclose( inf );
		return -1;
	}

	/* Add index */
	for( ; ; )
	{
		fscanf(inf, "%s", input);
		if ( feof(inf) )
			break;
		if ( !strcmp(input,"end") )
			break;

		keyno[1] += 1;
		if ( strcmp( input, keyno ) )	{
			fclose( inf );
			isclose( isfd );
			pi_erasefile( filepath );
			l_pisamsethyerrno( EPI_INFKEYDEF );
			return -1;
		}

		ckey.k_flags = 0;
		fscanf( inf, "%s", input );
		if ( !memcmp( input, "K:", 2 ) ) {
			pi_setkeymode( &input[2], &ckey.k_flags );
			if ( !ckey.k_flags )
				ckey.k_flags = ISNODUPS;
		}
		else {
			ckey.k_flags = ISNODUPS;
			fseek( inf, (long)(-1*strlen(input)), SEEK_CUR );
		}

		for( i=0; ; i++ )
		{
			fscanf(inf, "%s", input);
			if ( feof(inf) ) {
				fclose( inf );
				isclose( isfd );
				pi_erasefile( filepath );
				l_pisamsethyerrno( EPI_INFKEYDEF );
				return -1;
			}
			if ( !strcmp(input,"end") )
				break;

			ckey.k_part[i].kp_start = 0;
			ckey.k_part[i].kp_leng	= 0;
			ckey.k_part[i].kp_type = 0;
			if( sscanf( input, "%hd,%hd,%hd",
						&ckey.k_part[i].kp_start,
						&ckey.k_part[i].kp_leng,
						&ckey.k_part[i].kp_type ) < 2 )
			{
				fclose(inf);
				isclose( isfd );
				pi_erasefile( filepath );
				l_pisamsethyerrno( EPI_INFKEYDEF );
				return -1;
			}
		}

		ckey.k_nparts = i;

		if( isaddindex( isfd, &ckey ) < 0 ) {
			l_pisamsethyerrno( iserrno );
			fclose( inf );
			isclose( isfd );
			pi_erasefile( filepath );
			return -1;
		}
	}

	fclose( inf );

	return isfd;
}
