/* sdbapi.h */
/************************************************************************
*	All constant and structure to use SDBAPI			*
*	HYUN & YOUNG SYSTEMS, INC. at 1997.10.1				*
************************************************************************/

#ifndef	__SDBAPI_H
#define	__SDBAPI_H

#include	"cbuni.h"

/*	JJH ADD 2000.06.07	*/
#ifndef	__I_HVAR_INF__
#define	__I_HVAR_INF__
struct	I_HVAR_INF
{
	char	*var_ptr;	/* address of host variable buffer	*/
	int	var_length;	/* length of host variable buffer	*/
	int	var_pre;	/* pre.length of host variable	*/
	short	var_scale;	/* scale length of host variable	*/
	char	var_type;	/* type of host variable	*/
};
#endif

struct	I_CS_INF
{
	char	cs_used;
	char	cs_name[71 + 1];
};
/*	JJH ADD 2000.06.07	*/

/*----------------------------------------------------------------------+
|	External Function Proto Type					|
+----------------------------------------------------------------------*/
#ifdef	__cplusplus
extern	"C"
{
#endif

/* for C */
int	CBD1	dcbegin		CBD2(( void ));
int	CBD1	dcclose		CBD2(( void ));
int	CBD1	dccommit	CBD2(( void ));
int	CBD1	dcdelete	CBD2(( char *dbid, char *tbid, char *idxid, char *buffer ));
int	CBD1	dcdrpdb		CBD2(( char *dbid ));
int	CBD1	dcdrpix		CBD2(( char *dbid, char *tbid, char *idxid ));
int	CBD1	dcdrpsp		CBD2(( char *spaceid ));
int	CBD1	dcdrptb		CBD2(( char *dbid, char *tbid ));
int	CBD1	dcexec		CBD2(( char *dbid, char *sqlid, char *buffer ));
int	CBD1	dcexecnb	CBD2(( char *dbid, char *sqlid ));
int	CBD1	dcexfet		CBD2(( char *dbid, char *sqlid, char *buffer ));
int	CBD1	dcfetch		CBD2(( char *dbid, char *sqlid, char *buffer ));
int	CBD1	dcgendb		CBD2(( char *dbid ));
int	CBD1	dcgenix		CBD2(( char *dbid, char *tbid, char *idxid ));
int	CBD1	dcgenixa	CBD2(( char *dbid, char *tbid ));
int	CBD1	dcgensp		CBD2(( char *spaceid ));
int	CBD1	dcgentb		CBD2(( char *dbid, char *tbid ));
int	CBD1	dcinsert	CBD2(( char *dbid, char *tbid, char *buffer ));
int	CBD1	dclockrd	CBD2(( char *dbid, char *tbid, char *idxid, char *buffer ));
int	CBD1	dcopen		CBD2(( char *pgid ));
int	CBD1	dcprecommit	CBD2(( void ));
int	CBD1	dcrollback	CBD2(( void ));
int	CBD1	dcseleq		CBD2(( char *dbid, char *tbid, char *idxid, char *buffer ));
int	CBD1	dcselge		CBD2(( char *dbid, char *tbid, char *idxid, int eqcnt, char *buffer ));
int	CBD1	dcselgt		CBD2(( char *dbid, char *tbid, char *idxid, int eqcnt, char *buffer ));
int	CBD1	dcselle		CBD2(( char *dbid, char *tbid, char *idxid, int eqcnt, char *buffer ));
int	CBD1	dcsellt		CBD2(( char *dbid, char *tbid, char *idxid, int eqcnt, char *buffer ));
int	CBD1	dcselnx		CBD2(( char *dbid, char *tbid, char *idxid, char *buffer ));
int	CBD1	dcselpr		CBD2(( char *dbid, char *tbid, char *idxid, char *buffer ));
int	CBD1	dcupdate	CBD2(( char *dbid, char *tbid, char *idxid, char *buffer ));
int	CBD1	dcerrmsg	CBD2(( char *msgstr, int msglen ));
/*	2000.02.07 JJH ADD( start )	*/
int	CBD1	dcgenusr	CBD2(( char *userid, char *dlid, char *ausid ));
int	CBD1	dcdrpusr	CBD2(( char *userid, char *dlid, char *ausid ));
/*	2000.02.07 JJH ADD( end )	*/
/*	JJH ADD 2000.06.07	*/
int	CBD1	dcudcopn	CBD2(( char *dbid, char *curname, char *sqltxt_buf, int vcnt, struct I_HVAR_INF *i_hvarinf ));
int	CBD1	dcudcfet	CBD2(( char *dbid, char *curname ));
/*	JJH ADD 2000.06.07	*/
/* for COBOL */
void	CBD1	ODCBEGIN	CBD2(( char *DBSTS ));
void	CBD1	ODCCLOSE	CBD2(( char *DBSTS ));
void	CBD1	ODCCOMMIT	CBD2(( char *DBSTS ));
void	CBD1	ODCDELETE	CBD2(( char *DBID, char *TBID, char *IDXID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCDRPDB	CBD2(( char *DBID, char *DBSTS ));
void	CBD1	ODCDRPIX	CBD2(( char *DBID, char *TBID, char *IDXID, char *DBSTS ));
void	CBD1	ODCDRPSP	CBD2(( char *SPACEID, char *DBSTS ));
void	CBD1	ODCDRPTB	CBD2(( char *DBID, char *TBID, char *DBSTS ));
void	CBD1	ODCEXEC		CBD2(( char *DBID, char *SQLID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCEXECNB	CBD2(( char *DBID, char *SQLID, char *DBSTS ));
void	CBD1	ODCEXFET	CBD2(( char *DBID, char *SQLID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCFETCH	CBD2(( char *DBID, char *SQLID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCGENDB	CBD2(( char *DBID, char *DBSTS ));
void	CBD1	ODCGENIX	CBD2(( char *DBID, char *TBID, char *IDXID, char *DBSTS ));
void	CBD1	ODCGENIXA	CBD2(( char *DBID, char *TBID, char *DBSTS ));
void	CBD1	ODCGENSP	CBD2(( char *SPACEID, char *DBSTS ));
void	CBD1	ODCGENTB	CBD2(( char *DBID, char *TBID, char *DBSTS ));
void	CBD1	ODCINSERT	CBD2(( char *DBID, char *TBID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCLOCKRD	CBD2(( char *DBID, char *TBID, char *IDXID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCOPEN		CBD2(( char *PGID, char *DBSTS ));
void	CBD1	ODCPRECOMMIT	CBD2(( char *DBSTS ));
void	CBD1	ODCROLLBACK	CBD2(( char *DBSTS ));
void	CBD1	ODCSELEQ	CBD2(( char *DBID, char *TBID, char *IDXID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCSELGE	CBD2(( char *DBID, char *TBID, char *IDXID, int *EQCNT, char *BUFFER, char *DBSTS ));
void	CBD1	ODCSELGT	CBD2(( char *DBID, char *TBID, char *IDXID, int *EQCNT, char *BUFFER, char *DBSTS ));
void	CBD1	ODCSELLE	CBD2(( char *DBID, char *TBID, char *IDXID, int *EQCNT, char *BUFFER, char *DBSTS ));
void	CBD1	ODCSELLT	CBD2(( char *DBID, char *TBID, char *IDXID, int *EQCNT, char *BUFFER, char *DBSTS ));
void	CBD1	ODCSELNX	CBD2(( char *DBID, char *TBID, char *IDXID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCSELPR	CBD2(( char *DBID, char *TBID, char *IDXID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCUPDATE	CBD2(( char *DBID, char *TBID, char *IDXID, char *BUFFER, char *DBSTS ));
void	CBD1	ODCERRMSG	CBD2(( char *MSGSTR, int *MSGLEN, char *DBSTS ));
/*	2000.02.07 JJH ADD( start )	*/
void	CBD1	ODCGENUSR	CBD2(( char *USERID, char *DLID, char *AUSID, char *DBSTS ));
void	CBD1	ODCDRPUSR	CBD2(( char *USERID, char *DLID, char *AUSID, char *DBSTS ));
/*	2000.02.07 JJH ADD( end )	*/
/*	JJH ADD 2000.06.07	*/
void	CBD1	ODCUDCOPN	CBD2(( char *DBID, char *CURNAME, char *SQLTXT_BUF, int *VCNT, struct I_HVAR_INF *I_HVAR_INF, char *DBSTS ));
void	CBD1	ODCUDCFET	CBD2(( char *DBID, char *CURNAME, char *DBSTS ));
/*	JJH ADD 2000.06.07	*/
void	CBD1	dao_ret		CBD2(( int errnum, char *dbsts ));

#ifdef	__cplusplus
}
#endif

/*----------------------------------------------------------------------+
|	Error code							|
+----------------------------------------------------------------------*/
#define	EDC_API_INVAL_ARG		-70700
#define EDC_API_CMDERR			-70705
#define EDC_API_INVAL_RECSIZE		-70706
#define	EDC_API_MSGBUF_EMPTY		-70707
#define	EDC_API_TMPOPN_EACCES		-70710
#define	EDC_API_TMPOPN_EFAULT		-70711
#define	EDC_API_TMPOPN_EINTR		-70712
#define	EDC_API_TMPOPN_EDQUOT		-70713
#define	EDC_API_TMPOPN_EISDIR		-70714
#define	EDC_API_TMPOPN_EMFILE		-70715
#define	EDC_API_TMPOPN_ENFILE		-70716
#define	EDC_API_TMPOPN_ENOSPC		-70717
#define	EDC_API_TMPOPN_ERROR		-70718
#define	EDC_API_MMAP_ENOMEM		-70719
#define	EDC_API_MMAP_ERROR		-70720
#define EDC_API_TABLE_RQI		-70725
#define EDC_API_ALREADYOPEN		-70730
#define EDC_API_NOTOPEN			-70731
#define EDC_API_ALREADYSTART_TRAN	-70735
#define EDC_API_NOTSTART_TRAN		-70736
#define EDC_API_NOW_TRAN_ACT		-70737
#define EDC_API_NOGEN_SPACE		-70740
#define EDC_API_NOGEN_DB		-70741
#define EDC_API_NOGEN_TABLE		-70742
#define EDC_API_NOGEN_INDEX		-70743
#define EDC_API_ALREADYGEN_SPACE	-70745
#define EDC_API_ALREADYGEN_DB		-70746
#define EDC_API_ALREADYGEN_TABLE	-70747
#define EDC_API_ALREADYGEN_INDEX	-70748
#define EDC_API_NOTNEEDGEN_INDEX	-70749
#define EDC_API_INVAL_PKTNO_CONN	-70750
#define EDC_API_INVAL_PKTNO_CAN		-70751
#define EDC_API_INVAL_PKTNO_RECV	-70752
#define EDC_API_INVAL_PKTNO_SELEQ	-70753
#define EDC_API_INVAL_PKTNO_SELGE	-70754
#define EDC_API_INVAL_PKTNO_SELGT	-70755
#define EDC_API_INVAL_PKTNO_SELNX	-70756
#define EDC_API_INVAL_PKTNO_SELLE	-70757
#define EDC_API_INVAL_PKTNO_SELLT	-70758
#define EDC_API_INVAL_PKTNO_SELPR	-70759
#define EDC_API_INVAL_PKTNO_LOCKRD	-70760
#define EDC_API_INVAL_PKTNO_EXFET	-70761
#define EDC_API_INVAL_PKTNO_FETCH	-70762
#define EDC_API_INVAL_PKTNO_SAVE	-70763
#define EDC_API_TOOMANY_DBOPEN		-70770
#define	EDC_API_NOTFIND_DBINF		-70771
#define	EDC_API_TOOMANY_DLCONN		-70772
#define	EDC_API_NOTFIND_DLINF		-70773
#define	EDC_API_NOTFIND_DNINF		-70774
#define EDC_API_TOOMANY_SERVER		-70775
#define EDC_API_EXIST_WAIT_SERVER	-70776
#define EDC_API_NO_IDLESERVER		-70777
#define EDC_API_NO_USER_IDLESERVER	-70778
#define	EDC_API_SHMGET_EACCES		-70780
#define	EDC_API_SHMGET_ENOSPC		-70782
#define	EDC_API_SHMGET_ENOMEM		-70783
#define	EDC_API_SHMGET_ERROR		-70785
#define	EDC_API_SHMATT_EACCES		-70786
#define	EDC_API_SHMATT_EMFILE		-70787
#define	EDC_API_SHMATT_ENOMEM		-70788
#define	EDC_API_SHMATT_ERROR		-70789
#define	EDC_API_BADDATA_SPACE		-70790
#define	EDC_API_BADDATA_DB		-70791
#define	EDC_API_BADDATA_TABLE		-70792
#define	EDC_API_BADDATA_INDEX		-70793
#define	EDC_API_BADDATA_SQL		-70794
#define	EDC_API_SERVER_DEAD		-70795
#define	EDC_API_NOT_RUN_MODE		-70796
#define	EDC_API_NOTFIND_SQLINF		-70799
#define	EDC_API_NO_SQL			-70721
#define	EDC_API_NOMORE_MEM		-70722
#define	EDC_API_NOTFIND_TBINF		-70723
#define	EDC_API_NO_TABLE		-70724
#define	EDC_API_TOOMANY_DBNETCONN	-70726
#define	EDC_API_DBNET_NOT_SUPPORT	-70727
#define	EDC_API_DBNET_DEAD		-70728
#define	EDC_API_INVAL_PKTNO_GETTBLST	-70729
#define	EDC_API_INVAL_PKTNO_GETSQLST	-70732
#define	EDC_API_NET_COMM_ERROR		-70733
/*	2000.02.07 JJH ADD( start )	*/
#define	EDC_API_BADDATA_USER		-70764
#define EDC_API_ALREADYGEN_USER		-70765
#define EDC_API_NOGEN_USER		-70766
/*	2000.02.07 JJH ADD( end )	*/
#define EDC_API_TOOMANY_CURSOR		-70767
#define EDC_API_HVAR_INF_MALLOC_ERR	-70768
#define EDC_API_NOTFOUND_CURSOR		-70769
#define EDC_API_UDCBUF_OVERFLOW		-70734

#endif	/* SDBAPI_H */

/****** The end of sdbapi.h ********************************************/
