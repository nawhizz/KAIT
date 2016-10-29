#include	<stdio.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<sys/fault.h>
#include	<sys/syscall.h>
#include	<sys/ucontext.h>
#include	<sys/procfs.h>
#include	<fcntl.h>
#include	<signal.h>
#include	<errno.h>

#include	"cbuni.h"

#define		MAX_PIDS	32

#define		ALL_INFO	0xFF
#define		SIG_INFO	0x01
#define		TIM_INFO	0x02
#define		MEM_INFO	0x04
#define		CPU_INFO	0x08
#define		ARG_INFO	0x10

pid_t	arg_pid[MAX_PIDS] = { 0 };
int	arg_pids = 0;
int	arg_opt = 0;

void
#if	defined( __CB_STDC__ )
Usage( char *firstname )
#else
Usage( firstname )
char	*firstname;
#endif
{
	printf( "\n" );
	printf( "process information display\n" );
	printf( "\n" );
	printf( "USAGE : %s [-astmcr] pid\n", firstname );
	printf( "        -a : display all information\n" );
	printf( "        -s : display signal information\n" );
	printf( "        -t : display time information\n" );
	printf( "        -m : display memory information\n" );
	printf( "        -c : display CPU information\n" );
	printf( "        -r : display syscall arguments information\n" );
	printf( "\n" );
	exit( EINVAL );
}

int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{
	register	i, j, k;
	int		pfd;
	char		argv_0[128];
	char		pfname[128];
	prstatus_t	prs;

setbuf( stdout, (char *)0 );
	strcpy( argv_0, argv[0] );
	if( argc < 2 )
		Usage( argv_0 );

	for( argc--; argc>0; argc--, argv++ )
	{
		if( atoi( argv[1] ) > 0 )
			arg_pid[arg_pids++] = (long)atoi( argv[1] );
		else if( argv[1][0] == '-' )
		{
			for( i=1; i<strlen(argv[1]); i++ )
			{
				switch( argv[1][i] )
				{
				case	'a'	: arg_opt = ALL_INFO;	break;
				case	's'	: arg_opt |= SIG_INFO;	break;
				case	't'	: arg_opt |= TIM_INFO;	break;
				case	'm'	: arg_opt |= MEM_INFO;	break;
				case	'c'	: arg_opt |= CPU_INFO;	break;
				case	'r'	: arg_opt |= ARG_INFO;	break;
				default		:			break;
				}
			}
		}
	}

	if( !arg_pids )
		Usage( argv_0 );

	arg_pid[arg_pids] = 0L;

	for( i=0; i<arg_pids; i++ )
	{
		sprintf( pfname, "/proc/%05ld", arg_pid[i] );
		if( ( pfd = open( pfname,  O_RDONLY ) ) < 0 )
		{
			printf( "%s open error (errno=%d)\n", pfname, errno );
			continue;
		}

		if( ioctl( pfd, PIOCSTATUS, &prs ) < 0 )
		{
			printf( "%s ioctl error (errno=%d)\n", pfname, errno );
			close( pfd );
			continue;
		}

		printf( "----------- %ld ---------------------\n", arg_pid[i] );
		if( arg_opt == ALL_INFO )
		{
			printf( "  pr_flags      = %ld\n", prs.pr_flags );
			printf( "  pr_why        = %d\n", prs.pr_why );
			printf( "  pr_what       = %d\n", prs.pr_what );
		}
		if( arg_opt & SIG_INFO )
		{
			/* siginfo_t pr_info; */
			/* Info associated with signal or fault */
			printf( "  pr_info.si_signo = %d\n",
							prs.pr_info.si_signo );
			printf( "  pr_info.si_code = %d\n",
							prs.pr_info.si_code );
			printf( "  pr_info.si_errno = %d\n",
							prs.pr_info.si_errno );
			for( j=0; j<4; j++ )
			{
				printf( "  pr_sigpend.__sigbits[%d] = %d\n",
					j, prs.pr_sigpend.__sigbits[j] );
			}
			for( j=0; j<4; j++ )
			{
				printf( "  pr_sighold.__sigbits[%d] = %d\n",
					j, prs.pr_sighold.__sigbits[j] );
			}
			for( j=0; j<4; j++ )
			{
				printf( "  pr_lwppend.__sigbits[%d] = %ld\n",
					j, prs.pr_lwppend.__sigbits[j] );
			}
		}
		if( arg_opt == ALL_INFO )
		{
			printf( "  pr_cursig     = %d\n", prs.pr_cursig );
			printf( "  pr_nlwp       = %d\n", prs.pr_nlwp );
		}
		printf( "  pr_pid        = %ld\n", prs.pr_pid );
		printf( "  pr_ppid       = %ld\n", prs.pr_ppid );
		printf( "  pr_pgrp       = %ld\n", prs.pr_pgrp );
		printf( "  pr_sid        = %ld\n", prs.pr_sid );
		if( arg_opt & TIM_INFO )
		{
			printf( "  pr_utime      = (%05ld:%09ld)\n",
				prs.pr_utime.tv_sec, prs.pr_utime.tv_nsec );
			printf( "  pr_stime      = (%05ld:%09ld)\n",
				prs.pr_stime.tv_sec, prs.pr_stime.tv_nsec );
			printf( "  pr_cutime     = (%05ld:%09ld)\n",
				prs.pr_cutime.tv_sec, prs.pr_cutime.tv_nsec );
			printf( "  pr_cstime     = (%05ld:%09ld)\n",
				prs.pr_cstime.tv_sec, prs.pr_cstime.tv_nsec );
		}
		printf( "  pr_clname     = %s\n", prs.pr_clname );
		printf( "  pr_syscall    = %d\n", prs.pr_syscall );
		if( arg_opt & ALL_INFO )
			printf( "  pr_nsysarg    = %d\n", prs.pr_nsysarg );
		if( arg_opt & ARG_INFO )
		{
			for( j=0; j<PRSYSARGS && j<prs.pr_nsysarg; j++ )
			{
				printf( "  pr_sysarg[%d]  = %d\n",
							j, prs.pr_sysarg[j] );
			}
		}
		if( arg_opt & ALL_INFO )
			printf( "  pr_who        = %ld\n", prs.pr_who );
		if( arg_opt & MEM_INFO )
		{
#ifdef	IF_CAN_ACCESS_OLDCONTEXT
			printf( "  pr_oldcontext.uc_flags = %ld\n",
						prs.pr_oldcontext->uc_flags );
			printf( "  pr_oldcontext.uc_link = %x\n",
						prs.pr_oldcontext->uc_link );
			printf( "  pr_oldcontext.uc_sigmask.__sigbits[0]= %x\n",
				prs.pr_oldcontext->uc_sigmask.__sigbits[0] );
			printf( "  pr_oldcontext.uc_sigmask.__sigbits[1]= %x\n",
				prs.pr_oldcontext->uc_sigmask.__sigbits[1] );
			printf( "  pr_oldcontext.uc_sigmask.__sigbits[2]= %x\n",
				prs.pr_oldcontext->uc_sigmask.__sigbits[2] );
			printf( "  pr_oldcontext.uc_sigmask.__sigbits[3]= %x\n",
				prs.pr_oldcontext->uc_sigmask.__sigbits[3] );
			printf( "  pr_oldcontext.uc_stack.ss_sp= %x\n",
					prs.pr_oldcontext->uc_stack.ss_sp );
			printf( "  pr_oldcontext.uc_stack.ss_size= %d\n",
					prs.pr_oldcontext->uc_stack.ss_size );
			printf( "  pr_oldcontext.uc_stack.ss_flags= %x\n",
					prs.pr_oldcontext->uc_stack.ss_flags );
			for( j=0; j<NGREG; j++ )
			{
			printf( "  pr_oldcontext.uc_mcontext.gregs[%d]= %d\n",
				j, prs.pr_oldcontext->uc_mcontext.gregs[j] );
			}
			printf( "  pr_oldcontext.uc_mcontext.gwins.wbcnt= %d\n",
				prs.pr_oldcontext->uc_mcontext.gwins->wbcnt );
			for( j=0; j<SPARC_MAXREGWINDOW; j++ )
			{
		printf( "  pr_oldcontext.uc_mcontext.gwins.spbuf[%d]= %d\n",
			j, prs.pr_oldcontext->uc_mcontext.gwins->spbuf[j] );
			}
			for( j=0; j<SPARC_MAXREGWINDOW; j++ )
			{
				for( k=0; k<8; k++ )
				{
	printf( "  pr_oldcontext.uc_mcontext.gwins.wbuf[%d].rw_local[%d]= %d\n",
	j, k, prs.pr_oldcontext->uc_mcontext.gwins->wbuf[j].rw_local[k] );
	printf( "  pr_oldcontext.uc_mcontext.gwins.wbuf[%d].rw_in[%d]= %d\n",
		j, k, prs.pr_oldcontext->uc_mcontext.gwins->wbuf[j].rw_in[k] );
				}
			}
			for( j=0; j<32; j++ )
			{
	printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_fr.fpu_regs[%d]= %d\n",
		j, prs.pr_oldcontext->uc_mcontext.fpregs.fpu_fr.fpu_regs[j] );
			}
			for( j=0; j<16; j++ )
			{
	printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_fr.fpu_dregs[%d]= %d\n",
		j, prs.pr_oldcontext->uc_mcontext.fpregs.fpu_fr.fpu_dregs[j] );
			}
	printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_q.FQu.whole = %lf\n",
		prs.pr_oldcontext->uc_mcontext.fpregs.fpu_q->FQu.whole );
	printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_q.FQu.whole = %lf\n",
		prs.pr_oldcontext->uc_mcontext.fpregs.fpu_q->FQu.whole );
printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_q.FQu.fpq.fpq_addr = %x\n",
		prs.pr_oldcontext->uc_mcontext.fpregs.fpu_q->FQu.fpq.fpq_addr );
printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_q.FQu.fpq.fpq_instr = %ld\n",
	prs.pr_oldcontext->uc_mcontext.fpregs.fpu_q->FQu.fpq.fpq_instr );
		printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_fsr = %d\n",
			prs.pr_oldcontext->uc_mcontext.fpregs.fpu_fsr );
		printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_qcnt = %d\n",
			prs.pr_oldcontext->uc_mcontext.fpregs.fpu_qcnt );
	printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_q_entrysize = %d\n",
			prs.pr_oldcontext->uc_mcontext.fpregs.fpu_q_entrysize );
		printf( "  pr_oldcontext.uc_mcontext.fpregs.fpu_en = %d\n",
				prs.pr_oldcontext->uc_mcontext.fpregs.fpu_en );
			printf( "  pr_oldcontext.uc_mcontext.xrs.xrs_id = %d\n",
				prs.pr_oldcontext->uc_mcontext.xrs.xrs_id );
			printf( "  pr_oldcontext.uc_mcontext.xrs.xrs_ptr= %x\n",
				prs.pr_oldcontext->uc_mcontext.xrs.xrs_ptr );
#endif	/* IF_CAN_ACCESS_OLDCONTEXT */
			printf( "  pr_brkbase    = %x\n", prs.pr_brkbase );
			printf( "  pr_brksize    = %ld\n", prs.pr_brksize );
			printf( "  pr_stkbase    = %x\n", prs.pr_stkbase );
			printf( "  pr_stksize    = %ld\n", prs.pr_flags );
		}
		if( arg_opt & CPU_INFO )
		{
			printf( "  pr_processor  = %d\n", prs.pr_processor );
			printf( "  pr_bind       = %d\n", prs.pr_bind );
			printf( "  pr_instr      = %ld\n", prs.pr_instr );
			for( j=0; j<NPRGREG; j++ )
				printf( "  pr_reg (R_G%02d)= %d\n",
							j, prs.pr_reg[j] );
		}

		close( pfd );
	}

	return( 0 );
}
