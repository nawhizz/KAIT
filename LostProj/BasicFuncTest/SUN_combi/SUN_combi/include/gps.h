/* gps.h */
/*----------------------------------------------------------------------*/
/* HEADER for GPSLIB							*/
/*----------------------------------------------------------------------*/
#ifndef GPS_H
#define GPS_H

/* 980422 for compatibility */
#include        "cbuni.h"

/*----------------------------------------------------------------------*/
/* FUNCTION NAMING GROUP						*/
/*----------------------------------------------------------------------*/
/*
d   : data manipulation functions
e   : other functions
f   : file i/o functions
k   : keyboard i/o functions
n   : network interface functions
r   : process interface functions
l   : local functions within each module
*/

/*----------------------------------------------------------------------*/
/* STRUCTURES								*/
/*----------------------------------------------------------------------*/
typedef struct { long sec; long micro; } E_TIMESEC;

/*----------------------------------------------------------------------*/
/* MACRO FUNCTIONS							*/
/*----------------------------------------------------------------------*/
#define ASCIIVAL(keyval)     ( keyval & 0x00ff )
#define SCANVAL(keyval)      ( keyval >> 8 )
#define d_random(lmt)	(int)(((float)random()/2147483648.)*(float)lmt)

/*----------------------------------------------------------------------*/
/* ERROR NUMBER 							*/
/*----------------------------------------------------------------------*/
#define EGP_INPUTERR	30001	/* argument input error */
#define EGP_CFGEMPTY	30002	/* configuration file empty */
#define EGP_ENVVALEMPTY	30003	/* envrionment value empty */
#define EGP_ENVVALERR	30004	/* environment value error */
#define EGP_REMCMT	30005	/* environment variable rem comment set */
#define EGP_NOTEXIST	30006	/* environment variable not exist */
#define EGP_NOMEM	30007	/* memory insufficient */
#define EGP_GETOWNERERR	30008	/* get ownerid, groupid error */

#define	EGP_CFG_INVAL		30010	/* invalid argument */
#define	EGP_CFG_NOMEM		30011	/* no more memory */
#define	EGP_CFG_NOENT		30012	/* can't acces cfg file */
#define	EGP_CFG_INVAL_GRP	30013	/* invalid group name */
#define	EGP_CFG_INVAL_ITEM	30014	/* invalid item name */
#define	EGP_CFG_BADF		30015	/* bad file number */
#define	EGP_CFG_NOMORE		30016	/* no more group or item */
#define	EGP_FCOPYARG1		30017	/* src path is null */
#define	EGP_FCOPYARG2		30018	/* dest path is null */
#define	EGP_FCOPYNOTFOUND	30019	/* src path is not found */
#define	EGP_FCOPYREADPERM	30020	/* src path is unreadable */

/********** Added 10 lines by YI, 990521 **************************************/
#define	EGP_FCOPYPATHWRONG	30021	/* dest path is wrong */
#define	EGP_FCOPYPATHERR	30022	/* dest path is not absolute path */
#define	EGP_FCOPYEXIST		30023	/* dest path is exist already */
#define	EGP_FCOPYWRONGDIR	30024	/* dest dir is wrong */
#define	EGP_FCOPYNOTDIR		30025	/* dest dir is not directory */
#define	EGP_FCOPYOPENERR1	30026	/* src path can't open */
#define	EGP_FCOPYGETSIZE	30027	/* src path's size is unaware */
#define	EGP_FCOPYREADERR	30028	/* src file is unreadable */
#define	EGP_FCOPYOPENERR2	30029	/* dest path can't open */
#define	EGP_FCOPYWRITEERR	30030	/* dest file is unwriteable */
#define	EGP_FCOPYCHGMODEERR	30031	/* dest file mode change error */
/******************************************************************************/

#ifdef  WIN32
# if     defined( GPS_INTERNAL )
#  define CBD0  extern
# else
#  define CBD0  __declspec( dllimport )
# endif
#else
# define CBD0   extern
#endif

#ifdef	__cplusplus
extern "C" {
#endif

/*----------------------------------------------------------------------*/
/* ERROR NUMBER VARIABLE						*/
/*----------------------------------------------------------------------*/
#ifndef _HYERRNO
#define _HYERRNO
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
#ifdef	WIN32
	#ifdef	__IS_HYS_GPS__
		CBD0	int * __cdecl	_hyerrno( void );
		CBD0	int	hyerrno;
	#else	/* ndef __IS_HYS_GPS__ */
		#if	( defined( _MT ) || defined( _DLL ) ) && !defined( _MAC )
			CBD0	int * __cdecl	_hyerrno( void );
			#define	hyerrno		(*_hyerrno())
		#else   	/* ndef _MT && ndef _DLL */
			CBD0	int	hyerrno;
		#endif  	/* _MT || _DLL */
	#endif	/* ndef __IS_HYS_GPS__ */
#else		/* ndef WIN32 */
	CBD0	int	hyerrno;
#endif		/* WIN32 */
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
/*	98.09.16 for MultiThread by JJH ( Delete )
CBD0 int	hyerrno;
*/
#endif	/* _HYERRNO */

#undef  CBD0

/*----------------------------------------------------------------------*/
/* FUNCTION PROTOTYPE							*/
/*----------------------------------------------------------------------*/

int CBD1	TraceLog( int fd, char *fmt, ... );

#ifndef         WIN32
int CBD1	s_select CBD2(( int fd, int opt, int timeoutsec ));
#endif

/* for 'C' */
int CBD1        d_adjndecimal CBD2(( char *string, char leftfillchar,
                                                        int length ));
int CBD1	d_d2nstr CBD2(( double number, char *dest, int destlen,
                                        int pntlen, char leftfillchar ));
int CBD1	d_dectoint CBD2(( char *string, int size, int *number ));
int CBD1	d_filldata CBD2(( char src[], int srclen, char dest[],
                                        char *filldata, char maskchar ));
int CBD1	d_fillform CBD2(( char src[], int srclen, char dest[],
                                char *filldata, int fillen, char maskchar ));
int CBD1	d_fmask CBD2(( char src[], int srclen, char dest[], char *mask,
						char leftfillchar ));
int CBD1	d_hanadjt CBD2(( char src[], int srclen, char dest[] ));
int CBD1	d_nhex2int CBD2(( char *string, int size ));
int CBD1	d_hextoint CBD2(( char *string, int size, int *number ));
int CBD1	d_imask CBD2(( char src[], int srclen, char dest[], char *mask,
						char leftfillchar ));
void CBD1	d_int2ndec CBD2(( unsigned num, int destsize, char leftfillchar,
                                                                char *dest ));
void CBD1	d_int2nhex CBD2(( int num, int destsize, char leftfillchar,
                                                                char *dest ));
void CBD1	d_inttodec CBD2(( int num, int destsize, char leftfillchar,
                                                                char *dest ));
void CBD1	d_inttohex CBD2(( int num, int destsize, char leftfillchar,
                                                                char *dest ));
int CBD1	d_isnumstr CBD2(( char *string ));
int CBD1	d_isspacenstr CBD2(( char *string, int length ));
int CBD1	d_isspacestr CBD2(( char *string ));
double CBD1	d_julsa CBD2(( double number ));
int CBD1	d_leftalign CBD2(( char src[], int srclen, char dest[],
                                                        char rightfillchar ));
void CBD1	d_mkstr CBD2(( char *src, int srclen, char *dest ));
int CBD1	d_mkstradd CBD2(( char *src1, char *src2, char *dest,
                                                        int *destlen ));
int CBD1	d_ndec2int CBD2(( char *string, int size ));
int CBD1	d_nstr2d CBD2(( char string[], int size, double *number ));
int CBD1	d_nstradd CBD2(( char *src1, char *src2, char *dest,
                                                                int length ));
int CBD1	d_nstradd2 CBD2(( char *src1, int src1len, char *src2,
                                        int src2len, char *dest, int destlen ));
int CBD1	d_rightalign CBD2(( char *src, int srclen, char *dest,
                                                        char leftfillchar ));
int CBD1	d_ringclose CBD2(( int ringid ));
int CBD1	d_ringcopy CBD2(( int ringid, char *data, int *length ));
int CBD1	d_ringopen CBD2(( char *ringbuff, int buffsize ));
int CBD1	d_ringread CBD2(( int ringid, char *data, int *length ));
int CBD1	d_ringwrite CBD2(( int ringid, char *data, int *length ));
int CBD1	d_strendnull CBD2(( char *string, int length ));
int CBD1	d_strsort CBD2(( int keyptr, int keyleng, int noofrec,
                                                int recsize, char *recbuff ));
int CBD1	d_umask CBD2(( char *src, char *dest, int destlen, char *mask,
						char leftfillchar ));

int CBD1	e_dates2du CBD2(( char *date1, int form, char *date2,
						int *dura ));
int CBD1	e_addsigact CBD2(( int signo, int (*sig_func)( int ) ));
int CBD1	e_alldayget CBD2(( char *srcdate, char *mask ));
int CBD1	e_cdate2form CBD2(( char *srcdate, int form, char *destdate ));
int CBD1	e_chkdate CBD2(( char *datestr, int form ));
int CBD1	e_cmdarg CBD2(( char *command, char **args, char *argbuff ));
int CBD1	e_date2jul CBD2(( char *srcdate, char *mask ));
int CBD1	e_datechk CBD2(( char *srcdate, char *mask ));
int CBD1	e_datecmp CBD2(( char srcdate1[], char srcdate2[],
                                                                char *mask ));
int CBD1	e_day2nday CBD2(( char *srcdate, int nmonth, char *destdate ));
int CBD1	e_delenv CBD2(( char *envname ));
int CBD1	e_dudate CBD2(( int duration, char src[], char dest[],
                                                                char *mask ));
int CBD1	e_fullyear CBD2(( char src[], char dest[] ));
int CBD1	e_gdate2date CBD2(( char *srcdate, int form, long *ldate ));
int CBD1	e_gdate2year CBD2(( char *srcdate, int form, long *ldate ));
int CBD1	e_gdatebydu CBD2(( int form, char *srcdate, int duration,
                                                int flag, char *destdate ));
int CBD1	e_getdatestr CBD2(( long timeval, int choice, char *datestr,
                                                        char *timestr ));
int CBD1	e_getenv CBD2(( char *envname, char *envvalue ));
int CBD1	e_getsysdate CBD2(( int choice, char *datestr, char *timestr ));
void CBD1	e_gettime CBD2(( E_TIMESEC *tsc ));
int CBD1	e_getweekday CBD2(( char *srcdate, char *mask )); /*20000328*/
int CBD1	e_getyear CBD2(( int year ));
int CBD1	e_gmontbydu CBD2(( int form, char *srcdate, int duration,
                                                int flag, char *destdate ));
int CBD1	e_gre2jul CBD2(( char *datestr, int form ));
int CBD1	e_jul2date CBD2(( int julian, char srcdate[], char destdate[],
                                                                char *mask ));
int CBD1	e_jul2gre CBD2(( int julian, int form, char *srcdate,
                                                        char *destdate ));
int CBD1	e_lstdayget CBD2(( char srcdate[], char lastday[],
                                                                char *mask ));
int CBD1	e_nextday CBD2(( char srcdate[], char destdate[], char *mask ));
int CBD1	e_nextmonth CBD2(( char srcdate[], char destdate[],
                                                                char *mask ));
int CBD1	e_prevday CBD2(( char srcdate[], char destdate[], char *mask ));
int CBD1	e_prevmonth CBD2(( char srcdate[], char destdate[],
                                                                char *mask ));
int CBD1	e_runp CBD2(( char *progname, char **args ));
int CBD1	e_runsys CBD2(( char *command ));
int CBD1	e_setenv CBD2(( char *envname, char *envvalue ));
void CBD1	e_sleep0001 CBD2(( int microsec ));
void CBD1	e_timegap CBD2(( E_TIMESEC *starttime, E_TIMESEC *endtime,
                                                        E_TIMESEC *gap ));
int CBD1	f_chmod CBD2(( char *filepath, int mode ));
int CBD1	f_chown CBD2(( char *filepath, char *ownername ));
int CBD1	f_getenv CBD2(( char *cfgfpath, char *envname,
                                                        char *envvalue ));
int CBD1	f_getfpath CBD2(( char *fileid, char *fileext, char *envname,
                                                        char *filepath));
int CBD1	f_lock CBD2(( int fd ));
int CBD1	f_lockwait CBD2(( int fd ));
int CBD1	f_mkdir CBD2(( char *filepath, int mode ));
int CBD1	f_setenv CBD2(( char *cfgfpath ));
int CBD1	f_unlock CBD2(( int fd ));
/********** Added 1 line by YI, 990521 ****************************************/
int CBD1	f_copy CBD2(( char *spath, char *dpath, char overwrite ));
/******************************************************************************/
void CBD1	k_acceptstr CBD2(( char *string, int length ));
void CBD1	k_getchar CBD2(( short *keyvalue ));
void CBD1	k_inpnnumeric CBD2(( char *string, int length ));
void CBD1	k_inpnstring CBD2(( char *string, int length ));
int CBD1	r_chkshm CBD2(( int shmkey ));
int CBD1	r_crtshm CBD2(( int shmkey, int shmsize, int *shmid,
                                                        char **shmaddr ));
int CBD1	r_delshm CBD2(( int shmkey ));
void CBD1	r_execprg CBD2(( char *progname, short *retval ));
int CBD1	r_getshm CBD2(( int shmkey, int shmsize, int *shmid,
                                                        char **shmaddr ));
void CBD1	r_runcont CBD2(( char *progname, short *retval ));
void CBD1	r_runwait CBD2(( char *progname, short *retval ));
int CBD1	s_readstream CBD2(( int fd, char *data, int datelen,
                                                        int timeoutsec ));
int CBD1	s_writestream CBD2(( int fd, char *data, int datelen,
                                                        int timeoutsec ));
int CBD1	rf_build CBD2(( char *fpath, int fmode, int recsize,
                                                        int maxrecno ));
int CBD1	rf_open CBD2(( char *fpath ));
int CBD1	rf_close CBD2(( int fd ));
int CBD1	rf_delete CBD2(( int fd, int waitmsec ));
int CBD1	rf_get CBD2(( int fd, char *recdata ));
int CBD1	rf_getd CBD2(( int fd, int recno, char *recdata ));
int CBD1	rf_getinfo CBD2(( int fd, int *recsize, int *maxrecno,
                                                        int *quelen ));
int CBD1	rf_getnew CBD2(( int fd, int recno, char *recdata ));
int CBD1	rf_getold CBD2(( int fd, int recno, char *recdata ));
int CBD1	rf_read CBD2(( int fd, char *recdata, int waitmsec ));
int CBD1	rf_write CBD2(( int fd, char *recdata, int length,
                                                        int waitmsrc));
int CBD1	cfg_open CBD2(( char *cfgfpath, char *mode ));
int CBD1	cfg_close CBD2(( int fd ));
int CBD1	cfg_flush CBD2(( int fd ));
int CBD1	cfg_setenv CBD2(( char *cfgfpath, char *group ));
int CBD1	cfg_getenv CBD2(( char *cfgfpath, char *group, char *envname,
                                                        char *envvalue ));
int CBD1	cfg_readgrp CBD2(( int fd, char *groupname, char *envbuf,
                                                                int CR_cnt ));
int CBD1	cfg_delgrp CBD2(( int fd, char *groupname ));
int CBD1	cfg_wrtgrp CBD2(( int fd, char *groupname, char *envbuf ));
int CBD1	cfg_readenv CBD2(( int fd, char *groupname, char *envname,
					char *envvalue, char *comment ));
int CBD1	cfg_delenv CBD2(( int fd, char *groupname, char *envname ));
int CBD1	cfg_wrtenv CBD2(( int fd, char *groupname, char *envname,
					char *envvalue, char *comment ));
int CBD1	cfg_scangrp CBD2(( int fd, char *groupname ));
int CBD1	cfg_nextgrp CBD2(( int fd, char *groupname ));
int CBD1	cfg_scanenv CBD2(( int fd, char *groupname, char *envname,
					char *envvalue, char *comment ));
int CBD1	cfg_nextenv CBD2(( int fd, char *groupname, char *envname,
					char *envvalue, char *comment ));
char * CBD1	hymsg( int withmsgid, char *groupname, char *modulename, char *msgid );
int CBD1	e_runpsts CBD2(( char *progname, char **args ));
int CBD1	e_runsyssts CBD2(( char *command ));

/* for 'COBOL' */
void CBD1	OD_ADJNDECIMAL CBD2(( char *, char *, int *, char * ));
void CBD1	OD_DECTOINT CBD2(( char *, int *, int *, char * ));
void CBD1	OD_FILLFORM CBD2(( char *, int *, char *, char *, int *,
                                                        char *, char * ));
void CBD1	OD_FMASK CBD2(( char *, int *, char *, char *, char *,
                                                                char * ));
void CBD1	OD_HANADJT CBD2(( char *, int *, char *, char * ));
void CBD1	OD_HEXTOINT CBD2(( char *, int *, int *, char * ));
void CBD1	OD_IMASK CBD2(( char *, int *, char *, char *, char *,
                                                                char * ));
void CBD1	OD_INT2NDEC CBD2(( unsigned int *, int *, char *, char * ));
void CBD1	OD_INTTODEC CBD2(( int *, int *, char *, char * ));
void CBD1	OD_INT2NHEX CBD2(( int *, int *, char *, char * ));
void CBD1	OD_INTTOHEX CBD2(( int *, int *, char *, char * ));
void CBD1	OD_ISSPACENSTR CBD2(( char *, int *, char * ));
void CBD1	OD_LEFTALIGN CBD2(( char *, int *, char *, char *, char * ));
void CBD1	OD_MKSTR CBD2(( char *, int *, char * ));
void CBD1	OD_MKSTRADD CBD2(( char *, char *, char *, int *, char * ));
void CBD1	OD_NDECTOINT CBD2(( char *, int *, int *, char * ));
void CBD1	OD_NSTRADD CBD2(( char *, char *, char *, int *, char * ));
void CBD1	OD_NSTRADD2 CBD2(( char *, int *, char *, int *, char *,
                                                        int *, char * ));
void CBD1	OD_RIGHTALIGN CBD2(( char *, int *, char *, char *, char * ));
void CBD1	OD_STRENDNULL CBD2(( char *, int *, int * ));
void CBD1	OD_STRSORT CBD2(( int *, int *, int *, int *, char *, char * ));
void CBD1	OD_UMASK CBD2(( char *, char *, int *, char *, char *,
                                                                char * ));
void CBD1	OD_STRNCAT CBD2(( char *, char *, int *, char * ));
void CBD1	OE_ALLDAYGET CBD2(( char *, char *, int *, char * ));
void CBD1	OE_CHKDATE CBD2(( char *, int *, char * ));
void CBD1	OE_DATE2JUL CBD2(( char *, char *, int *, char * ));
void CBD1	OE_DATECHK CBD2(( char *, char *, char * ));
void CBD1	OE_DATECMP CBD2(( char *, char *, char *, int * ));
void CBD1	OE_DUDATE CBD2(( int *, char *, char *, char *, char * ));
void CBD1	OE_FULLYEAR CBD2(( char *, char *, int *, char * ));
void CBD1	OE_GDATE2DATE CBD2(( char *, int *, long *, char * ));
void CBD1	OE_GDATE2YEAR CBD2(( char *, int *, long *, char * ));
void CBD1	OE_GDATEBYDU CBD2(( int *, char *, int *, int *, char *,
                                                        int *, char * ));
void CBD1	OE_GETENV CBD2(( char *, char *, int *, char * ));
void CBD1	OE_GETSYSTIME CBD2(( int *, char *, char *, char * ));
void CBD1	OE_GETWEEKDAY CBD2(( char *, char *, char * )); /*20000328*/
void CBD1	OE_GETYEAR CBD2(( int *, int *, char * ));
void CBD1	OE_GMONTBYDU CBD2(( int *, char *, int *, int *, char *,
                                                                char * ));
void CBD1	OE_GRE2JUL CBD2(( char *, int *, int *, char * ));
void CBD1	OE_JUL2DATE CBD2(( int *, char *, char *, char *, char * ));
void CBD1	OE_JUL2GRE CBD2(( int *, int *, char *, char *, char * ));
void CBD1	OE_LSTDAYGET CBD2(( char *, char *, char *, int *, char * ));
void CBD1	OE_NEXTDAY CBD2(( char *, char *, char *, char * ));
void CBD1	OE_NEXTMONTH CBD2(( char *, char *, char *, char * ));
void CBD1	OE_PREVDAY CBD2(( char *, char *, char *, char * ));
void CBD1	OE_PREVMONTH CBD2(( char *, char *, char *, char * ));
void CBD1	OE_RUNSYS CBD2(( char *, char * ));
void CBD1	OE_SLEEP0001 CBD2(( int * ));
void CBD1	OF_CHMOD CBD2(( char *, int *, char * ));
void CBD1	OF_CHOWN CBD2(( char *, char *, char * ));
void CBD1	OF_GETENV CBD2(( char *, char *, char *, int *, char * ));
void CBD1	OF_GETFPATH CBD2(( char *, char *, char *, char *, char * ));
void CBD1	OF_LOCK CBD2(( int *, char * ));
void CBD1	OF_LOCKWAIT CBD2(( int *, char * ));
void CBD1	OF_UNLOCK CBD2(( int *, char * ));
void CBD1	OF_TEMPNAM CBD2(( char *, char *, char * ));
void CBD1	OF_UNLINK CBD2(( char *, char * ));
/********** Added 1 line by YI, 990521 ****************************************/
void CBD1	OF_COPY CBD2(( char *, char *, char *, char * ));
/******************************************************************************/
void CBD1	OK_ACCEPTSTR CBD2(( char *, int * ));
void CBD1	OK_GETCHAR CBD2(( short * ));
void CBD1	OK_INPNNUMERIC CBD2(( char *, int * ));
void CBD1	OK_INPNSTRING CBD2(( char *, int * ));
void CBD1	OR_EXECPRG CBD2(( char *, short * ));
void CBD1	OR_RUNCONT CBD2(( char *, short * ));
void CBD1	OR_RUNWAIT CBD2(( char *, short * ));
void CBD1	OCFG_OPEN CBD2(( char *, char *, int *, char * ));
void CBD1	OCFG_CLOSE CBD2(( int *, char * ));
void CBD1	OCFG_FLUSH CBD2(( int *, char * ));
void CBD1	OCFG_SETENV CBD2(( char *, char *, char * ));
void CBD1	OCFG_GETENV CBD2(( char *, char *, char *, char *, char * ));
void CBD1	OCFG_READGRP CBD2(( int *, char *, char *, int *, char * ));
void CBD1	OCFG_DELGRP CBD2(( int *, char *, char * ));
void CBD1	OCFG_WRTGRP CBD2(( int *, char *, char *, char * ));
void CBD1	OCFG_READENV CBD2(( int *, char *, char *, char *, char *,
                                                                char * ));
void CBD1	OCFG_DELENV CBD2(( int *, char *, char *, char * ));
void CBD1	OCFG_WRTENV CBD2(( int *, char *, char *, char *, char *,
                                                                char * ));
void CBD1	OCFG_SCANGRP CBD2(( int *, char *, char * ));
void CBD1	OCFG_NEXTGRP CBD2(( int *, char *, char * ));
void CBD1	OCFG_SCANENV CBD2(( int *, char *, char *, char *, char *,
                                                                char * ));
void CBD1	OCFG_NEXTENV CBD2(( int *, char *, char *, char *, char *,
                                                                char * ));
void CBD1	OE_RUNSYSSTS CBD2(( char *, char *, char * ));

#ifdef	__cplusplus
}
#endif

#endif

/*----------------------------------------------------------------------*/
/* end of gps.h */
