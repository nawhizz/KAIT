/* l_ntchown() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : Change file owner in NT system only				*/
/*----------------------------------------------------------------------*/
/* internal function */

#ifdef		WIN32

#include	<aclapi.h>
#include	<lm.h>

int
#if	defined( __CB_STDC__ )
l_ntchown( char *fpath, char *owner )
#else
l_ntchown( fpath, owner )
char	*fpath;
char	*owner;
#endif
{
#ifdef	XXX
	int			i, retv = 0;
	char			group[40];
	char			oldowner[40], oldgroup[40];
	char			domain[40];
	WCHAR			Wowner[40];
	DWORD			dwRes;
	DWORD			sidlen, namelen, domainlen;
	DWORD			prefmaxlen, entriesread, totalentries;
	PSID			osid, gsid;
	PACL			pOldDACL, pNewDACL;
	ULONG			ecnt;
	SID_NAME_USE		eUse;
	EXPLICIT_ACCESS		ea;
	PEXPLICIT_ACCESS	lExpEnt;
	PSECURITY_DESCRIPTOR	pSD;
	PUSER_INFO_3		pU;
	PGROUP_INFO_2		pG;
	PGROUP_USERS_INFO_0	pGU;
#endif

	/* set group and DACL, but not set owner. skip chown */
	if( 1 )
		return( 0 );

#ifdef XXXX
	/* Initialize */
	pSD = (PSECURITY_DESCRIPTOR)0;
	lExpEnt = (PEXPLICIT_ACCESS)0;
	pU = (PUSER_INFO_3)0;
	pGU = (PGROUP_USERS_INFO_0)0;
	pNewDACL = (PACL)0;

	/* get a pointer to the existing DACL */
	dwRes = GetNamedSecurityInfo( fpath, SE_FILE_OBJECT, 
	      OWNER_SECURITY_INFORMATION | GROUP_SECURITY_INFORMATION |
	      DACL_SECURITY_INFORMATION,
	      &osid, &gsid, &pOldDACL, (PACL *)0, &pSD );
	if( dwRes != ERROR_SUCCESS )
	{
		retv = (int)dwRes;
		osid = (PSID)0;
		gsid = (PSID)0;
		goto cleanup;
	}

	namelen = sizeof( oldowner );
	domainlen = sizeof( domain );
	if( !LookupAccountSid( (LPCTSTR)0, osid, oldowner, &namelen, domain,
							&domainlen, &eUse ) )
	{
		retv = (int)GetLastError();
		osid = (PSID)0;
		gsid = (PSID)0;
		goto cleanup;
	}
	osid = (PSID)0;

	namelen = sizeof( oldgroup );
	domainlen = sizeof( domain );
	if( !LookupAccountSid( (LPCTSTR)0, gsid, oldgroup, &namelen, domain,
							&domainlen, &eUse ) )
	{
		retv = (int)GetLastError();
		gsid = (PSID)0;
		goto cleanup;
	}
	gsid = (PSID)0;

	dwRes = GetExplicitEntriesFromAcl( pOldDACL, &ecnt, &lExpEnt );
	if( dwRes != ERROR_SUCCESS )
	{
		retv = (int)dwRes;
		goto cleanup;
	}

	/* Get Primary group name */
	MultiByteToWideChar( CP_ACP, MB_PRECOMPOSED, owner, -1, Wowner,
							sizeof Wowner );
	if( ( retv = NetUserGetInfo( (LPWSTR)0, Wowner, 3, (LPBYTE *)&pU ) )
							!= NERR_Success )
		goto cleanup;

	/* Get Group list of owner */
	prefmaxlen = 1000;
	if( ( retv = NetApiBufferAllocate( prefmaxlen, &pGU ) )
							!= NERR_Success )
		goto cleanup;

	if( ( retv = NetUserGetGroups( (LPWSTR)0, Wowner, 0, (LPBYTE *)&pGU,
		prefmaxlen, &entriesread, &totalentries ) ) != NERR_Success )
		goto cleanup;

	/* Find Primay Group Name */
	for( i=0; i < (int)entriesread; i++ )
	{
		if( ( retv = NetGroupGetInfo( (LPWSTR)0, pGU[i].grui0_name, 2,
					(LPBYTE *)&pG ) ) != NERR_Success )
			goto cleanup;

		if( pU->usri3_primary_group_id != pG->grpi2_group_id )
		{
			NetApiBufferFree( pG );
			continue;
		}

		NetApiBufferFree( pG );

		if( !WideCharToMultiByte( CP_ACP, 0, pGU[i].grui0_name, -1,
				group, sizeof( group ), (LPCSTR)0, (LPBOOL)0 ) )
		{
			retv = GetLastError();
			goto cleanup;
		}
		break;
	}

	/* Get SID of owner */
	sidlen = 0;
	domainlen = sizeof( domain );
	if( !LookupAccountName( (LPCTSTR)0, owner, osid, &sidlen, domain,
							&domainlen, &eUse ) )
	{
		if( sidlen == 0 )
		{
			retv = (int)GetLastError();
			goto cleanup;
		}

		osid = (PSID)malloc( (int)sidlen );
		if( !LookupAccountName( (LPCTSTR)0, owner, osid, &sidlen,
						domain, &domainlen, &eUse ) )
		{
			retv = (int)GetLastError();
			goto cleanup;
		}
	}

	/* Get SID of group */
	sidlen = 0;
	domainlen = sizeof( domain );
	if( !LookupAccountName( (LPCTSTR)0, group, gsid, &sidlen, domain,
							&domainlen, &eUse ) )
	{
		if( sidlen == 0 )
		{
			retv = (int)GetLastError();
			goto cleanup;
		}

		gsid = (PSID)malloc( (int)sidlen );
		if( !LookupAccountName( (LPCTSTR)0, group, gsid, &sidlen,
						domain, &domainlen, &eUse ) )
		{
			retv = (int)GetLastError();
			goto cleanup;
		}
	}

	/* Change Trustee name */
	for( i=0; i<(int)ecnt; i++ )
	{
		if( !strcmp( oldowner, lExpEnt[i].Trustee.ptstrName ) )
			lExpEnt[i].Trustee.ptstrName = owner;
		else if( !strcmp( oldgroup, lExpEnt[i].Trustee.ptstrName ) )
			lExpEnt[i].Trustee.ptstrName = group;
	}

	dwRes = SetEntriesInAcl( ecnt, lExpEnt, (PACL)0, &pNewDACL );
	if( dwRes != ERROR_SUCCESS )
	{
		retv = (int)dwRes;
		goto cleanup;
	}

	/* Add all permission for Administrators */
	ZeroMemory( &ea, sizeof(EXPLICIT_ACCESS) );
	BuildExplicitAccessWithName( &ea, "Administrators", GENERIC_ALL,
		SET_ACCESS, NO_INHERITANCE );
	dwRes = SetEntriesInAcl( 1, &ea, pNewDACL, &pNewDACL );
	if( dwRes != ERROR_SUCCESS )
	{
		retv = (int)dwRes;
		goto cleanup;
	}

	/* Build new DACL and change owner & group */
	dwRes = SetNamedSecurityInfo( fpath, SE_FILE_OBJECT,
		OWNER_SECURITY_INFORMATION | GROUP_SECURITY_INFORMATION
		| DACL_SECURITY_INFORMATION, osid, gsid, pNewDACL, (PACL)0 );
	if( dwRes != ERROR_SUCCESS )
	{
		retv = (int)dwRes;
		goto cleanup;
	}

cleanup:
	if( pSD != (PSECURITY_DESCRIPTOR)0 )
		LocalFree( (HLOCAL)pSD );
	if( lExpEnt != (PEXPLICIT_ACCESS)0 )
		LocalFree( (HLOCAL)lExpEnt );
	if( pU != (PUSER_INFO_3)0 )
		NetApiBufferFree( pU );
	if( pGU != (PGROUP_USERS_INFO_0)0 )
		NetApiBufferFree( pGU );
	if( osid != (PSID)0 )
		free( osid );
	if( gsid  != (PSID)0 )
		free( gsid );
	if( pNewDACL != (PACL)0 )
		LocalFree( (HLOCAL)pNewDACL );

	return( retv );
#endif
}

#endif
