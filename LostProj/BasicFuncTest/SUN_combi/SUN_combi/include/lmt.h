/* lmt.h */
/*----------------------------------------------------------------------*/
/* LMT	TABLE								*/
/*----------------------------------------------------------------------*/
#ifndef	LMT_H
#define	LMT_H

#include	<sys/types.h>
#include	"clm.h"

struct  SHM_INFO		/*  80 bytes				*/
{
        char    tabid[16];	/*  16 LMT				*/
        char    tabnm[32];	/*  32 License Manager Table		*/
        key_t   shmkey;		/*   4 shared memory key		*/
				/*     DEF : 26624			*/
        int     shmid;		/*   4 shm id by shmget()		*/
        int     lmtsize;	/*   4 LMT total table size in bytes.	*/
        time_t  createtm;	/*   4 table create time. Long		*/
        time_t  changetm;	/*   4 table change time. Long		*/
        int     semid;		/*   4 semaphore id			*/
        int     nsems;		/*   4 no of semaphore array		*/
        char    filler[4];	/*   4 filler				*/
};

struct	CORE_INFO		/*  16 bytes			*/
{
	pid_t	pid_tpm;	/*   4 pid of clmtpm		*/
	pid_t	pid_dbc;	/*   4 pid of clmdbc		*/
	pid_t	pid_web;	/*   4 pid of clmweb		*/
	pid_t	pid_mon;	/*   4 pid of clmmon		*/
	
};

struct	CURR_INFO		/*  32 bytes			*/
{
        int	r_date;		/*   4 남은날짜(Trial)/1(정식)	*/
	int	interval;	/*   4 clmmon chk interval	*/
	int	n_tpmins;	/*   4 cnt of used tp instance	*/
	int	n_dbcins;	/*   4 cnt of used db instance	*/
	int	n_webins;	/*   4 cnt of used web instance	*/
	int	n_tpmusr;	/*   4 cnt of used tp user	*/
	int	n_dbcusr;	/*   4 cnt of used db user	*/
	int	n_webusr;	/*   4 cnt of used web user	*/
};
struct	OFFT_INFO		/*  24 bytes			*/
{
	int	tins_offset;	/*   4 offset of TINS_INFO	*/
	int	dins_offset;	/*   4 offset of DINS_INFO	*/
	int	wins_offset;	/*   4 offset of WINS_INFO	*/
	int	tusr_offset;	/*   4 offset of TUSR_INFO	*/
	int	dusr_offset;	/*   4 offset of DUSR_INFO	*/
	int	wusr_offset;	/*   4 offset of WUSR_INFO	*/
};

struct	TINS_INFO		/*   8 bytes			*/
{
	pid_t	ins_tp;		/*   4 pid of tpsess		*/
	int	portno;		/*   4 port number of tpid	*/
};

struct	DINS_INFO		/*   8 bytes			*/
{
	pid_t	ins_db;		/*   4 pid of dlmast		*/
	key_t	shmkey;		/*   4 shmkey of dla		*/
};

struct	WINS_INFO		/*   4 bytes			*/
{
	key_t	shmkey;		/*   4 shmkey of web service	*/
};

struct	TUSR_INFO		/*   8 bytes			*/
{
	int	portno;		/*   4 portno of tpsess		*/
	int	usr_tp;		/*   4 session number		*/
};

struct	DUSR_INFO		/*   8 bytes			*/
{
	key_t	shmkey;		/*   4 shmkey of dla		*/
	pid_t	usr_db;		/*   4 pid of dlserv		*/
};

struct	WUSR_INFO		/*   8 bytes			*/
{
	key_t	shmkey;		/*   4 shmkey of wbt		*/
	pid_t	usr_wb;		/*   4 pid of wbroker		*/
};

struct  LMT_FORM
{
        struct  SHM_INFO        shm_info;	/* shm info		*/
        struct  CLM_INFO        clm_info;	/* license info		*/
	struct	CORE_INFO	core_info;	/* clmcore pid info	*/
	struct	CURR_INFO	curr_info;	/* current info		*/
	struct	OFFT_INFO	offt_info;	/* struct offset info	*/
	struct	TINS_INFO	tins_info[1];	/* tp inst. tbl		*/
	struct	DINS_INFO	dins_info[1];	/* db inst. tbl		*/
	struct	WINS_INFO	wins_info[1];	/* web inst.tbl		*/
	struct	TUSR_INFO	tusr_info[1];	/* tp usr tbl		*/
	struct	DUSR_INFO	dusr_info[1];	/* db usr tbl		*/
	struct	WUSR_INFO	wusr_info[1];	/* web usr tbl		*/
};

#endif	/* LMT_H */
