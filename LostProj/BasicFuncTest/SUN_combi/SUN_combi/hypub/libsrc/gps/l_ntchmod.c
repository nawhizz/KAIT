/* l_ntchmod() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : Change file mode in NT system only				*/
/*----------------------------------------------------------------------*/
/* internal function */

#ifdef	WIN32

#include <aclapi.h>
#include <io.h>
#include <sys/stat.h>

int
#if	defined( __CB_STDC__ )
l_ntchmod( char *fpath, int fmode, int attrset )
#else
l_ntchmod( fpath, fmode, attrset )
char	*fpath;
int	fmode;		/* fmode : Unix file permission mode */
int	attrset;
#endif
{
#ifdef	XXX
	char			Tname[4][40];
	DWORD			acs_perm[4] = { GENERIC_ALL, 0, 0, 0 };
	DWORD			cf_perm[3] = { GENERIC_READ, GENERIC_WRITE,
						GENERIC_EXECUTE };

	int			i, j;
	int			cf_mode;
	int			retv = 0;
	char			domain[40];
	DWORD			dwRes, namelen, domainlen;
	PSID			osid, gsid;
	PACL			pNewDACL;
	EXPLICIT_ACCESS		ea;
	SID_NAME_USE		eUse;
	PSECURITY_DESCRIPTOR	pSD;
#endif
	if ( 1 )
		return ( 0 );
#ifdef	XXX
	/* Initialize */
	strcpy( Tname[0], "Administrators" );
	Tname[1][0] = (char)0;
	Tname[2][0] = (char)0;
	strcpy( Tname[3], "Everyone" );

	pNewDACL = (PACL)0;
	pSD = (PSECURITY_DESCRIPTOR)0;

	/* Change by KJC 980802 ************
	if( attrset )
	***********************************/
	if( attrset > 12 )
	/**********************************/
	{
		int	pmode = 0;

		if( fmode & 0200 )       /* write mode */
			pmode |= _S_IWRITE;
		if( fmode & 0400 )       /* read mode */
			pmode |= _S_IREAD;
		if( chmod( fpath, pmode ) == -1 )
			return( errno );
	}

	dwRes = GetNamedSecurityInfo( fpath, SE_FILE_OBJECT,
	      OWNER_SECURITY_INFORMATION | GROUP_SECURITY_INFORMATION,
	      &osid, &gsid, (PACL *)0, (PACL *)0, &pSD );
	if ( dwRes != ERROR_SUCCESS )
		return( dwRes );

	namelen = sizeof( Tname[1] );	/* owner name */
	domainlen = sizeof( domain );
	if( !LookupAccountSid( (char *)0, osid, Tname[1], &namelen, domain,
							&domainlen, &eUse ) )
	{
		retv = (int)GetLastError();
		goto cleanup;
	}

	namelen = sizeof( Tname[2] );	/* group name */
	domainlen = sizeof( domain );
	if( !LookupAccountSid( (char *)0, gsid, Tname[2], &namelen, domain,
							&domainlen, &eUse ) )
	{
		retv = (int)GetLastError();
		goto cleanup;
	}

	/* make trustee name list(Tname) */
	for( cf_mode = 0400, i = 1; i < 4; i++ )
	{
		for( j = 0; j < 3; j++ )
		{
			if( fmode & cf_mode )
				acs_perm[i] |= cf_perm[j];
			cf_mode /= 2;
		}
		if( ( acs_perm[i] & GENERIC_READ ) &&
		    ( acs_perm[i] & GENERIC_WRITE ) &&
		    ( acs_perm[i] & GENERIC_EXECUTE ) )
		{
			acs_perm[i] = GENERIC_ALL;
		}
		else if( acs_perm[i] & GENERIC_WRITE )
			acs_perm[i] |= DELETE;
	}

	/* set new file security (ACL) */
	i = strcmp( Tname[0], Tname[1] ) ? 0 : 1;
	for( ; i<4; i++ )
	{
		if( !acs_perm[i] )
			continue;

		ZeroMemory( &ea, sizeof(EXPLICIT_ACCESS) );
		BuildExplicitAccessWithName( &ea, Tname[i], acs_perm[i],
			SET_ACCESS, NO_INHERITANCE );

		dwRes = SetEntriesInAcl( 1, &ea, pNewDACL, &pNewDACL );
		if ( dwRes != ERROR_SUCCESS )
		{
			retv = (int)dwRes;
			goto cleanup;
		}
	}

	dwRes = SetNamedSecurityInfo( fpath, SE_FILE_OBJECT,
		DACL_SECURITY_INFORMATION,
		(PSID)0, (PSID)0, pNewDACL, (PACL)0 );
	if ( dwRes != ERROR_SUCCESS )
	{
		retv = (int)dwRes;
		goto cleanup;
	}

cleanup:
	if( pSD != NULL )
		LocalFree((HLOCAL) pSD);
	if(pNewDACL != NULL)
		LocalFree((HLOCAL) pNewDACL);

	return( retv );
#endif
}

#endif
