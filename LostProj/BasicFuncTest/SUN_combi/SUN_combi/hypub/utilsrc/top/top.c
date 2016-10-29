#include	<stdio.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<sys/fault.h>
#include	<sys/syscall.h>
#include	<sys/procfs.h>
#include	<fcntl.h>
#include	<dirent.h>
#include	<signal.h>
#include	<errno.h>

#include	"cbuni.h"

#define		MAX_PROCESS	2048

#define		TIME_DISP	0x01
#define		SIZE_DISP	0x02
#define		CLAS_DISP	0x04
#define		JOB__DISP	0x08
#define		FULL_DISP	0x10

int		arg_opt = 0;
int		disptimes = 0;
int		dispinterval = 0;
int		displines = 0;
prstatus_t	prs[2][MAX_PROCESS];
prpsinfo_t	prps[MAX_PROCESS];
struct	pinfo_	{
	pid_t		pid;
	pid_t		ppid;
	pid_t		pgrp;
	pid_t		sid;
	char		clname[PRCLSZ];
	char		sname;
	char		nice;
	long		pri;
	long		size;
	long		rssize;
	u_long		bysize;
	u_long		byrssize;
	timestruc_t	start;
	timestruc_t	utime;
	timestruc_t	stime;
	timestruc_t	ttime;
	timestruc_t	ugap;
	timestruc_t	sgap;
	timestruc_t	tgap;
	char		fname[PRFNSZ];
	char		psargs[PRARGSZ];
}		prinfo[MAX_PROCESS];
struct	pinfo_	pitmp;
int		prevprocs = 0;
int		currprocs = 0;
DIR		*procdir = (DIR *)0;
int		pfd = -1;

void	p_sort CBD2(( int previx, int currix ));
void	p_disp();
void	Usage CBD2(( char *firstname ));

int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	struct	dirent	*procent;
	register	ntimes = 0;
	register	i, j;
	char		argv_0[128];
	int		dispcols = 31;

	strcpy( argv_0, argv[0] );

	for( argc--; argc>0; argc--, argv++ )
	{
		if( argv[1][0] == '-' )
		{
			for( i=1; i<strlen(argv[1]); i++ )
			{
				switch( argv[1][i] )
				{
				case	'a'	: arg_opt = -1;	break;
				case	't'	: arg_opt |= TIME_DISP;	break;
				case	's'	: arg_opt |= SIZE_DISP;	break;
				case	'c'	: arg_opt |= CLAS_DISP;	break;
				case	'j'	: arg_opt |= JOB__DISP;	break;
				case	'f'	: arg_opt |= FULL_DISP;	break;
				case	'h'	: Usage( argv_0 );
				default		:			break;
				}
			}
		}
		else
		{
			if( atoi( argv[1] ) <= 0 )
				Usage( argv_0 );

			if( ! dispinterval )
				dispinterval = atoi( argv[1] );
			else if( ! disptimes )
				disptimes = atoi( argv[1] );
			else if( ! displines )
				displines = atoi( argv[1] );
			else
				Usage( argv_0 );
		}
	}
	if( ! dispinterval )
		dispinterval = 1;
	else if( dispinterval > 30 )
		dispinterval = 30;
	if( ! disptimes )
		disptimes = 5;
	else if( disptimes > 256 )
		disptimes = 256;

	if( arg_opt & JOB__DISP )	dispcols += 10;
	if( arg_opt & CLAS_DISP )	dispcols += 10;
	if( arg_opt & SIZE_DISP )	dispcols += 28;
	if( arg_opt & TIME_DISP )	dispcols += 42;
	else				dispcols += 7;
	if( arg_opt & FULL_DISP )	dispcols += 30;
	if( ! displines || displines > ( dispcols > 80 ? 7 : 18 ) )
		displines = dispcols > 80 ? 7 : 18;

	if( chdir( "/proc" ) < 0 )
	{
		printf( "Can't change directory '/proc'. (errno=%d)\n", errno );
		return( errno );
	}

	if( ( procdir = opendir( "." ) ) == (DIR *)0 )
	{
		printf( "Can't open directory '/proc'. (errno=%d)\n", errno );
		return( errno );
	}

	do
	{
		if( ntimes )
		{
			memcpy( prs[0], prs[1], sizeof(prstatus_t) * currprocs);
			prevprocs = currprocs;
			if( ntimes > 1 )
				sleep( dispinterval );
			else if( ntimes > 0 )
				sleep( 1 );
			rewinddir( procdir );
		}

		for( currprocs=0; currprocs<MAX_PROCESS; )
		{
			procent = readdir( procdir );
			if( procent == (struct dirent *)0 )
				break;

			if( !strcmp( procent->d_name, "." ) ||
			    !strcmp( procent->d_name, ".." ) )
			{
				continue;
			}

			if( ( pfd = open( procent->d_name,  O_RDONLY ) ) < 0 )
				continue;

			if( ioctl( pfd, PIOCSTATUS, &prs[1][currprocs] ) < 0 )
			{
				close( pfd );
				continue;
			}

			if( ioctl( pfd, PIOCPSINFO, &prps[currprocs] ) < 0 )
			{
				close( pfd );
				continue;
			}

			close( pfd );
			pfd = -1;
			currprocs++;
		}

		if( ! ntimes )
			continue;

		for( j=0; j<currprocs; j++ )
		{
			for( i=0; prs[0][i].pr_pid != prs[1][j].pr_pid; )
				if( ++i >= prevprocs )
					break;
			p_sort( i, j );
		}

		p_disp();

	} while( ++ntimes <= disptimes );

	closedir( procdir );
	procdir = (DIR *)0;

	return( 0 );
}

void
#if	defined( __CB_STDC__ )
p_sort( int previx, int currix )
#else
p_sort( previx, currix )
int	previx;
int	currix;
#endif
{
	register	i;

	pitmp.pid = prs[1][currix].pr_pid;
	pitmp.ppid = prs[1][currix].pr_ppid;
	pitmp.pgrp = prs[1][currix].pr_pgrp;
	pitmp.sid = prs[1][currix].pr_sid;

	strcpy( pitmp.clname, prs[1][currix].pr_clname );
	pitmp.sname = prps[currix].pr_sname;
	pitmp.nice = prps[currix].pr_nice;
	pitmp.pri = prps[currix].pr_pri;

	pitmp.size = prps[currix].pr_size;
	pitmp.rssize = prps[currix].pr_rssize;
	pitmp.bysize = prps[currix].pr_bysize;
	pitmp.byrssize = prps[currix].pr_byrssize;

	memcpy( &pitmp.start, &prps[currix].pr_start, sizeof( timestruc_t ) );
	memcpy( &pitmp.utime, &prs[1][currix].pr_utime, sizeof( timestruc_t ) );
	memcpy( &pitmp.stime, &prs[1][currix].pr_stime, sizeof( timestruc_t ) );
	pitmp.ttime.tv_sec = prs[1][currix].pr_utime.tv_sec
					+ prs[1][currix].pr_stime.tv_sec;
	pitmp.ttime.tv_nsec = prs[1][currix].pr_utime.tv_nsec
					+ prs[1][currix].pr_stime.tv_nsec;
	if( pitmp.ttime.tv_nsec >= 1000000000L )
	{
		pitmp.ttime.tv_nsec -= 1000000000L;
		pitmp.ttime.tv_sec ++;
	}
	if( previx >= prevprocs )
	{
		memcpy( &pitmp.ugap, &prs[1][currix].pr_utime,
							sizeof( timestruc_t ) );
		memcpy( &pitmp.sgap, &prs[1][currix].pr_stime,
							sizeof( timestruc_t ) );
	}
	else
	{
		pitmp.ugap.tv_sec = prs[1][currix].pr_utime.tv_sec
					- prs[0][previx].pr_utime.tv_sec;
		pitmp.ugap.tv_nsec = prs[1][currix].pr_utime.tv_nsec
					- prs[0][previx].pr_utime.tv_nsec;
		if( pitmp.ugap.tv_nsec < 0L )
		{
			pitmp.ugap.tv_nsec += 1000000000L;
			pitmp.ugap.tv_sec --;
		}

		pitmp.sgap.tv_sec = prs[1][currix].pr_stime.tv_sec
					- prs[0][previx].pr_stime.tv_sec;
		pitmp.sgap.tv_nsec = prs[1][currix].pr_stime.tv_nsec
					- prs[0][previx].pr_stime.tv_nsec;
		if( pitmp.sgap.tv_nsec < 0L )
		{
			pitmp.sgap.tv_nsec += 1000000000L;
			pitmp.sgap.tv_sec --;
		}
	}
	pitmp.tgap.tv_sec = pitmp.ugap.tv_sec + pitmp.sgap.tv_sec;
	pitmp.tgap.tv_nsec = pitmp.ugap.tv_nsec + pitmp.sgap.tv_nsec;
	if( pitmp.tgap.tv_nsec >= 1000000000L )
	{
		pitmp.tgap.tv_nsec -= 1000000000L;
		pitmp.tgap.tv_sec ++;
	}

	strcpy( pitmp.fname, prps[currix].pr_fname );
	strcpy( pitmp.psargs, prps[currix].pr_psargs );

	for( i=0; i<currix; i++ )
	{
		if( prinfo[i].tgap.tv_sec > pitmp.tgap.tv_sec )
			continue;
		else if( prinfo[i].tgap.tv_sec < pitmp.tgap.tv_sec )
			break;

		if( prinfo[i].tgap.tv_nsec > pitmp.tgap.tv_nsec )
			continue;
		else if( prinfo[i].tgap.tv_nsec < pitmp.tgap.tv_nsec )
			break;
	}

	if( i != currix )
		memmove( &prinfo[i+1], &prinfo[i], sizeof pitmp * currix - i );

	memcpy( &prinfo[i], &pitmp, sizeof pitmp );
}

void
p_disp()
{
	register	i;
	time_t		curtime;

	curtime = time( (time_t *)0 );
	system( "clear" );
	printf( "----------------------------------------" );
	printf( "----------------------------------------\n" );
	printf( "  PID  PPID " );
    if( arg_opt & JOB__DISP )
	printf( " PGRP   SID " );
	printf( "S " );
    if( arg_opt & CLAS_DISP )
	printf( "CS NI PRI " );
    if( arg_opt & SIZE_DISP )
	printf( "SIZE RSSZ   BYSIZE   BYRSSZ " );
	printf( "   START " );
    if( arg_opt & TIME_DISP )
	printf( "     UT      ST      CT    UG    SG    CG " );
    else
	printf( "  TIME " );
	printf( "COMMAND\n" );

	printf( "----- ----- " );
    if( arg_opt & JOB__DISP )
	printf( "----- ----- " );
	printf( "- " );
    if( arg_opt & CLAS_DISP )
	printf( "-- -- --- " );
    if( arg_opt & SIZE_DISP )
	printf( "---- ---- -------- -------- " );
	printf( "-------- " );
    if( arg_opt & TIME_DISP )
	printf( "------- ------- ------- ----- ----- ----- " );
    else
	printf( "------ " );
	printf( "----------\n" );

	for( i=0; i<currprocs && i<displines; i++ )
	{
		if( prinfo[i].tgap.tv_sec == 0L &&
		    prinfo[i].tgap.tv_nsec == 0L )
		{
			break;
		}

		printf( "%5ld ", prinfo[i].pid );
		printf( "%5ld ", prinfo[i].ppid );
	    if( arg_opt & JOB__DISP )
	    {
		printf( "%5ld ", prinfo[i].pgrp );
		printf( "%5ld ", prinfo[i].sid );
	    }

		printf( "%c ", prinfo[i].sname );
	    if( arg_opt & CLAS_DISP )
	    {
		printf( "%2.2s ", prinfo[i].clname );
		printf( "%2d ", prinfo[i].nice );
		printf( "%3ld ", prinfo[i].pri );
	    }

	    if( arg_opt & SIZE_DISP )
	    {
		printf( "%4ld ", prinfo[i].size );
		printf( "%4ld ", prinfo[i].rssize );
		printf( "%8ld ", prinfo[i].bysize );
		printf( "%8ld ", prinfo[i].byrssize );
	    }

		prinfo[i].start.tv_sec += 3600 * 9;
	    if( curtime - prinfo[i].start.tv_sec > 86400 )
	    {
		int	year;
		int	month;
		int	yeardate;
		int	monthdate;
		prinfo[i].start.tv_sec /= 86400;
		prinfo[i].start.tv_sec ++;
		for( year=1970; ; year++ )
		{
			yeardate = 365;
			if( !( year % 4 ) )
			{
				if( !( year % 100 ) )
				{
					if( !( year % 400 ) )
						yeardate ++;
				}
				else
					yeardate ++;
			}
			if( prinfo[i].start.tv_sec <= yeardate )
				break;

			prinfo[i].start.tv_sec -= yeardate;
		}
		year %= 100;

		for( month=1; ; month++ )
		{
			if( month == 2 )
			{
				if( yeardate == 365 )	monthdate = 28;
				else			monthdate = 29;
			}
			else if( month >= 8 )
			{
				if( month % 2 )		monthdate = 30;
				else			monthdate = 31;
			}
			else
			{
				if( month % 2 )		monthdate = 31;
				else			monthdate = 30;
			}

			if( prinfo[i].start.tv_sec <= monthdate )
				break;

			prinfo[i].start.tv_sec -= monthdate;
		}

		printf( "%02d/%02d/%02ld ", year, month,
						prinfo[i].start.tv_sec );
	    }
	    else
	    {
		prinfo[i].start.tv_sec %= 86400;
		printf( "%02ld:%02ld:%02ld ",
					prinfo[i].start.tv_sec / 3600,
					prinfo[i].start.tv_sec % 3600 / 60,
					prinfo[i].start.tv_sec % 60 );
	    }
	    if( arg_opt & TIME_DISP )
	    {
	      if( prinfo[i].utime.tv_sec >= 60 )
		printf( "%4ld:%02.2ld ", prinfo[i].utime.tv_sec / 60L,
					prinfo[i].utime.tv_sec % 60L );
	      else
		printf( "%4ld.%02.2ld ", prinfo[i].utime.tv_sec,
					prinfo[i].utime.tv_nsec / 10000000L );
	      if( prinfo[i].stime.tv_sec >= 60 )
		printf( "%4ld:%02.2ld ", prinfo[i].stime.tv_sec / 60L,
					prinfo[i].stime.tv_sec % 60L );
	      else
		printf( "%4ld.%02.2ld ", prinfo[i].stime.tv_sec,
					prinfo[i].stime.tv_nsec / 10000000L );
	      if( prinfo[i].ttime.tv_sec >= 60 )
		printf( "%4ld:%02.2ld ", prinfo[i].ttime.tv_sec / 60L,
					prinfo[i].ttime.tv_sec % 60L );
	      else
		printf( "%4ld.%02.2ld ", prinfo[i].ttime.tv_sec,
					prinfo[i].ttime.tv_nsec / 10000000L );
	      if( prinfo[i].ugap.tv_sec >= 60 )
		printf( "%2ld:%02.2ld ", prinfo[i].ugap.tv_sec / 60L,
					prinfo[i].ugap.tv_sec % 60L );
	      else
		printf( "%2ld.%02.2ld ", prinfo[i].ugap.tv_sec,
					prinfo[i].ugap.tv_nsec / 10000000L );
	      if( prinfo[i].sgap.tv_sec >= 60 )
		printf( "%2ld:%02.2ld ", prinfo[i].sgap.tv_sec / 60L,
					prinfo[i].sgap.tv_sec % 60L );
	      else
		printf( "%2ld.%02.2ld ", prinfo[i].sgap.tv_sec,
					prinfo[i].sgap.tv_nsec / 10000000L );
	      if( prinfo[i].tgap.tv_sec >= 60 )
		printf( "%2ld:%02.2ld ", prinfo[i].tgap.tv_sec / 60L,
					prinfo[i].tgap.tv_sec % 60L );
	      else
		printf( "%2ld.%02.2ld ", prinfo[i].tgap.tv_sec,
					prinfo[i].tgap.tv_nsec / 10000000L );
	    }
	    else
	    {
		printf( "%3ld:%02ld ", prinfo[i].ttime.tv_sec / 60L,
					prinfo[i].ttime.tv_sec % 60L );
	    }

	    if( arg_opt & FULL_DISP )
		printf( "%s", prinfo[i].psargs );
	    else
		printf( "%s", prinfo[i].fname );

		printf( "\n" );
	}
	printf( "----------------------------------------" );
	printf( "----------------------------------------\n" );
}

void
#if	defined( __CB_STDC__ )
Usage( char *firstname )
#else
Usage( firstname )
char	*firstname;
#endif
{
	printf( "\n" );
	printf( "Top process display\n" );
	printf( "\n" );
	printf( "USAGE : %s [ -acfjst ] [ interval [ times [ lines ] ] ]\n",
								firstname );
	printf( "\n" );
	printf( "   -a : all display\n" );
	printf( "   -c : display scheduler properties\n" );
	printf( "   -f : display full listing\n" );
	printf( "   -j : display session ID and process group ID\n" );
	printf( "   -s : display memory size\n" );
	printf( "   -t : display cpu time\n" );
	printf( "\n" );
	exit( EINVAL );
}
