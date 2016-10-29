/* odbapic.h */
/************************************************************************
*	All constant and structure to use ODBAPIC( for DBLINK/C )	*
*	HYUN & YOUNG SYSTEMS, INC. at 1997.10.1				*
************************************************************************/

#ifndef	__ODBAPIC_H__
#define	__ODBAPIC_H__

/*----------------------------------------------------------------------+
|	External Function Proto Type					|
+----------------------------------------------------------------------*/
#ifdef	__cplusplus
extern	"C"
{
#endif

#ifdef	WIN32
# ifdef		DELETE
#  undef	DELETE
# endif
#endif

/* for DBLINK/C */
void	CBD1	COMMIT	CBD2( ( char *dbsts ) );
void	CBD1	DBCLOS	CBD2( ( char *dbsts ) );
void	CBD1	DBOPEN	CBD2( ( char *pgid, char *dbid, char *dbsts, char *rowcnt, char *tranflag ) );
void	CBD1	DELETE	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts ) );
void	CBD1	INSERT	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts ) );
void	CBD1	READEQ	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts ) );
void	CBD1	READGE	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts, char *eqcnt ) );
void	CBD1	READGT	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts, char *eqcnt ) );
void	CBD1	READLE	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts, char *eqcnt ) );
void	CBD1	READLT	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts, char *eqcnt ) );
void	CBD1	READNX	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts, char *eqcnt ) );
void	CBD1	READPR	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts, char *eqcnt ) );
void	CBD1	ROLBAK	CBD2( ( char *dbsts ) );
void	CBD1	UPDATE	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts ) );
void	CBD1	UREDEQ	CBD2( ( char *dbid, char *tbidxid, char *buffer, char *dbsts ) );
void	CBD1	UDCOPN	CBD2( ( char *dbid, char *curname, char *dbsts, char *vcnt_str, char *sqltxt_buf, ... ) );
void	CBD1	UDCFET	CBD2( ( char *dbid, char *curname, char *dbsts ) );

#ifdef	__cplusplus
}
#endif

#endif	/* __ODBAPIC_H__ */

/****** The end of odbapic.h ********************************************/
