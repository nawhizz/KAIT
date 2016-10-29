/* hymsg() : Get language-specific IEAP msgstring for msgid from msgfile */
/* 98.11.2 : 다국어 버전 */
/* 2000.12.15. ksh. digital server porting 반영				*/
/*----------------------------------------------------------------------*/

#include	<stdlib.h>
#include	<stdio.h>
#include	<string.h>			/*2000.12.15*/

#include	"gps.h"
#include	"gpsdef.h"

#define	ENV_MSGDIR		"MSGDIR"	/* <MSGDIR>/... */
#define	ENV_LANGUAGE		"MSGLANG"	/* KOREAN,JAPANESE,ENGLISH */
#define	ENV_MSGHOME_DEFAULT	"IEAPHOME"	/* <IEAPHOME>/msg/... */

/*----------------------------------------------------------------------*/
/* Function Usage */
/*----------------------------------------------------------------------*/
/* get COMBI TOOL's msg string for current country language
	 - for Worldwide Language Support

	msg filepath = $(MSGDIR)/<groupname>/<modulename>.<extension>
		def. MSGDIR = $(IEAPHOME)/msg
		ex. <IEAPHOME>/cops/msg/<groupname>/<modulename>.kor
		if groupname = NULL then no sub directory
		groupname may contail subdirectory ( ex. dltp/tptool )

		file extension 
			= kor when env. MSGLANG = KOREAN
			= jpn when env. MSGLANG = JAPANESE
			= ame when env. MSGLANG = ENGLISH
				none of kor,jpn file exist.

 	msg file format
	#comment... 
	<msgid> <msgstring>
	<msgid> <msgstring>
	...
	ex)
	MSG0001	can't get file path error %s
	MSG0054	"can't get file path error %s"
	MSG0003 
------------------------------------------------------------------------*/

#ifdef	WIN32
extern	DWORD	dwGpsTlsIndex;
#endif

/*----------------------------------------------------------------------*/
/* hymsg() */
/*----------------------------------------------------------------------*/

char * CBD1
#if	defined( __CB_STDC__ )
hymsg( int withmsgid, char *groupname, char *modulename, char *msgid )
#else
hymsg( withmsgid, groupname, modulename, msgid )
int	withmsgid;	/* 1 = return( "<msgid> <msgstring>" ) */
			/* 0 = return( "<msgstring>" ) */
char	*groupname;	/* group name. may be NULL. */
			/* may contain directory separator. */
			/* ex. "tptool", "dltp/tptool", */
			/*     "dltp\\tptool\\sub1". NULL */
char	*modulename;	/* module name. ex. "txidman" */
char	*msgid;		/* message id. unique within each module. */
			/* ex. "MSG0001" */
#endif
{
#ifdef	WIN32
	register	msgidx;
	char	*msgbuf;	/* message buffer to return */
				/* this to be into TLS for MULTITHREAD */
#else
static	int	msgidx = 0;
static	char	m_msgbuf[MAXMSGCNT][MAXMSGBUF];	/* message buffer to return */
				/* this to be into TLS for MULTITHREAD */
	char	*msgbuf;
#endif
	FILE	*msgFD;
	char	*envval;
	char	msgfpath[256];
	char	tmpbuf[256];	/* tmp buffer */
	char	*dptr;	/* dest msgstring ptr in tmpbuf */
	char	*sptr;	/* source msgstring ptr in linebuf */
static	char	tab_fileext[4][4] = { "kor", "jpn", "ame", "ame" };
	char	*extptr;	/* file extension ptr */
	register	nitm;
	register	i;
	char	linebuf[256];

#ifdef	WIN32
	if ( ( ( (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex ) )->g_msgidx ) >= MAXMSGCNT - 1 )
		( ( (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex ) )->g_msgidx ) = 0;
	msgidx = ( ( (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex ) )->g_msgidx )++;
	msgbuf = ( ( (struct GPS_GLOBAL_DATA *)TlsGetValue( dwGpsTlsIndex ) )->g_msgbuf[msgidx] );
#else
	if (msgidx>=MAXMSGCNT-1)
		msgidx=0;

	msgbuf = m_msgbuf[msgidx++];
#endif

	if( ( envval = getenv( ENV_LANGUAGE ) ) )
	{
		if( !strcmp( envval, "KOREAN" ) )
			extptr = tab_fileext[0];
		else if( !strcmp( envval, "JAPANESE" ) )
			extptr = tab_fileext[1];
		else if( !strcmp( envval, "ENGLISH" ) )
			extptr = tab_fileext[2];
		else					/* default. */
/*98.11.2 delete	extptr = tab_fileext[3]; */
			extptr = envval;	/*98.11.2*/
	}
	else
	{
		extptr = tab_fileext[3];			/* default. */
	}
	
	
	if( !modulename )
	{
		sprintf( msgbuf,
			"Program ERR! hymsg():arg modulename unspecified." );
		return( msgbuf );
	}
	if( !msgid )
	{
		sprintf( msgbuf,
			"Program ERR! hymsg():arg msgid unspecified." );
		return( msgbuf );
	}

	if( ( envval = getenv( ENV_MSGDIR ) ) )
	{
		if( groupname )
			sprintf( msgfpath, "%s/%s/%s.%s",
				envval, groupname, modulename, extptr );
		else
			sprintf( msgfpath,
				"%s/%s.%s", envval, modulename, extptr );
	}
	else if( ( envval = getenv( ENV_MSGHOME_DEFAULT ) ) )
	{
		if( groupname )
			sprintf( msgfpath, "%s/msg/%s/%s.%s",
				envval, groupname, modulename, extptr );
		else
			sprintf( msgfpath, "%s/msg/%s.%s",
				envval, modulename, extptr );
	}
	else
	{
		sprintf( msgbuf,
			"ERR! hymsg():environ %s(or %s) not set.",
				ENV_MSGDIR, ENV_MSGHOME_DEFAULT );
		return( msgbuf );
	}

	/* adjust / or \ for UNIX/NT porting */
	for( i=0; i<(int)strlen( msgfpath ); i++ )
	{
#ifdef	WIN32
		if( msgfpath[i] == '/' ) msgfpath[i] = '\\';
#else
		if( msgfpath[i] == '\\' ) msgfpath[i] = '/';
#endif
	}

	msgFD = fopen( msgfpath, "r" );
	if( !msgFD )
	{
		if( !strcmp( extptr, tab_fileext[3] ) )
		{
			sprintf( msgbuf, "ERR! no msgfile %s.", msgfpath );
			return( msgbuf );
		}
		strcpy( tmpbuf, msgfpath );
		memcpy( &msgfpath[ strlen(msgfpath) - strlen(extptr) ],
			tab_fileext[3], sizeof(tab_fileext[3]) );
			
		msgFD = fopen( msgfpath, "r" );
		if( !msgFD )
		{
			sprintf( msgbuf,
				"ERR! no msgfile %s(or .%s).",
				tmpbuf, tab_fileext[3] );
			return( msgbuf );
		}
	}

	for( ; !feof( msgFD ) ; )
	{
		if( fgets( linebuf, MAXMSGBUF, msgFD ) == 0 )
			break;

		/* linebuf[] = <linedata>+ (CR) + (LF) + NULL */
		nitm = sscanf( linebuf, "%s", tmpbuf );
		if( nitm == 0 || nitm == EOF )	/* blank line */
			continue;
		if( tmpbuf[0] == '#' ) continue;	/* assume comment */
		if( strcmp( msgid, tmpbuf ) )	/* not the same msgid */
			continue;

		/* now, msgid[] found in linebuf[]. */

		/* get msg start pointer */
		/* adjust CR/LF to NULL and
		   replace TAB to 1 space(not consider TAB position !).. */
/*2000.12.15. change------------------------------------------------------------
		sptr = (char *)( strstr( linebuf, msgid ) + strlen( msgid ) );
------------------------------------------------------------------------------*/
		sptr = strstr( linebuf, msgid );
		sptr += (int)strlen( msgid );
/*end of 2000.12.15-----------------------------------------------------------*/
			/* sptr = source msgstring ptr(in linebuf) */
			/* dptr = dest msgstring ptr (in tmpbuf) */
		for( dptr = tmpbuf; *sptr; sptr++ )
		{
			switch( *sptr )
			{
			case '\\' :
				switch ( *(++sptr) )
				{
				case '0' :
					*(dptr++) = '\0';
					break;
					/* PENDING: OCTAL NUMBER NOT
						IMPLEMENTED YET */
				case '?' :
					*(dptr++) = '\?';
					break;
				case 'a' :
					*(dptr++) = '\a';
					break;
				case 'b' :
					*(dptr++) = '\b';
					break;
				case 'f' :
					*(dptr++) = '\f';
					break;
				case 'n' :
					*(dptr++) = '\n';
					break;
				case 'r' :
					*(dptr++) = '\r';
					break;
				case 't' :
					*(dptr++) = '\t';
					break;
				case 'v' :
					*(dptr++) = '\v';
					break;
				/* PENDING: HEXADECIMAL NO. NOT IMPLEMENTED YET 
				case 'x' :
					break;
				*/
				default   :
					*(dptr++) = *sptr;
					break;
				}
				break;
			case '\"' :
				if( dptr != tmpbuf ) *dptr++ = '\0';
					/* replase second to NULL */
				else;	/* ignore first appearance */
				break;
			case ' '  :
				if( dptr == tmpbuf ) break;	/*throw away*/
				else	*(dptr++) = ' ';
				break;
			case '\t' :
				if( dptr == tmpbuf ) break;	/*throw away*/
				*(dptr++) = ' '; break;
			case '\r' :
			case '\n' :
				*(dptr++) = '\0'; break;
			default   :
				*(dptr++) = *sptr;
				break;
			}
		}
		*dptr = '\0';
		fclose( msgFD );
		if( dptr == tmpbuf )	/* no msgstring */
		{
			sprintf( msgbuf,
				"ERR! %s has no value in %s.",
				msgid, msgfpath );
			return( msgbuf );
		}
		else if( withmsgid )
		{
			sprintf( msgbuf, "%s %s", msgid, tmpbuf );
			return( msgbuf );
		}
		else
		{
			strcpy( msgbuf, tmpbuf );
			return( msgbuf );
		}
	}
	fclose( msgFD );
	sprintf( msgbuf,
		"ERR! %s undefined in %s.", msgid, msgfpath );
	return( msgbuf );
}
