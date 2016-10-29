/************************************************************************
*	GPS library testing program ( process interface )		*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>
#include	<sys/types.h>

#include	"cbuni.h"

#include	"gps.h"

/*---------------------------------------------------------------------*/
void
R_EXECPRG()
{
	char	pname[128];
	short	retval;
#ifndef	WIN32
	pid_t	cpid;
	int	exit_status;
#endif

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_execprg( char *pname(i), short *retval(o) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " pname : " );
	gets( pname );
	gets( pname );

#ifndef	WIN32
	if( ( cpid = fork() ) < 0 )
	{
		printf( "fork error ......\n" );
		return;
	}
	else if( cpid != 0 )
	{
		waitpid( cpid, &exit_status, 0 );
		printf( " Result ?\n" );
	}
	else
	{
#endif
		r_execprg( pname, &retval );

		printf( "r_execprg error .....\n" );
		exit( 1 );

#ifndef	WIN32
	}
#endif

} /* R_EXECPRG */

/*---------------------------------------------------------------------*/
void
R_RUNCONT()
{
	char	pname[128];
	short	retval;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_runcont( char *pname(i), short *retval(o) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " pname        : " );
	gets( pname );
	gets( pname );

	r_runcont( pname, &retval );

	printf( "Result retval : [%d]\n", retval );

} /* R_RUNCONT */

/*---------------------------------------------------------------------*/
void
R_RUNWAIT()
{
	char	pname[128];
	short	retval;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       r_runwait( char *pname(i), short *retval(o) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " pname        : " );
	gets( pname );
	gets( pname );

	r_runwait( pname, &retval );

	printf( "Result retval : [%d]\n", retval );

} /* R_RUNWAIT */

/*---------------------------------------------------------------------*/
void
E_RUNP()
{
	char	pname[128];
	char	args[2048];
	char	*argv[17];
	int	i, j;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_runp( char *pname(i), char *argv[](i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " pname               : " );
	scanf( "%s", pname );
	for( i=0, j=0; i<16 && j<2000; i++ )
	{
		printf( " argv[%2d] or 'exit' : ", i );
		scanf( "%s", &args[j] );
		if( !strcmp( &args[j], "exit" ) )
			break;
		argv[i] = &args[j];
		j += strlen( &args[j] ) + 1;
	}
	argv[i] = (char *)0;

	if( e_runp( pname, argv ) < 0 )
	{
		printf( "e_runp error ......\n" );
		return;
	}

	printf( " Result successful\n" );

} /* E_RUNP */

/*---------------------------------------------------------------------*/
void
E_RUNSYS()
{
	char	cmd[2048];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_runsys( char *cmd(i) )                        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cmd : " );
	gets( cmd );
	gets( cmd );

	if( e_runsys( cmd ) < 0 )
	{
		printf( "e_runsys error ......\n" );
		return;
	}

	printf( " Result successful\n" );

} /* E_RUNSYS */

/*---------------------------------------------------------------------*/
void
E_CMDARG()
{
	char	cmd[2048];
	char	argbuf[2048];
	char	*args[17];
	int	nargs;
	int	i;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_cmdarg( char *cmd(i), char *args[](o),        |\n" );
	printf( "|                 char *argbuf(o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cmd                     : " );
	gets( cmd );
	gets( cmd );

	if( ( nargs = e_cmdarg( cmd, args, argbuf ) ) < 0 )
	{
		printf( "e_cmdarg error ......\n" );
		return;
	}

	for( i=0; i<nargs; i++ )
		printf( " Result args[%2d] : [%s]\n", i, args[i] );

} /* E_CMDARG */

/*----------------------------------------------------------------------+
|	Display function for process interface				|
+----------------------------------------------------------------------*/
void
DisplayProcessF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( process interface )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. r_execprg  2. r_runcont  3. r_runwait\n" );
	printf( " 4. e_runp     5. e_runsys   6. e_cmdarg\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayProcessF */

/*----------------------------------------------------------------------+
|	Choose function for process interface				|
+----------------------------------------------------------------------*/
int
ChooseProcessF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 9 && ( choosenum < 1 || choosenum > 6 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseProcessF */

/*----------------------------------------------------------------------+
|	Main function for process interface				|
+----------------------------------------------------------------------*/
void
ProcessF()
{
	for( ; ; )
	{
		DisplayProcessF();
		switch( ChooseProcessF() )
		{
		case	1	:	R_EXECPRG();	break;
		case	2	:	R_RUNCONT();	break;
		case	3	:	R_RUNWAIT();	break;
		case	4	:	E_RUNP();	break;
		case	5	:	E_RUNSYS();	break;
		case	6	:	E_CMDARG();	break;
		default		:			return;
		}
	}

} /* ProcessF */

/****** End of process.c ***********************************************/
