/* cfgfun.c : LIB gps */
/*===== Common ========================================================*/

/*----- include header ------------------------------------------------*/
#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#ifndef		WIN32
#include	<unistd.h>
#endif
#include	<ctype.h>

#include	"gps.h"

/*----- declare structure ---------------------------------------------*/
struct	CFG_ITEM_FORM	{
	char			*name;		/* name of item */
	char			*value;		/* value of item */
	char			*real;		/* if is null, real = value */
						/* if is -1, value is invalid */
	char			*comment;	/* comment of item */
	struct	CFG_ITEM_FORM	*next;		/* pointer of next item */
};

struct	CFG_GROUP_FORM	{
	char			*gname;		/* name of group */
	char			*comment;	/* comment of group */
	int			MaxItemNameLen;	/* Max. length of item name */
	int			MaxItemValLen;	/* Max. length of item value */
	struct	CFG_ITEM_FORM	*item;		/* pointer of first item */
	struct	CFG_GROUP_FORM	*next;		/* pointer of next group */
};

struct	CFG_COMM_FORM	{			/* header comment */
	char			*comment;	/* comment */
	struct	CFG_COMM_FORM	*next;		/* pointer of next comment */
};

struct	CFG_FD_FORM	{
	int			fd;		/* open file number */
	int			status;		/* change flag */
	FILE			*FD;		/* FILE */
	char			*fname;		/* configuration file name */
	struct	CFG_GROUP_FORM	*group;		/* pointer of first group */
	struct	CFG_COMM_FORM	*comment;	/* ptr of first head comment */
	struct	CFG_GROUP_FORM	*scangrp;	/* ptr of current scan group */
	struct	CFG_ITEM_FORM	*scanitem;	/* pt of current scan item */
	struct	CFG_FD_FORM	*next;		/* pointer of next FD */
};

typedef	struct	CFG_FD_FORM	CFGF;
typedef	struct	CFG_GROUP_FORM	CFGG;
typedef	struct	CFG_ITEM_FORM	CFGI;
typedef	struct	CFG_COMM_FORM	CFGC;

/*----- internal function proto ---------------------------------------*/
static	CFGG	*l_NewGroupMakeFormFile CBD2(( char *iobuf ));
static	CFGC	*l_NewCommentMakeFormFile CBD2(( char *iobuf ));
static	CFGI	*l_NewItemMakeFromFile CBD2(( char *iobuf, CFGG *grp, CFGF *cfg ));
static	int	l_getgrpname CBD2(( char *linebuf, char **name, int *namelen,
				char **comment, int *comlen ));
static	int	l_getitemname CBD2(( char *linebuf, char **name, int *namelen,
				char **value, int *valuelen,
				char **comment, int *comlen ));
static	int	l_getreal CBD2(( char **real, char *value,CFGF *cfgfd ));
static	int	l_getenvvalue CBD2(( char **envvalue, char *envname,
						CFGF *cfgfd ));
static	char	*l_gets CBD2(( char *line, int len, char *buff, int *offset ));
static	void	l_fdfree CBD2(( CFGF *cfg ));
static	void	l_groupfree CBD2(( CFGG *cfggrp ));
static	void	l_itemfree CBD2(( CFGI *cfgitem ));
static	void	l_commfree CBD2(( CFGC *cfgcomm ));
static	void	*l_alloc CBD2(( int len ));
static	void	l_free CBD2(( void *ptr ));
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
extern	void	l_gpssethyerrno CBD2(( int gps_hyerrno ));
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

/*----- external variables --------------------------------------------*/
static	CFGF	*cfgbank = (CFGF *)0;
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
#ifdef	WIN32
extern	CRITICAL_SECTION	CfgCrtSec;
#endif
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

/*===== external modules ( file io ) ==================================*/
/*----------------------------------------------------------------------+
|	cfg open							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_open( char *cfgfpath, char *mode )
#else
cfg_open( cfgfpath, mode )
char	*cfgfpath;
char	*mode;
#endif
{
	CFGF	*cfg;
	CFGF	*cfgnew;
	CFGG	*grp;
	CFGI	*item;
	CFGI	*itemnew;
	CFGC	*comm;
	char	fmode[ 4 ];
	char	iobuf[ 512 ];
	char	tmpbuf[ 512 ];

	/* check argument */
	if( cfgfpath == (char *)0 || cfgfpath[ 0 ] == (char)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	/* check argument ( mode ) */
	if( !strcmp( mode, "r" ) )
/*
		strcpy( fmode, "r+" );
*/
		strcpy( fmode, "rb" );
	else if( strcmp( mode, "r+" ) && strcmp( mode, "w" ) )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return -1;
	}
	else
	{
		strcpy( fmode, mode );
		strcat( fmode, "b" );
	}

	/* search last cfg */
	if( cfgbank != (CFGF *)0 )
	{
		for( cfg=cfgbank; ; cfg=cfg->next)
		{
			if( !strcmp( cfgfpath, cfg->fname ) )
				return( cfg->fd );
			if( cfg->next == (CFGF *)0 )
				break;
		}
	}

	/* allocate for new cfg */
	if( ( cfgnew = (CFGF *)l_alloc( sizeof( CFGF ) ) ) == (CFGF *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	/* initialize new cfg */
	cfgnew->fd = 0;
	cfgnew->status = 0;
	cfgnew->FD = (FILE *)0;
	cfgnew->fname = (char *)0;
	cfgnew->group = (CFGG *)0;
	cfgnew->comment = (CFGC *)0;
	cfgnew->scangrp = (CFGG *)0;
	cfgnew->scanitem = (CFGI *)0;
	cfgnew->next = (CFGF *)0;

	/* open configuration file */
	if( ( cfgnew->FD = fopen( cfgfpath, fmode ) ) == (FILE *)0 )
	{
		l_free( cfgnew );
		if( cfgbank == (CFGF *)0 )
			l_alloc( 0 );			/* free trunk memory */
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOENT;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOENT );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}
	cfgnew->fd = fileno( cfgnew->FD );

	/* set configuration file name */
	cfgnew->fname = (char *)l_alloc( strlen( cfgfpath ) + 1 );
	if( cfgnew->fname == (char *)0 )
	{
		fclose( cfgnew->FD );
		if( !strcmp( fmode, "w" ) )
			unlink( cfgfpath );
		l_free( cfgnew );
		if( cfgbank == (CFGF *)0 )
			l_alloc( 0 );			/* free trunk memory */
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}
	strcpy( cfgnew->fname, cfgfpath );


	/* if mode is read, read configuration to memory */
	if( fmode[ 0 ] != 'w' )
	{
		grp = (CFGG *)0;

		/* read one line */
		while( fgets( iobuf, sizeof iobuf, cfgnew->FD ) != (char *)0 )
		{
			if( sscanf( iobuf, "%s", tmpbuf ) <= 0 )
				continue;

			/* case if line is Group Name */
			if( tmpbuf[ 0 ] == '[' )
			{
				CFGG	*grpnew;

				/* make new group */
				grpnew = l_NewGroupMakeFormFile( iobuf );
				if( grpnew == (CFGG *)0 )
				{
					l_fdfree( cfgnew );
					return( -1 );
				}

				/* linkage new group */
				if( cfgnew->group == (CFGG *)0 )
				{
					cfgnew->group = grpnew;
					grp = grpnew;
				}
				else
				{
					grp->next = grpnew;
					grp = grpnew;
				}

				continue;

			} /* end of if Group Name */

			/* case if line is not Group Name */
			/* 1. case comment line before any group start */
			/* 2. case entry before any group start */
			if( grp == (CFGG *)0 )
			{					/* None Group */
				CFGC	*commnew;

				if( tmpbuf[ 0 ] != '#' )
					continue;

				/*
				** comments of no group
				*/

				/* make new head comment of CFG */
				commnew = l_NewCommentMakeFormFile( iobuf );
				if( commnew == (CFGC *)0 )
					continue;

				/* linkage comment */
				if( cfgnew->comment == (CFGC *)0 )
				{
					cfgnew->comment = commnew;
					comm = commnew;
				}
				else
				{
					comm->next = commnew;
					comm = commnew;
				}

				continue;
			}

			/* 3. case next entry for a Group */
			/* make new item */
			itemnew = l_NewItemMakeFromFile( iobuf, grp, cfgnew );
			if( itemnew == (CFGI *)0 )
			{
				l_fdfree( cfgnew );
				return( -1 );
			}

			/* linkage new item */
			if( grp->item == (CFGI *)0 )
			{
				grp->item = itemnew;
				item = itemnew;
			}
			else
			{
				item->next = itemnew;
				item = itemnew;
			}

		} /* end of while */

	} /* end if mode is read */

/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
#ifdef	WIN32
	EnterCriticalSection( &CfgCrtSec );
#endif
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
	/* linkage new cfg */
	if( cfgbank == (CFGF *)0 )
		cfgbank = cfgnew;
	else
		cfg->next = cfgnew;
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
#ifdef	WIN32
	LeaveCriticalSection( &CfgCrtSec );
#endif
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

	return( cfgnew->fd );

} /* cfg_open */

/*----------------------------------------------------------------------+
|	cfg close							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_close( int fd )
#else
cfg_close( fd )
int	fd;
#endif
{
	CFGF	*cfg;
	CFGF	*cfgprev;

	if( cfgbank == (CFGF *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	cfgprev = (CFGF *)0;
	for( cfg=cfgbank; ; cfgprev=cfg, cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	if( cfg->status )
		cfg_flush( fd );

	if( cfgprev == (CFGF *)0 )
		cfgbank = cfg->next;
	else
		cfgprev->next = cfg->next;

	cfg->next = (CFGF *)0;
	l_fdfree( cfg );

	return( 0 );

} /* cfg_close */

/*----------------------------------------------------------------------+
|	cfg flush							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_flush( int fd )
#else
cfg_flush( fd )
int	fd;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;
	CFGC	*comm;
	int			fsize;
	int			csize;
	int			nmtab;
	int			valtab;
	int			tabcnt;

	if( cfgbank == (CFGF *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	fseek( cfg->FD, 0L, SEEK_END );
	fsize = ftell( cfg->FD );
	rewind( cfg->FD );

	for( comm=cfg->comment; comm!=(CFGC *)0; comm=comm->next )
	{
		if( comm->comment[ 0 ] == '[' )
			fprintf( cfg->FD, "#%s\n", comm->comment );
		else
			fprintf( cfg->FD, "#%s\n", comm->comment );
	}

	for( grp=cfg->group; grp!=(CFGG *)0; grp=grp->next )
	{
		if( grp->comment != (char *)0 )
			fprintf( cfg->FD, "\n[ %s ]\t# %s\n\n",
						grp->gname, grp->comment );
		else
			fprintf( cfg->FD, "\n[ %s ]\n\n", grp->gname );

		nmtab = grp->MaxItemNameLen / 8 + 1;
		valtab = ( grp->MaxItemValLen + 2 ) / 8 + 1;

		for( item=grp->item; item!=(CFGI *)0; item=item->next )
		{
			if( item->name != (char *)0 )
			{
				fprintf( cfg->FD, "\t%s", item->name );

				tabcnt = nmtab - (int)strlen( item->name ) / 8;
				for( ; tabcnt>0; tabcnt-- )
					fprintf( cfg->FD, "\t" );

				fprintf( cfg->FD, "= %s", item->value );
			}

			if( item->comment == (char *)0 )
				fprintf( cfg->FD, "\n" );
			else
			{
				if( item->name == (char *)0 )
				{
					if( item->comment[ 0 ] == '[' )
					{
						fprintf( cfg->FD, "#%s\n",
								item->comment );
					}
					else
					{
						fprintf( cfg->FD, "#\t%s\n",
								item->comment );
					}
				}
				else
				{
					tabcnt = valtab
						- ( (int)strlen(item->value)+2 ) / 8;
					for( ; tabcnt>0; tabcnt-- )
						fprintf( cfg->FD, "\t" );
					fprintf( cfg->FD, "#%s\n",
								item->comment );
				}
			}

		} /* end of for item */

	} /* end of for group */

	csize = ftell( cfg->FD );

	if( fsize > csize )
	{
		int	linecnt;
		int	remain;

		linecnt = ( fsize - csize ) / 81;
		remain = ( fsize - csize ) % 81 - 1;
		for( ; linecnt>0; linecnt-- )
			fprintf( cfg->FD, "%*.*s\n", 80, 80, " " );
		fprintf( cfg->FD, "%*.*s\n", remain, remain, " " );
	}

	cfg->status = 0;

	return( 0 );

} /* cfg_flush */

/*----------------------------------------------------------------------+
|	cfg setenv							|
|	if group is null, all putenv					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_setenv( char *cfgfpath, char *group )
#else
cfg_setenv( cfgfpath, group )
char	*cfgfpath;
char	*group;
#endif
{
	int	fd;
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;
	char	*env;
	int	display = 0;

	if( cfgfpath == (char *)0 || cfgfpath[ 0 ] == (char)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	if( ( fd = cfg_open( cfgfpath, "r" ) ) < 0 )
		return( -1 );

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			cfg_close( fd );
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( grp=cfg->group; grp!=(CFGG *)0; grp=grp->next )
	{
		if( group != (char *)0 && group[ 0 ] != (char)0 )
			if( strcmp( grp->gname, group ) )
				continue;

		display = 1;
		for( item=grp->item; item!=(CFGI *)0; item=item->next )
		{
			if( item->name == (char *)0 )
				continue;

			if( item->real == (char *)-1 )
				continue;
			else if( item->real == (char *)0 )
			{
				env = (char *)malloc( strlen( item->name ) +
					strlen( item->value ) + 2 );
			}
			else
			{
				env = (char *)malloc( strlen( item->name ) +
					strlen( item->real ) + 2 );
			}
			if( env == (char *)0 )
			{
/*	98.09.16 for MultiThread by JJH ( Delete )
				hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
				l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
				cfg_close( fd );
				return( -1 );
			}

			strcpy( env, item->name );
			strcat( env, "=" );
			if( item->real == (char *)0 )
				strcat( env, item->value );
			else
				strcat( env, item->real );

			putenv( env );

		} /* end of for item */

		if( group != (char *)0 && group[ 0 ] != (char)0 )
			break;

	} /* end of for group */

	cfg_close( fd );

	if( !display )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL_GRP;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL_GRP );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	return( 0 );

} /* cfg_setenv */

/*----------------------------------------------------------------------+
|	cfg getenv							|
|	if group is null, search in all group				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_getenv( char *cfgfpath, char *group, char *envname, char *envvalue )
#else
cfg_getenv( cfgfpath, group, envname, envvalue )
char	*cfgfpath;
char	*group;
char	*envname;
char	*envvalue;
#endif
{
	int	fd;
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;

	if( cfgfpath == (char *)0 || cfgfpath[ 0 ] == (char)0 ||
	    envname == (char *)0 || envname[ 0 ] == (char)0 ||
	    envvalue == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	if( ( fd = cfg_open( cfgfpath, "r" ) ) < 0 )
		return( -1 );

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			cfg_close( fd );
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( grp=cfg->group; grp!=(CFGG *)0; grp=grp->next )
	{
		if( group != (char *)0 && group[ 0 ] != (char)0 )
			if( strcmp( grp->gname, group ) )
				continue;

		for( item=grp->item; item!=(CFGI *)0; item=item->next )
		{
			if( item->name == (char *)0 )
				continue;
			if( !strcmp( envname, item->name ) )
			{
				if( item->real == (char *)-1 )
				{
					cfg_close( fd );
/*	98.09.16 for MultiThread by JJH ( Delete )
					hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
					l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
					return( -1 );
				}
				else if( item->real == (char *)0 )
					strcpy( envvalue, item->value );
				else
					strcpy( envvalue, item->real );
				cfg_close( fd );
				return( 0 );
			}
		}

		/* not found envname in input group */
		if( group != (char *)0 && group[ 0 ] != (char)0 )
		{
			cfg_close( fd );
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

	} /* end of for Group */

	cfg_close( fd );

/*	98.09.16 for MultiThread by JJH ( Delete )
	hyerrno = EGP_CFG_INVAL_GRP;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
	l_gpssethyerrno( EGP_CFG_INVAL_GRP );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
	return( -1 );

} /* cfg_getenv */

/*===== external modules ( group io ) =================================*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_readgrp( int fd, char *groupname, char *envbuf, int cr_cnt )
#else
cfg_readgrp( fd, groupname, envbuf, cr_cnt )
int	fd;		/* IN :configruation file descriptor	*/
char	*groupname;	/* IN :read group ID	*/
char	*envbuf;	/* OUT :all environment variable, large buffer */
int	cr_cnt;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;
	char	iobuf[ 512 ];
	int	nmtab;
	int	valtab;
	int	tabcnt;
	int	i;

	if( groupname == (char *)0 || groupname[ 0 ] == (char)0 ||
	    envbuf == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( grp=cfg->group; ; grp=grp->next )
	{
		if( grp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( !strcmp( groupname, grp->gname ) )
			break;
	}

	envbuf[ 0 ] = (char)0;
	nmtab = grp->MaxItemNameLen / 8 + 1;
	valtab = ( grp->MaxItemValLen + 2 ) / 8 + 1;

	for( item=grp->item; item!=(CFGI *)0; item=item->next )
	{
		if( item->name != (char *)0 )
		{
			sprintf( iobuf, "\t%s", item->name );
			strcat( envbuf, iobuf );

			tabcnt = nmtab - (int)strlen( item->name ) / 8;
			for( ; tabcnt>0; tabcnt-- )
				strcat( envbuf, "\t" );

			sprintf( iobuf, "= %s", item->value );
			strcat( envbuf, iobuf );
		}

		if( item->comment == (char *)0 )
		{
			for( i=0; i<cr_cnt; i++ )
				strcat( envbuf, "\r" );
			strcat( envbuf, "\n" );
		}
		else
		{
			if( item->name == (char *)0 )
			{
				if( item->comment[ 0 ] == '[' )
				{
					sprintf( iobuf, "#\t%s",
								item->comment );
				}
				else
				{
					sprintf( iobuf, "#\t%s",
								item->comment );
				}
				strcat( envbuf, iobuf );
				for( i=0; i<cr_cnt; i++ )
					strcat( envbuf, "\r" );
				strcat( envbuf, "\n" );
			}
			else
			{
				tabcnt = valtab - ( (int)strlen(item->value)+2 ) / 8;
				for( ; tabcnt>0; tabcnt-- )
					strcat( envbuf, "\t" );
				sprintf( iobuf, "# %s", item->comment );
				strcat( envbuf, iobuf );
				for( i=0; i<cr_cnt; i++ )
					strcat( envbuf, "\r" );
				strcat( envbuf, "\n" );
			}
		}

	} /* end of for item */

	return( 0 );

} /* cfg_readgrp */

int CBD1
#if	defined( __CB_STDC__ )
cfg_delgrp( int fd, char *groupname )
#else
cfg_delgrp( fd, groupname )
int	fd;
char	*groupname;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGG	*grpprev;

	if( groupname == (char *)0 || groupname[ 0 ] == (char)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	grpprev = (CFGG *)0;
	for( grp=cfg->group; ; grpprev=grp, grp=grp->next )
	{
		if( grp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( !strcmp( groupname, grp->gname ) )
			break;
	}

	if( grpprev == (CFGG *)0 )
		cfg->group = grp->next;
	else
		grpprev->next = grp->next;

	grp->next = (CFGG *)0;
	l_groupfree( grp );

	cfg->status = 1;

	return( 0 );

} /* cfg_delgrp */

int CBD1
#if	defined( __CB_STDC__ )
cfg_wrtgrp( int fd, char *groupname, char *envbuf )
#else
cfg_wrtgrp( fd, groupname, envbuf )
int	fd;
char	*groupname;
char	*envbuf;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGG	*grpnew;
	CFGG	*grpprev;
	CFGI	*item;
	CFGI	*itemnew;
	int	offset = 0;
	char	iobuf[ 512 ];
	char	tmpbuf[ 512 ];

	if( groupname == (char *)0 || groupname[ 0 ] == (char)0 ||
	    envbuf == (char *)0 || envbuf[ 0 ] == (char)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	grpprev = (CFGG *)0;
	for( grp=cfg->group; ; grpprev=grp, grp=grp->next )
	{
		if( grp == (CFGG *)0 )
			break;

		if( !strcmp( groupname, grp->gname ) )
			break;
	}

	/* allocate for new group */
	if( ( grpnew = (CFGG *) l_alloc( sizeof( CFGG ) ) ) == (CFGG *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	/* initialize new group */
	grpnew->gname = (char *)0;
	grpnew->comment = (char *)0;
	grpnew->MaxItemNameLen = 0;
	grpnew->MaxItemValLen = 0;
	grpnew->item = (CFGI *)0;
	grpnew->next = (CFGG *)0;

	/* allocate for group name */
	grpnew->gname = l_alloc( strlen( groupname ) + 1 );
	if( grpnew->gname == (char *)0 )
	{
		l_groupfree( grpnew );
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}
	strcpy( grpnew->gname, groupname );

	if( grp != (CFGG *)0 && grp->comment != (char *)0 )
	{
		grpnew->comment = (char *)l_alloc( strlen( grp->comment ) + 1 );
		if( grpnew->comment == (char *)0 )
		{
			l_groupfree( grpnew );
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		strcpy( grpnew->comment, grp->comment );
	}


	while( l_gets( iobuf, sizeof iobuf, envbuf, &offset ) != (char *)0 )
	{
		if( sscanf( iobuf, "%s", tmpbuf ) <= 0 )
			continue;

		/* case if line is Group Name */
		if( tmpbuf[ 0 ] == '[' )
		{
			l_groupfree( grpnew );
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_INVAL_GRP;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_INVAL_GRP );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		/* make new item */
		itemnew = l_NewItemMakeFromFile( iobuf, grpnew, cfg );
		if( itemnew == (CFGI *)0 )
		{
			l_groupfree( grpnew );
			return( -1 );
		}

		/* linkage new item */
		if( grpnew->item == (CFGI *)0 )
		{
			grpnew->item = itemnew;
			item = itemnew;
		}
		else
		{
			item->next = itemnew;
			item = itemnew;
		}

	} /* end of while */

	/* linkage new group */
	if( grp != (CFGG *)0 )
		grpnew->next = grp->next;
	if( grpprev == (CFGG *)0 )
		cfg->group = grpnew;
	else
		grpprev->next = grpnew;


	if( grp != (CFGG *)0 )
	{
		grp->next = (CFGG *)0;
		l_groupfree( grp );
	}

	cfg->status = 1;

	return( 0 );

} /* cfg_wrtgrp */

/*===== external modules ( item io ) ==================================*/
/*----------------------------------------------------------------------+
|	read environ value and comment with groupname and environ name	|
|	if group is null, search in all group				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_readenv( int fd, char *groupname, char *envname, char *envvalue, char *comment )
#else
cfg_readenv( fd, groupname, envname, envvalue, comment )
int	fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;

	if( envname == (char *)0 || envname[ 0 ] == (char)0 ||
	    envvalue == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( grp=cfg->group; ; grp=grp->next )
	{
		if( grp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( groupname != (char *)0 && groupname[ 0 ] != (char)0 )
		{
			if( strcmp( groupname, grp->gname ) )
				continue;
		}

		for( item=grp->item; ; item=item->next )
		{
			if( item == (CFGI *)0 )
			{
				if( groupname != (char *)0 &&
				    groupname[ 0 ] != (char)0 )
				{
/*	98.09.16 for MultiThread by JJH ( Delete )
					hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
					l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
					return( -1 );
				}
				break;
			}

			if( item->name == (char *)0 )
				continue;
			if( strcmp( envname, item->name ) )
				continue;

			if( item->real == (char *)-1 )
				continue;
			else if( item->real == (char *)0 )
				strcpy( envvalue, item->value );
			else
				strcpy( envvalue, item->real );
			if( comment != (char *)0 )
			{
				if( item->comment != (char *)0 )
					strcpy( comment, item->comment );
				else
					comment[ 0 ] = (char)0;
			}

			return( 0 );

		} /* end of for item */

	} /* end of for group */

} /* cfg_readenv */

/*----------------------------------------------------------------------+
|	delete environ with groupname and environ name			|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_delenv( int fd, char *groupname, char *envname )
#else
cfg_delenv( fd, groupname, envname )
int	fd;
char	*groupname;
char	*envname;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;
	CFGI	*itemprev;

	if( groupname == (char *)0 || groupname[ 0 ] == (char)0 ||
	    envname == (char *)0 || envname[ 0 ] == (char)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( grp=cfg->group; ; grp=grp->next )
	{
		if( grp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( strcmp( groupname, grp->gname ) )
			continue;

		itemprev = (CFGI *)0;
		for( item=grp->item; ; itemprev=item, item=item->next )
		{
			if( item == (CFGI *)0 )
			{
/*	98.09.16 for MultiThread by JJH ( Delete )
				hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
				l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
				return( -1 );
			}

			if( item->name == (char *)0 )
				continue;
			if( strcmp( envname, item->name ) )
				continue;

			if( itemprev == (CFGI *)0 )
				grp->item = item->next;
			else
				itemprev->next = item->next;

			item->next = (CFGI *)0;
			l_itemfree( item );
			cfg->status = 1;

			return( 0 );

		} /* end of for item */

	} /* end of for group */

} /* cfg_delenv */

/*----------------------------------------------------------------------+
|	write environ with groupname and environ name			|
|	if environ name exist in CFG-table update, else append it	|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_wrtenv( int fd, char *groupname, char *envname, char *envvalue, char *comment )
#else
cfg_wrtenv( fd, groupname, envname, envvalue, comment )
int	fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
#endif
{
	CFGF	*cfg;
	CFGG	*grp;
	CFGI	*item;
	CFGI	*itemprev;
	CFGI	*itemnew;

	if( groupname == (char *)0 || groupname[ 0 ] == (char)0 ||
	    envname == (char *)0 || envname[ 0 ] == (char)0 ||
	    envvalue == (char *)0 || envvalue[ 0 ] == (char)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( grp=cfg->group; ; grp=grp->next )
	{
		if( grp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( strcmp( groupname, grp->gname ) )
			continue;

		itemprev = (CFGI *)0;
		for( item=grp->item; ; itemprev=item, item=item->next )
		{
			if( item == (CFGI *)0 )
				break;

			if( item->name == (char *)0 )
				continue;

			if( !strcmp( envname, item->name ) )
				break;
		}

		/*
		** create Item
		*/

		/* allocate for new item */
		itemnew = (CFGI *)l_alloc( sizeof( CFGI ) );
		if( itemnew == (CFGI *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		/* initialize new item */
		itemnew->name = (char *)0;
		itemnew->value = (char *)0;
		itemnew->real = (char *)0;
		itemnew->comment = (char *)0;
		itemnew->next = (CFGI *)0;

		/* set environ name of new item */
		itemnew->name = (char *)l_alloc( strlen( envname ) + 1 );
		if( itemnew->name == (char *)0 )
		{
			l_itemfree( itemnew );
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		strcpy( itemnew->name, envname );

		/* set environ value of new item */
		itemnew->value = (char *)l_alloc( strlen( envvalue ) + 1 );
		if( itemnew->value == (char *)0 )
		{
			l_itemfree( itemnew );
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		strcpy( itemnew->value, envvalue );

		/* set environ real of new item */
		if( l_getreal( &itemnew->real, itemnew->value, cfg ) < 0 )
		{
			l_itemfree( itemnew );
			return( -1 );
		}

		/* set comment of new item */
		if( comment != (char *)0 && comment[ 0 ] != (char)0 )
		{
			itemnew->comment = (char *)l_alloc(
							strlen( comment ) + 1 );
			if( itemnew->comment == (char *)0 )
			{
/*	98.09.16 for MultiThread by JJH ( Delete )
				hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
				l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
				l_itemfree( itemnew );
				return( -1 );
			}
			strcpy( itemnew->comment, comment );
		}

		/* change group information of new item */
		if( (int)strlen( envname ) > grp->MaxItemNameLen )
			grp->MaxItemNameLen = strlen( envname );
		if( (int)strlen( envvalue ) > grp->MaxItemValLen )
			grp->MaxItemValLen = strlen( envvalue );
		if( grp->MaxItemValLen > 39 )
			grp->MaxItemValLen = 39;

		/* linkage new item */
		if( item != (CFGI *)0 )
			itemnew->next = item->next;
		if( itemprev == (CFGI *)0 )
			grp->item = itemnew;
		else
			itemprev->next = itemnew;

		/* free old item */
		if( item != (CFGI *)0 )
		{
			item->next = (CFGI *)0;
			l_itemfree( item );
		}

		cfg->status = 1;

		return( 0 );

	} /* end of for group */

} /* cfg_wrtenv */

/*===== external modules ( scan group/item ) ==========================*/
/*----------------------------------------------------------------------+
|	scan first group name						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_scangrp( int fd, char *groupname )
#else
cfg_scangrp( fd, groupname )
int	fd;
char	*groupname;
#endif
{
	CFGF	*cfg;

	if( groupname == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	cfg->scanitem = (CFGI *)0;
	cfg->scangrp = cfg->group;
	if( cfg->scangrp == (CFGG *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	strcpy( groupname, cfg->scangrp->gname );

	return( 0 );

} /* cfg_scangrp */

/*----------------------------------------------------------------------+
|	scan next group name						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_nextgrp( int fd, char *groupname )
#else
cfg_nextgrp( fd, groupname )
int	fd;
char	*groupname;
#endif
{
	CFGF	*cfg;

	if( groupname == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	cfg->scanitem = (CFGI *)0;
	if( cfg->scangrp == (CFGG *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	cfg->scangrp = cfg->scangrp->next;
	if( cfg->scangrp == (CFGG *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	strcpy( groupname, cfg->scangrp->gname );

	return( 0 );

} /* cfg_nextgrp */

/*----------------------------------------------------------------------+
|	scan first item name, value and comment				|
|	if group is null, search in all group				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_scanenv( int fd, char *groupname, char *envname, char *envvalue, char *comment )
#else
cfg_scanenv( fd, groupname, envname, envvalue, comment )
int	fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
#endif
{
	CFGF	*cfg;

	if( envname == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( cfg->scangrp=cfg->group; ; cfg->scangrp=cfg->scangrp->next )
	{
		if( cfg->scangrp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( groupname != (char *)0 && groupname[ 0 ] != (char)0 )
		{
			if( strcmp( groupname, cfg->scangrp->gname ) )
				continue;
		}

		for( cfg->scanitem = cfg->scangrp->item; ;
					cfg->scanitem = cfg->scanitem->next )
		{
			if( cfg->scanitem == (CFGI *)0 )
			{
				if( groupname != (char *)0 &&
				    groupname[ 0 ] != (char)0 )
				{
/*	98.09.16 for MultiThread by JJH ( Delete )
					hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
					l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
					return( -1 );
				}
				break;
			}

			if( cfg->scanitem->name == (char *)0 )
				continue;

			strcpy( envname, cfg->scanitem->name );
			if( envvalue != (char *)0 )
			{
				if( cfg->scanitem->real == (char *)-1 )
					continue;
				else if( cfg->scanitem->real == (char *)0 )
					strcpy( envvalue,cfg->scanitem->value );
				else
					strcpy( envvalue, cfg->scanitem->real );
			}
			if( comment != (char *)0 )
			{
				if( cfg->scanitem->comment != (char *)0 )
					strcpy( comment,
						cfg->scanitem->comment );
				else
					comment[ 0 ] = (char)0;
			}

			return( 0 );

		} /* end of for scan item */

	} /* end of for scan group */

} /* cfg_scanenv */

/*----------------------------------------------------------------------+
|	scan next item name, value and comment				|
|	if group is null, search in all group				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
cfg_nextenv( int fd, char *groupname, char *envname, char *envvalue, char *comment )
#else
cfg_nextenv( fd, groupname, envname, envvalue, comment )
int	fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
#endif
{
	CFGF	*cfg;

	if( envname == (char *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( -1 );
	}

	for( cfg=cfgbank; ; cfg=cfg->next )
	{
		if( cfg == (CFGF *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_BADF;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_BADF );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}
		if( cfg->fd == fd )
			break;
	}

	for( ; ; cfg->scangrp=cfg->scangrp->next )
	{
		if( cfg->scangrp == (CFGG *)0 )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		if( groupname != (char *)0 && groupname[ 0 ] != (char)0 )
		{
			if( strcmp( groupname, cfg->scangrp->gname ) )
				continue;
		}

		if( cfg->scanitem == (CFGI *)0 )
			cfg->scanitem = cfg->scangrp->item;
		else
			cfg->scanitem = cfg->scanitem->next;
		for( ; ; cfg->scanitem = cfg->scanitem->next )
		{
			if( cfg->scanitem == (CFGI *)0 )
			{
				if( groupname != (char *)0 &&
				    groupname[ 0 ] != (char)0 )
				{
/*	98.09.16 for MultiThread by JJH ( Delete )
					hyerrno = EGP_CFG_NOMORE;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
					l_gpssethyerrno( EGP_CFG_NOMORE );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
					return( -1 );
				}
				break;
			}

			if( cfg->scanitem->name == (char *)0 )
				continue;

			strcpy( envname, cfg->scanitem->name );
			if( envvalue != (char *)0 )
			{
				if( cfg->scanitem->real == (char *)-1 )
					continue;
				else if( cfg->scanitem->real == (char *)0 )
					strcpy( envvalue,cfg->scanitem->value );
				else
					strcpy( envvalue, cfg->scanitem->real );
			}
			if( comment != (char *)0 )
			{
				if( cfg->scanitem->comment != (char *)0 )
					strcpy( comment,
						cfg->scanitem->comment );
				else
					comment[ 0 ] = (char)0;
			}

			return( 0 );

		} /* end of for scan item */

	} /* end of for scan group */

} /* cfg_nextenv */

/*===== internal modules ==============================================*/
/*----------------------------------------------------------------------+
|	make new group							|
+----------------------------------------------------------------------*/
static	CFGG	*
#if	defined( __CB_STDC__ )
l_NewGroupMakeFormFile( char *iobuf )
#else
l_NewGroupMakeFormFile( iobuf )
char	*iobuf;
#endif
{
	CFGG	*grp;
	char	*grpname;
	char	*comment;
	int	grplen;
	int	commlen;

	/* get group name and comment from line buffer */
	if( l_getgrpname( iobuf, &grpname, &grplen, &comment, &commlen ) < 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL_GRP;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL_GRP );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGG *)0 );
	}

	/* allocate for new group */
	if( ( grp = (CFGG *) l_alloc( sizeof( CFGG ) ) ) == (CFGG *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGG *)0 );
	}

	/* initialize new group */
	grp->gname = (char *)0;
	grp->comment = (char *)0;
	grp->MaxItemNameLen = 0;
	grp->MaxItemValLen = 0;
	grp->item = (CFGI *)0;
	grp->next = (CFGG *)0;

	/* allocate for group name */
	if( ( grp->gname = l_alloc( grplen + 1 ) ) == (char *)0 )
	{
		l_groupfree( grp );
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGG *)0 );
	}

	/* set group name */
	memcpy( grp->gname, grpname, grplen );
	grp->gname[ grplen ] = (char)0;

	/* if no comment, OK return */
	if( commlen <= 0 )
		return( grp );

	/* allocate for comment */
	if( ( grp->comment = (char *)l_alloc( commlen + 1 ) ) == (char *)0 )
	{
		l_groupfree( grp );
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGG *)0 );
	}

	/* set comment */
	memcpy( grp->comment, comment, commlen );
	grp->comment[ commlen ] = (char)0;

	return( grp );

} /* l_NewGroupMakeFormFile */

/*----------------------------------------------------------------------+
|	make new header comment						|
+----------------------------------------------------------------------*/
static	CFGC	*
#if	defined( __CB_STDC__ )
l_NewCommentMakeFormFile( char *iobuf )
#else
l_NewCommentMakeFormFile( iobuf )
char	*iobuf;
#endif
{
	CFGC	*com;
	char	*comment;
	int	commlen;

	/* get comment from line buffer */
	if( l_getitemname( iobuf, (char **)0, (int *)0, (char **)0, (int *)0,
						&comment, &commlen ) < 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGC *)0 );
	}

	/* allocate for new comment */
	if( ( com = (CFGC *) l_alloc( sizeof( CFGC ) ) ) == (CFGC *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGC *)0 );
	}

	/* initialize new comment */
	com->comment = (char *)0;
	com->next = (CFGC *)0;

	/* allocate for comment */
	if( ( com->comment = (char *)l_alloc( commlen + 1 ) ) == (char *)0 )
	{
		l_commfree( com );
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGC *)0 );
	}

	/* set comment */
	memcpy( com->comment, comment, commlen );
	com->comment[ commlen ] = (char)0;

	return( com );

} /* l_NewCommentMakeFormFile */

/*----------------------------------------------------------------------+
|	make new item							|
+----------------------------------------------------------------------*/
static	CFGI	*
#if	defined( __CB_STDC__ )
l_NewItemMakeFromFile( char *iobuf, CFGG *grp, CFGF *cfg )
#else
l_NewItemMakeFromFile( iobuf, grp, cfg )
char	*iobuf;
CFGG	*grp;
CFGF	*cfg;
#endif
{
	CFGI	*item;
	char	*name;
	char	*value;
	char	*comment;
	int	namelen;
	int	vallen;
	int	commlen;

	if( l_getitemname( iobuf, &name, &namelen, &value, &vallen,
						&comment, &commlen ) < 0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGI *)0 );
	}

	if( ( item = (CFGI *)l_alloc( sizeof( CFGI ) ) ) == (CFGI *)0 )
	{
/*	98.09.16 for MultiThread by JJH ( Delete )
		hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
		l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
		return( (CFGI *)0 );
	}

	item->name = (char *)0;
	item->value = (char *)0;
	item->real = (char *)0;
	item->comment = (char *)0;
	item->next = (CFGI *)0;

	if( namelen > 0 )
	{
		if( ( item->name = (char *)l_alloc( namelen+1 ) ) == (char *)0 )
		{
			l_itemfree( item );
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( (CFGI *)0 );
		}

		memcpy( item->name, name, namelen );
		item->name[ namelen ] = (char)0;
		if( namelen > grp->MaxItemNameLen )
			grp->MaxItemNameLen = namelen;

		if( ( item->value = (char *)l_alloc( vallen+1 ) ) == (char *)0 )
		{
			l_itemfree( item);
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( (CFGI *)0 );
		}
		memcpy( item->value, value, vallen );
		item->value[ vallen ] = (char)0;
		if( vallen > grp->MaxItemValLen )
			grp->MaxItemValLen = vallen;
		if( grp->MaxItemValLen > 39 )
			grp->MaxItemValLen = 39;

		if( l_getreal( &item->real, item->value, cfg ) < 0 )
		{
			l_itemfree( item );
			return( (CFGI *)0 );
		}
	}

	if( commlen > 0 )
	{
		item->comment = (char *)l_alloc( commlen + 1 );
		if( item->comment == (char *)0 )
		{
			l_itemfree( item);
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( (CFGI *)0 );
		}
		memcpy( item->comment, comment, commlen );
		item->comment[ commlen ] = (char)0;
	}

	return( item );

} /* l_NewItemMakeFromFile */

/*----------------------------------------------------------------------+
|	Get group name from line buffer					|
+----------------------------------------------------------------------*/
static	int
#if	defined( __CB_STDC__ )
l_getgrpname( char *linebuf, char **name, int *namelen, char **comment, int *commlen )
#else
l_getgrpname( linebuf, name, namelen, comment, commlen )
char	*linebuf;		/* " [ group_name ]   # group description" */
char	**name;			/* "group_name" */
int	*namelen;
char	**comment;
int	*commlen;
#endif
{
	char	*hptr;		/* head pointer */
	char	*tptr;		/* tail pointer */

	*namelen = 0;
	*commlen = 0;

	/*
	** group name
	*/

	/* search group header marker '[' */
	hptr = strchr( linebuf, '[' );
	if( hptr == (char *)0 )
		return( -1 );

	/* search header of group name */
	for( hptr++; (unsigned char)*hptr<=' '; hptr++ )
	{
		if( *hptr == (char)0 )
			return( -1 );
	}

	/* search next char of group name */
	for( tptr=hptr; (unsigned char)*tptr>' ' && *tptr!=']'; tptr++ ) ;

	*name = hptr;
	*namelen = tptr - hptr;

	/*
	** comment
	*/

	/* research group tail marker ']' */
	if( ( hptr = strchr( tptr, ']' ) ) == (char *)0 )
		return( -1 );

	/* search header of comment */
	if( ( hptr = strchr( ++hptr, '#' ) ) == (char *)0 )
		return( 0 );
	hptr++;

	*comment = hptr;
	*commlen = strlen( hptr ) - 1 /* newline */ ;

	return( 0 );

} /* l_getgrpname */

/*----------------------------------------------------------------------+
|	Get item name from line buffer					|
+----------------------------------------------------------------------*/
static	int
#if	defined( __CB_STDC__ )
l_getitemname( char *linebuf, char **name, int *namelen, char **value, int *valuelen, char **comment, int *commlen )
#else
l_getitemname( linebuf, name, namelen, value, valuelen, comment, commlen )
char	*linebuf;
char	**name;
int	*namelen;
char	**value;
int	*valuelen;
char	**comment;
int	*commlen;
#endif
{
	char	*hptr;
	char	*tptr;

	if( namelen != (int *)0 )	*namelen = 0;
	if( valuelen != (int *)0 )	*valuelen = 0;
	*commlen = 0;

	/*
	** comment
	*/

	/* search comment marker '#' */
	hptr = strchr( linebuf, '#' );
	if( hptr != (char *)0 )
	{
		/* search header of comment */
		hptr++;

		if( (int)strlen( hptr ) > 0 )
		{
			*comment = hptr;
			*commlen = strlen( hptr ) - 1 /* newline */ ;
		}
	}

	if( name == (char **)0 )
		return( 0 );				/* Only Comment */

	/*
	** name
	*/

	/* search header of name */
	for( hptr=linebuf; (unsigned char)*hptr<=' '; hptr++ )
		if( *hptr == (char)0 )
			return( 0 );			/* None any char */

	/* if comment, OK return */
	if( *hptr == '#' )
		return( 0 );				/* Only Comment */

	/* search char position (tptr) just after envname */
	for( tptr=hptr+1; (unsigned char)*tptr>' ' && *tptr!='='; tptr++ )
		if( *tptr == '#' )
			return( -1 );

	*name = hptr;
	*namelen = tptr - hptr;

	/*
	** value
	**/

	/* search delimiter '=' */
	for( hptr=tptr; *hptr!='='; hptr++ )
		if( (unsigned char)*hptr > ' ' || *hptr == (char)0 )
			return( -1 );

	/* search header of value */
	for( hptr++; (unsigned char)*hptr<=' '; hptr++ )
		if( *hptr == (char)0 )
			return( 0 );	/* none value */
	if( *hptr == '#' )
		return( 0 );		/* none value */

	/* search next char of value */
	for( tptr=hptr+1; *tptr!='#' && *tptr!=(char)0; tptr++ ) ;
	for( ; ((unsigned char)*tptr<=' '||*tptr=='#') && tptr>hptr; tptr-- ) ;

	*value = hptr;
	*valuelen = tptr + 1 - hptr;

	return( 0 );

} /* l_getitemname */

/*----------------------------------------------------------------------+
|	Get real envrion value						|
+----------------------------------------------------------------------*/
static	int
#if	defined( __CB_STDC__ )
l_getreal( char **real, char *value, CFGF *cfgfd )
#else
l_getreal( real, value, cfgfd )
char	**real;
char	*value;
CFGF	*cfgfd;
#endif
{
	char		*hptr;
	char		*tptr;
	char		envname[ 128 ];
	char		*envvalue;
	int		plus;
	char		realbuf[ 512 ];
	int		realpos = 0;

	for( realbuf[ 0 ]=(char)0; ; value=tptr+plus )
	{
		/* value = value remained after last $() process */
		if( ( hptr = strchr( value, '$' ) ) == (char *)0 )
		{
			if( realpos == 0 )
			{				/* real = value */
				*real = (char *)0;
			}
			else
			{
				char	*new;

				strcpy( &realbuf[ realpos ], value );
				new = l_alloc( strlen( realbuf ) + 1 );
				if( new == (char *)0 )
				{
/*	98.09.16 for MultiThread by JJH ( Delete )
					hyerrno = EGP_CFG_NOMEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
					l_gpssethyerrno( EGP_CFG_NOMEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
					return( -1 );
				}
				strcpy( new, realbuf );
				*real = new;
			}

			return( 0 );

		} /* end of if no more environment */

		/* if next $ appears after some char from current position */
		/* then, copy normal string to real first */
		if( hptr != value )
		{
			memcpy( &realbuf[ realpos ], value, hptr-value);
			realpos += hptr - value;
			realbuf[ realpos ] = (char)0;

		} /* enf of if exist data before environment */

		hptr++;
		plus = 0;
		switch( *hptr )
		{
		case	'('	:
			if( ( tptr = strchr( hptr, ')' ) ) == (char *)0 )
			{
/*	98.09.16 for MultiThread by JJH ( Delete )
				hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
				l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
				return( -1 );
			}
			plus = 1;
			break;
		case	'{'	:
			if( ( tptr = strchr( hptr, '}' ) ) == (char *)0 )
			{
/*	98.09.16 for MultiThread by JJH ( Delete )
				hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
				l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
				return( -1 );
			}
			plus = 1;
			break;
		default		:
			for( tptr=hptr; isalnum(*tptr) || *tptr=='_'; tptr++ ) ;
			break;
		}

		if( tptr - plus == hptr )
		{
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = EGP_CFG_INVAL_ITEM;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( EGP_CFG_INVAL_ITEM );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
		}

		memcpy( envname, hptr + plus, tptr - hptr - plus );
		envname[ tptr - hptr - plus ] = (char)0;

		/* get envvalue from CFG-table loaded */
		if( l_getenvvalue( &envvalue, envname, cfgfd ) < 0 )
		{
			envvalue = getenv( envname );
			if( envvalue == (char *)0 )
			{
				*real = (char *)-1;
				return( 0 );
			}
		}

		memcpy( &realbuf[ realpos ], envvalue, strlen( envvalue ) );
		realpos += strlen( envvalue );
		realbuf[ realpos ] = (char)0;

	} /* end of for */

} /* l_getreal */

/*----------------------------------------------------------------------+
|	Get envrion value for envrion name in CFG-table			|
+----------------------------------------------------------------------*/
static	int
#if	defined( __CB_STDC__ )
l_getenvvalue( char **envvalue, char *envname, CFGF *cfgfd )
#else
l_getenvvalue( envvalue, envname, cfgfd )
char	**envvalue;
char	*envname;
CFGF	*cfgfd;
#endif
{
	CFGG	*grp;
	CFGI	*item;

	for( grp=cfgfd->group; grp!=(CFGG *)0; grp=grp->next )
	{
		for( item=grp->item; item!=(CFGI *)0; item=item->next )
		{
			if( item->name == (char *)0 )
				continue;
			if( !strcmp( envname, item->name ) )
			{
				if( item->real == (char *)-1 )
					continue;
				else if( item->real == (char *)0 )
					*envvalue = item->value;
				else
					*envvalue = item->real;
				return( 0 );
			}
		}
	}

	return( -1 );

} /* l_getenvvalue */

static	char	*
#if	defined( __CB_STDC__ )
l_gets( char *line, int len, char *buff, int *offset )
#else
l_gets( line, len, buff, offset )
char	*line;
int	len;
char	*buff;
int	*offset;
#endif
{
	register	i, j;
	char		*ptr;

	ptr = &buff[ *offset ];
	if( ptr[0] == (char)0 )
		return( (char *)0 );

	len--;
	for( i=0,j=0; i<len; j++ )
	{
		if( ptr[ j ] == '\r' )
			continue;

		line[ i++ ] = ptr[ j ];

		if( ptr[ j ] == (char)0 )
			break;

		if( ptr[ j ] == '\n' )
		{
			line[ i ] = (char)0;
			j++;
			break;
		}
	}

	if( i == len )
		line[ i ] = (char)0;

	*offset += j;

	return( ptr );

} /* l_gets */

/*----------------------------------------------------------------------+
|	free cfg-table for a configuration file				|
+----------------------------------------------------------------------*/
static	void
#if	defined( __CB_STDC__ )
l_fdfree( CFGF *cfg )
#else
l_fdfree( cfg )
CFGF	*cfg;
#endif
{
	if( cfg == (CFGF *)0 )
		return;

	l_groupfree( cfg->group );

	l_commfree( cfg->comment );

	if( cfg->fname != (char *)0 )
		l_free( cfg->fname );
	if( cfg->FD != (FILE *)0 )
		fclose( cfg->FD );
	l_free( cfg );

	if( cfgbank == (CFGF *)0 )
		l_alloc( 0 );			/* free trunk memory */

	return;

} /* l_fdfree */

/*----------------------------------------------------------------------+
|	free comment-tables						|
+----------------------------------------------------------------------*/
static	void
#if	defined( __CB_STDC__ )
l_commfree( CFGC *cfgcomm )
#else
l_commfree( cfgcomm )
CFGC	*cfgcomm;
#endif
{
	if( cfgcomm == (CFGC *)0 )
		return;

	l_commfree( cfgcomm->next );

	if( cfgcomm->comment != (char *)0 )
		l_free( cfgcomm->comment );
	l_free( cfgcomm );

	return;

} /* l_commfree */

/*----------------------------------------------------------------------+
|	free group-tables						|
+----------------------------------------------------------------------*/
static	void
#if	defined( __CB_STDC__ )
l_groupfree( CFGG *cfggrp )
#else
l_groupfree( cfggrp )
CFGG	*cfggrp;
#endif
{
	if( cfggrp == (CFGG *)0 )
		return;

	l_groupfree( cfggrp->next );

	l_itemfree( cfggrp->item );

	if( cfggrp->gname != (char *)0 )
		l_free( cfggrp->gname );
	if( cfggrp->comment != (char *)0 )
		l_free( cfggrp->comment );
	l_free( cfggrp );

	return;

} /* l_groupfree */

/*----------------------------------------------------------------------+
|	free item-tables						|
+----------------------------------------------------------------------*/
static	void
#if	defined( __CB_STDC__ )
l_itemfree( CFGI *cfgitem )
#else
l_itemfree( cfgitem )
CFGI	*cfgitem;
#endif
{
	if( cfgitem == (CFGI *)0 )
		return;

	l_itemfree( cfgitem->next );

	if( cfgitem->name != (char *)0 )
		l_free( cfgitem->name );
	if( cfgitem->value != (char *)0 )
		l_free( cfgitem->value );
	if( cfgitem->real != (char *)0 && cfgitem->real != (char *)-1 )
		l_free( cfgitem->real );
	if( cfgitem->comment != (char *)0 )
		l_free( cfgitem->comment );
	l_free( cfgitem );

	return;

} /* l_itemfree */

/*----------------------------------------------------------------------+
|	allocate memory instead of malloc()				|
+----------------------------------------------------------------------*/
void	*
#if	defined( __CB_STDC__ )
l_alloc( int len )
#else
l_alloc( len )
int	len;
#endif
{
static	char	*membuf = (char *)0;
static	int	align = 0;
static	int	ptr = 0;
static	int	memsize = 0;
	int	sptr;

	if( membuf == (char *)0 )
	{
		if( ( membuf = (char *)malloc( 64 * 1024 ) ) == (char *)0 )
			return( (void *)0 );
		if( (int)membuf % 16 != 0 )
			align = 16 - (int)membuf % 16;
		memsize = 64 * 1024;
	}

	if( len == 0 )
	{
		free( membuf );
		membuf = (char *)0;
		align = 0;
		ptr = 0;
		memsize = 0;
		return( (void *)0 );
	}

	if( ptr + align + len >= memsize )
	{
		char	*tmpptr;

		tmpptr = membuf;
		if( ( membuf = realloc( membuf, memsize * 2 ) ) == (char *)0 )
		{
			membuf = tmpptr;
			return( (void *)0 );
		}

		memsize *= 2;
	}

	sptr = ptr + align;
	ptr += ( ( len - 1 ) / 16 + 1 ) * 16;

	return( (void *)( membuf + sptr ) );

} /* l_alloc */

/*----------------------------------------------------------------------+
|	free memory instead of free()					|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
l_free( void *ptr )
#else
l_free( ptr )
void	*ptr;
#endif
{
	return;
}

/*===== Source for COBOL ==============================================*/
void CBD1
#if	defined( __CB_STDC__ )
OCFG_OPEN( char *cfgfpath, char *mode, int *cfgFD, char *retcode )
#else
OCFG_OPEN( cfgfpath, mode, cfgFD, retcode )
char	*cfgfpath;
char	*mode;
int	*cfgFD;
char	*retcode;
#endif
{
	char	l_cfgfpath[132];
	char	l_mode[4];

	d_mkstr( cfgfpath, 128, l_cfgfpath );
	d_mkstr( mode, 2, l_mode );

	if( ( *cfgFD = cfg_open( l_cfgfpath, l_mode ) ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_CLOSE( int *fd, char *retcode )
#else
OCFG_CLOSE( fd, retcode )
int	*fd;
char	*retcode;
#endif
{
	if( cfg_close( *fd ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_FLUSH( int *fd, char *retcode )
#else
OCFG_FLUSH( fd, retcode )
int	*fd;
char	*retcode;
#endif
{
	if( cfg_flush( *fd ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_SETENV( char *cfgfpath, char *group, char *retcode )
#else
OCFG_SETENV( cfgfpath, group, retcode )
char	*cfgfpath;
char	*group;
char	*retcode;
#endif
{
	char	l_cfgfpath[132];
	char	l_group[32];

	d_mkstr( cfgfpath, 128, l_cfgfpath );
	d_mkstr( group, 30, l_group );

	if( cfg_setenv( l_cfgfpath, l_group ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_GETENV( char *cfgfpath, char *group, char *envname, char *envvalue, char *retcode )
#else
OCFG_GETENV( cfgfpath, group, envname, envvalue, retcode )
char	*cfgfpath;
char	*group;
char	*envname;
char	*envvalue;
char	*retcode;
#endif
{
	char	l_cfgfpath[132];
	char	l_group[32];
	char	l_envname[32];

	d_mkstr( cfgfpath, 128, l_cfgfpath );
	d_mkstr( group, 30, l_group );
	d_mkstr( envname, 30, l_envname );

	if( cfg_getenv( l_cfgfpath, l_group, l_envname, envvalue ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_READGRP( int *fd, char *groupname, char *envbuf, int *cr_cnt, char *retcode )
#else
OCFG_READGRP( fd, groupname, envbuf, cr_cnt, retcode )
int	*fd;
char	*groupname;
char	*envbuf;
int	*cr_cnt;
char	*retcode;
#endif
{
	char	l_groupname[32];

	d_mkstr( groupname, 30, l_groupname );

	if( cfg_readgrp( *fd, l_groupname, envbuf, *cr_cnt ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_DELGRP( int *fd, char *groupname, char *retcode )
#else
OCFG_DELGRP( fd, groupname, retcode )
int	*fd;
char	*groupname;
char	*retcode;
#endif
{
	char	l_groupname[32];

	d_mkstr( groupname, 32, l_groupname );

	if( cfg_delgrp( *fd, l_groupname ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_WRTGRP( int *fd, char *groupname, char *envbuf, char *retcode )
#else
OCFG_WRTGRP( fd, groupname, envbuf, retcode )
int	*fd;
char	*groupname;
char	*envbuf;
char	*retcode;
#endif
{
	char	l_groupname[32];

	d_mkstr( groupname, 30, l_groupname );

	if( cfg_wrtgrp( *fd, l_groupname, envbuf ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_READENV( int *fd, char *groupname, char *envname, char *envvalue, char *comment, char *retcode )
#else
OCFG_READENV( fd, groupname, envname, envvalue, comment, retcode )
int	*fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
char	*retcode;
#endif
{
	char	l_groupname[32];
	char	l_envname[32];

	d_mkstr( groupname, 30, l_groupname );
	d_mkstr( envname, 30, l_envname );

	if( cfg_readenv( *fd, l_groupname, l_envname, envvalue, comment ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_DELENV( int *fd, char *groupname, char *envname, char *retcode )
#else
OCFG_DELENV( fd, groupname, envname, retcode )
int	*fd;
char	*groupname;
char	*envname;
char	*retcode;
#endif
{
	char	l_groupname[32];
	char	l_envname[32];

	d_mkstr( groupname, 30, l_groupname );
	d_mkstr( envname, 30, l_envname );

	if( cfg_delenv( *fd, l_groupname, l_envname ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_WRTENV( int *fd, char *groupname, char *envname, char *envvalue, char *comment, char *retcode )
#else
OCFG_WRTENV( fd, groupname, envname, envvalue, comment, retcode )
int	*fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
char	*retcode;
#endif
{
	char	l_groupname[32];
	char	l_envname[32];
	char	l_envvalue[128];

	d_mkstr( groupname, 30, l_groupname );
	d_mkstr( envname, 30, l_envname );
	d_mkstr( envvalue, 128, l_envvalue );

	if( cfg_wrtenv( *fd, l_groupname, l_envname, l_envvalue,
							comment ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_SCANGRP( int *fd, char *groupname, char *retcode )
#else
OCFG_SCANGRP( fd, groupname, retcode )
int	*fd;
char	*groupname;
char	*retcode;
#endif
{
	if( cfg_scangrp( *fd, groupname ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_NEXTGRP( int *fd, char *groupname, char *retcode )
#else
OCFG_NEXTGRP( fd, groupname, retcode )
int	*fd;
char	*groupname;
char	*retcode;
#endif
{
	if( cfg_nextgrp( *fd, groupname ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_SCANENV( int *fd, char *groupname, char *envname, char *envvalue, char *comment, char *retcode )
#else
OCFG_SCANENV( fd, groupname, envname, envvalue, comment, retcode )
int	*fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
char	*retcode;
#endif
{
	char	l_groupname[32];

	d_mkstr( groupname, 30, l_groupname );

	if( cfg_scanenv( *fd, l_groupname, envname, envvalue, comment ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

void CBD1
#if	defined( __CB_STDC__ )
OCFG_NEXTENV( int *fd, char *groupname, char *envname, char *envvalue, char *comment, char *retcode )
#else
OCFG_NEXTENV( fd, groupname, envname, envvalue, comment, retcode )
int	*fd;
char	*groupname;
char	*envname;
char	*envvalue;
char	*comment;
char	*retcode;
#endif
{
	char	l_groupname[32];

	d_mkstr( groupname, 30, l_groupname );

	if( cfg_nextenv( *fd, l_groupname, envname, envvalue, comment ) < 0 )
		retcode[0] = 'E';
	else
		retcode[0] = ' ';
}

/*===== Sample Source =================================================*/
#ifdef	SAMPLE_SOURCE

#ifdef	INDEPENDENT_SOURCE

#include	<stdio.h>
#include	<stdlib.h>
#include	"gps.h"

#endif	/* INDEPENDENT_SOURCE */

#define		PRENV	if( 0 ) prenv

extern	int	hyerrno;
extern	char	**environ;

void	prenv CBD2(( void ));

int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[], char *envp[] )
#else
main( argc, argv, envp )
int	argc;
char	*argv[];
char	*envp[];
#endif
{
	int	ret;
	char	envval		[  128 ];
	char	grpname		[   32 ];
	char	envname		[   64 ];
	char	envvalue	[  512 ];
	char	comment		[  512 ];
	char	envbuf		[ 4096 ];
	char	cfgfile		[  128 ];
	char	cfgoption	[    4 ];
	int	fd;

	setbuf( stdout, (char *)0 );

	strcpy( cfgfile, "start.cfg" );
	ret = cfg_setenv( "start.cfg", NULL );
	printf( "setenv %s ==> ret=%d hyerrno=%d\n", cfgfile, ret, hyerrno );
	PRENV();

	strcpy( cfgfile, "asid.cfg" );
	ret = cfg_setenv( "asid.cfg", NULL );
	printf( "setenv %s ==> ret=%d hyerrno=%d\n", cfgfile, ret, hyerrno );
	PRENV();

	strcpy( cfgfile, "asid.cfg" );
	strcpy( grpname, "RMTHOSTS" );
	strcpy( envname, "Z" );
	ret = cfg_getenv( cfgfile, grpname, envname, envval );
	printf( "getenv %s %s %s ==> ret=%d, hyerrno=%d envval=%s\n",
		cfgfile, grpname, envname, ret, hyerrno, ret<0?"":envval );

	strcpy( cfgfile, "start.cfg" );
	strcpy( cfgoption, "r" );
	if( ( fd = cfg_open( cfgfile, cfgoption ) ) < 0 )
	{
		printf( "open %s %s ==> error=%d\n",
						cfgfile, cfgoption, hyerrno );
	}
	else
	{
		printf( "open %s %s\n", cfgfile, cfgoption );
		if( cfg_scangrp( fd, grpname ) < 0 )
			printf( "scangrp ==> error=%d\n", hyerrno );
		else
		{
			printf( "scangrp ==> grpname=%s\n", grpname );
#ifdef	SCANGRP_SCANENV
			do {
				if( cfg_scanenv( fd, grpname, envname,
						envvalue, comment ) < 0 )
				{
					printf( "scanenv %s ==> error=%d\n",
							grpname, hyerrno );
				}
				else
				{
					printf( "scanenv grpname=%s ==> ",
								grpname );
					printf( "envname=(%s=%s#%s)\n",
						envname, envvalue, comment );
					while( cfg_nextenv( fd, grpname,envname,
						envvalue, comment ) >= 0 )
					{
						printf( "nextenv  grpname=(%s)",
							grpname );
						printf( " ==> envname=" );
						printf( "(%s=%s#%s)\n",
							envname, envvalue,
							comment );
					}
					printf( "nextenv %s ==> error=%d\n",
							grpname, hyerrno );
				}
			}
#endif	/* SCANGRP_SCANENV */
			while( cfg_nextgrp( fd, grpname ) >= 0 &&
				printf( "nextgrp ==> grpname=%s\n",
								grpname ) > 0 );
			printf( "nextgrp ==> error=%d\n", hyerrno );
		}

		if( cfg_close( fd ) < 0 )
			printf( "close %s ==> error=%d\n", cfgfile, hyerrno );
		else
			printf( "close %s\n", cfgfile );
	}

	strcpy( cfgfile, "asid.cfg" );
	strcpy( cfgoption, "r" );
	grpname[0] = (char)0;
	if( ( fd = cfg_open( cfgfile, cfgoption ) ) < 0 )
	{
		printf( "open %s %s ==> error=%d\n",
						cfgfile, cfgoption, hyerrno );
	}
	else
	{
		printf( "open %s\n", cfgfile );
		if( cfg_scanenv( fd, grpname, envname, envvalue, comment ) < 0 )
			printf( "scanenv ==> error=%d\n", hyerrno );
		else
		{
			printf( "scanenv ==> envname=(%s=%s#%s)\n",
						envname, envvalue, comment );
			while( cfg_nextenv( fd, grpname, envname,
						envvalue, comment ) >= 0 )
			{
				printf( "nextenv ==> envname=(%s=%s#%s)\n",
						envname, envvalue, comment );
			}
			printf( "nextenv ==> error=%d\n", hyerrno );
		}
		if( cfg_close( fd ) < 0 )
			printf( "close %s ==> error=%d\n", cfgfile, hyerrno );
		else
			printf( "close %s\n", cfgfile );
	}

	strcpy( cfgfile, "asid.cfg" );
	strcpy( cfgoption, "r+" );
	if( ( fd = cfg_open( cfgfile, cfgoption ) ) < 0 )
	{
		printf( "open %s %s ==> error=%d\n",
						cfgfile, cfgoption, hyerrno );
	}
	else
	{
		printf( "open %s\n", cfgfile );

		strcpy( grpname, "" );
		strcpy( envname, "COMMTIMEOUTSEC" );
		if( cfg_readenv( fd, grpname, envname, envvalue, comment ) < 0 )
			printf( "readenv %s ==> error=%d\n", envname, hyerrno );
		else
		{
			printf( "readenv %s ==> envvalue=(%s#%s)\n",
						envname, envvalue, comment );
		}

		strcpy( grpname, "COMMINF" );
		strcpy( envname, "COMMTIMEOUTSEC" );
		if( cfg_readenv( fd, grpname, envname, envvalue, comment ) < 0 )
		{
			printf( "readenv %s %s ==> error=%d\n",
						grpname, envname, hyerrno );
		}
		else
		{
			printf( "readenv %s %s ==> envvalue=(%s#%s)\n",
					grpname, envname, envvalue, comment );
		}

		strcpy( grpname, "COMMINF" );
		strcpy( envname, "COMMTIMEOUTSEC" );
		if( cfg_delenv( fd, grpname, envname ) < 0 )
		{
			printf( "delenv %s %s ==> error=%d\n",
						grpname, envname, hyerrno );
		}
		else
		{
			printf( "delenv %s %s ==> success\n",
							grpname, envname );
		}

		strcpy( grpname, "COMMINF" );
		strcpy( envname, "COMMTIMEOUTSEC" );
		if( cfg_wrtenv( fd, grpname, envname, envvalue, comment ) < 0 )
		{
			printf( "wrtenv %s %s %s %s ==> error=%d\n",
				grpname, envname, envvalue, comment, hyerrno );
		}
		else
		{
			printf( "wrtenv %s %s %s %s ==> success\n",
					grpname, envname, envvalue, comment );
		}

		if( cfg_close( fd ) < 0 )
			printf( "close %s ==> error=%d\n", cfgfile, hyerrno );
		else
			printf( "close %s\n", cfgfile );
	}

	strcpy( cfgfile, "asid.cfg" );
	strcpy( cfgoption, "r+" );
	if( ( fd = cfg_open( cfgfile, cfgoption ) ) < 0 )
	{
		printf( "open %s %s ==> error=%d\n",
						cfgfile, cfgoption, hyerrno );
	}
	else
	{
		printf( "open %s\n", cfgfile );

		strcpy( grpname, "COMMINF" );
		if( cfg_readgrp( fd, grpname, envbuf, 0 ) < 0 )
			printf( "readenv %s ==> error=%d\n", grpname, hyerrno );
		else
		{
			printf( "readenv %s ==> envbuf=(\n%s)\n",
							grpname, envbuf );
		}

		strcpy( grpname, "COMMINF" );
		if( cfg_delgrp( fd, grpname ) < 0 )
			printf( "delgrp %s ==> error=%d\n", grpname, hyerrno );
		else
			printf( "delgrp %s ==> success\n", grpname );

		strcpy( grpname, "COMMINF" );
		if( cfg_wrtgrp( fd, grpname, envbuf ) < 0 )
		{
			printf( "wrtgrp %s\n%s\n ==> error=%d\n",
						grpname, envbuf, hyerrno );
		}
		else
		{
			printf( "wrtgrp %s\n%s\n ==> success\n",
							grpname, envbuf );
		}

		if( cfg_close( fd ) < 0 )
			printf( "close %s ==> error=%d\n", cfgfile, hyerrno );
		else
			printf( "close %s\n", cfgfile );
	}

	return( 0 );
}

void
#if	defined( __CB_STDC__ )
prenv( void )
#else
prenv()
#endif
{
	char	**envp;

	for( envp=environ; *envp; envp++ )
		printf( "%s\n", *envp );

	return;
}
#endif	/* SAMPLE_SOURCE */

/******* The end of cfgfun.c *******************************************/
