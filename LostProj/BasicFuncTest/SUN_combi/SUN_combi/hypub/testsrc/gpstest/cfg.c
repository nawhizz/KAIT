/************************************************************************
*	GPS library testing program ( configuration file )				*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>

#include	"cbuni.h"

#include	"gps.h"

/*----------------------------------------------------------------------+
|	External variables						|
+----------------------------------------------------------------------*/
int	cfgfd = -1;

/*---------------------------------------------------------------------*/
void
CFG_OPEN()
{
	char	cfgpath[256];
	char	mode[80];

	if( cfgfd >= 0 )
	{
		cfg_close( cfgfd );
		cfgfd = -1;
		printf( " Result cfg closed\n" );
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_open( char *cfgpath(i), char *mode(i) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cfgpath             : " );
	scanf( "%s", cfgpath );
	printf( " mode ( 'r' or 'r+' or 'w' ) : " );
	scanf( "%s", mode );

	if( ( cfgfd = cfg_open( cfgpath, mode ) ) < 0 )
	{
		printf( "cfg_open error .....\n" );
		return;
	}
	printf( " Result cfgfd        : [%d]\n", cfgfd );

} /* CFG_OPEN */
/*---------------------------------------------------------------------*/
void
CFG_CLOSE()
{
	if( cfgfd >= 0 )
	{
		cfg_close( cfgfd );
		cfgfd = -1;
		printf( " Result cfg closed\n" );
	}

} /* CFG_CLOSE */

/*---------------------------------------------------------------------*/
void
CFG_FLUSH()
{
	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	if( cfg_flush( cfgfd )  < 0 )
	{
		printf( "cfg_flush error .....\n" );
		return;
	}

	printf( "cfg flushed\n" );

} /* CFG_FLUSH */

/*---------------------------------------------------------------------*/
void
CFG_SETENV()
{
	char	cfgpath[256];
	char	group[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_setenv( char *cfgpath(i), char *group(i) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cfgpath : " );
	scanf( "%s", cfgpath );
	printf( " group   : " );
	scanf( "%s", group );

	if( cfg_setenv( cfgpath, group ) < 0 )
	{
		printf( "cfg_open error .....\n" );
		return;
	}
	printf( " Result success\n" );

} /* CFG_SETENV */

/*---------------------------------------------------------------------*/
void
CFG_GETENV()
{
	char	cfgpath[256];
	char	group[80];
	char	envname[80];
	char	envvalue[512];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_getenv( char *cfgpath(i), char *group(i),   |\n" );
	printf( "|                char *envname(i), char *envvalue(o) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cfgpath         : " );
	scanf( "%s", cfgpath );
	printf( " group           : " );
	scanf( "%s", group );
	printf( " envname         : " );
	scanf( "%s", envname );

	if( cfg_getenv( cfgpath, group, envname, envvalue ) < 0 )
	{
		printf( "cfg_getenv error .....\n" );
		return;
	}
	printf( " Result envvalue : [%s]\n", envvalue );

} /* CFG_GETENV */

/*---------------------------------------------------------------------*/
void
CFG_READGRP()
{
	char	tmpstr[80];
	char	group[80];
	char	envbuf[4096];
	int	cr_cnt;

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_readgrp( int cfgfd(i), char *group(i),      |\n" );
	printf( "|                char *envbuf(o), int cr_cnt(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group         : " );
	scanf( "%s", group );
	printf( " cr_cnt        : " );
	scanf( "%s", tmpstr );
	if( ( cr_cnt = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid cr_cnt ......\n" );
		return;
	}

	if( cfg_readgrp( cfgfd, group, envbuf, cr_cnt ) < 0 )
	{
		printf( "cfg_getenv error .....\n" );
		return;
	}

	printf( " Result envbuf : [%s]\n", envbuf );

} /* CFG_READGRP */
/*---------------------------------------------------------------------*/
void
CFG_DELGRP()
{
	char	group[80];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_delgrp( int cfgfd(i), char *group(i) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group : " );
	scanf( "%s", group );

	if( cfg_delgrp( cfgfd, group ) < 0 )
	{
		printf( "cfg_delgrp error .....\n" );
		return;
	}
	
	printf( " Result success\n" );

} /* CFG_DELGRP */

/*---------------------------------------------------------------------*/
void
CFG_WRTGRP()
{
	char	group[80];
	char	envbuf[4096];
	char	tmpstr[512];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_wrtgrp( int cfgfd(i), char *group(i),       |\n" );
	printf( "|                char *envbuf(i) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group                        : " );
	scanf( "%s", group );
	printf( " envbuf ( envlist or 'exit' ) : " );
	gets( envbuf );
	envbuf[0] = 0;
	for( ; ; )
	{
		gets( tmpstr );
		if( !strcmp( tmpstr, "exit" ) )
			break;
		strcat( envbuf, tmpstr );
		strcat( envbuf, "\n" );
	}

	if( cfg_wrtgrp( cfgfd, group, envbuf ) < 0 )
	{
		printf( "cfg_wrtgrp error .....\n" );
		return;
	}

	printf( " Result success\n" );

} /* CFG_WRTGRP */

/*---------------------------------------------------------------------*/
void
CFG_READENV()
{
	char	group[80];
	char	envname[80];
	char	envvalue[512];
	char	comment[256];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_readenv( int cfgfd(i), char *group(i),      |\n" );
	printf( "|                char *envname(i), char *envvalue(o),   |\n" );
	printf( "|                char *comment(o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group           : " );
	gets( group );
	gets( group );
	printf( " envname         : " );
	scanf( "%s", envname );

	if( cfg_readenv( cfgfd, group, envname, envvalue, comment ) < 0 )
	{
		printf( "cfg_readenv error .....\n" );
		return;
	}

	printf( " Result envvalue : [%s]\n", envvalue );
	printf( " Result comment  : [%s]\n", comment );

} /* CFG_READENV */

/*---------------------------------------------------------------------*/
void
CFG_DELENV()
{
	char	group[80];
	char	envname[80];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_delenv( int cfgfd(i), char *group(i),       |\n" );
	printf( "|                char *envname(i) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group   : " );
	scanf( "%s", group );
	printf( " envname : " );
	scanf( "%s", envname );

	if( cfg_delenv( cfgfd, group, envname ) < 0 )
	{
		printf( "cfg_delenv error .....\n" );
		return;
	}

	printf( " Result success\n" );

} /* CFG_DELENV */

/*---------------------------------------------------------------------*/
void
CFG_WRTENV()
{
	char	group[80];
	char	envname[80];
	char	envvalue[512];
	char	comment[256];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_wrtenv( int cfgfd(i), char *group(i),       |\n" );
	printf( "|                char *envname(i), char *envvalue(i),   |\n" );
	printf( "|                char *comment(i) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group    : " );
	scanf( "%s", group );
	printf( " envname  : " );
	scanf( "%s", envname );
	printf( " envvalue : " );
	gets( envvalue );
	gets( envvalue );
	printf( " comment  : " );
	gets( comment );

	if( cfg_wrtenv( cfgfd, group, envname, envvalue, comment ) < 0 )
	{
		printf( "cfg_wrtenv error .....\n" );
		return;
	}

	printf( " Result success\n" );

} /* CFG_WRTENV */

/*---------------------------------------------------------------------*/
void
CFG_SCANGRP()
{
	char	group[80];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_scangrp( int cfgfd(i), char *group(o) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( cfg_scangrp( cfgfd, group ) < 0 )
	{
		printf( "cfg_scangrp error .....\n" );
		return;
	}

	printf( " Result group : [%s]\n", group );

} /* CFG_SCANGRP */

/*---------------------------------------------------------------------*/
void
CFG_NEXTGRP()
{
	char	group[80];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_nextgrp( int cfgfd(i), char *group(o) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( cfg_nextgrp( cfgfd, group ) < 0 )
	{
		printf( "cfg_nextgrp error .....\n" );
		return;
	}

	printf( " Result group : [%s]\n", group );

} /* CFG_NEXTGRP */

/*---------------------------------------------------------------------*/
void
CFG_SCANENV()
{
	char	group[80];
	char	envname[80];
	char	envvalue[512];
	char	comment[256];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_scanenv( int cfgfd(i), char *group(i),      |\n" );
	printf( "|                char *envname(o), char *envvalue(o),   |\n" );
	printf( "|                char *comment(o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group           : " );
	gets( group );
	gets( group );

	if( cfg_scanenv( cfgfd, group, envname, envvalue, comment ) < 0 )
	{
		printf( "cfg_scanenv error .....\n" );
		return;
	}

	printf( " Result envname  : [%s]\n", envname );
	printf( " Result envvalue : [%s]\n", envvalue );
	printf( " Result comment  : [%s]\n", comment );

} /* CFG_SCANENV */

/*---------------------------------------------------------------------*/
void
CFG_NEXTENV()
{
	char	group[80];
	char	envname[80];
	char	envvalue[512];
	char	comment[256];

	if( cfgfd < 0 )
	{
		printf( "cfg not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       cfg_nextenv( int cfgfd(i), char *group(i),      |\n" );
	printf( "|                char *envname(o), char *envvalue(o),   |\n" );
	printf( "|                char *comment(o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " group           : " );
	gets( group );
	gets( group );

	if( cfg_nextenv( cfgfd, group, envname, envvalue, comment ) < 0 )
	{
		printf( "cfg_nextenv error .....\n" );
		return;
	}

	printf( " Result envname  : [%s]\n", envname );
	printf( " Result envvalue : [%s]\n", envvalue );
	printf( " Result comment  : [%s]\n", comment );

} /* CFG_NEXTENV */

/*----------------------------------------------------------------------+
|	Display function for configuration file				|
+----------------------------------------------------------------------*/
void
DisplayCFGF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( configuration file ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( "  1. cfg_open     2. cfg_close    3. cfg_flush\n" );
	printf( "  4. cfg_setenv   5. cfg_getenv   6. cfg_readgrp\n" );
	printf( "  7. cfg_delgrp   8. cfg_wrtgrp   9. cfg_readenv\n" );
	printf( " 10. cfg_delenv  11. cfg_wrtenv  12. cfg_scangrp\n" );
	printf( " 13. cfg_nextgrp 14. cfg_scanenv 15. cfg_nextenv\n" );
	printf( " 99. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayCFGF */

/*----------------------------------------------------------------------+
|	Choose function for configuration file				|
+----------------------------------------------------------------------*/
int
ChooseCFGF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 99 && ( choosenum < 1 || choosenum > 15 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseCFGF */

/*----------------------------------------------------------------------+
|	Main function for configuration file				|
+----------------------------------------------------------------------*/
void
CFGF()
{
	for( ; ; )
	{
		DisplayCFGF();
		switch( ChooseCFGF() )
		{
		case	 1	:	CFG_OPEN();	break;
		case	 2	:	CFG_CLOSE();	break;
		case	 3	:	CFG_FLUSH();	break;
		case	 4	:	CFG_SETENV();	break;
		case	 5	:	CFG_GETENV();	break;
		case	 6	:	CFG_READGRP();	break;
		case	 7	:	CFG_DELGRP();	break;
		case	 8	:	CFG_WRTGRP();	break;
		case	 9	:	CFG_READENV();	break;
		case	10	:	CFG_DELENV();	break;
		case	11	:	CFG_WRTENV();	break;
		case	12	:	CFG_SCANGRP();	break;
		case	13	:	CFG_NEXTGRP();	break;
		case	14	:	CFG_SCANENV();	break;
		case	15	:	CFG_NEXTENV();	break;
		default		:	CFG_CLOSE();	return;
		}
	}

} /* CFGF */

/****** End of cfg.c ***************************************************/
