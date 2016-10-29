/* odbapio.h */
/************************************************************************
*	All constant and structure to use ODBAPIO( for DBLINK/COBOL )	*
*	HYUN & YOUNG SYSTEMS, INC. at 1997.10.1				*
************************************************************************/

#ifndef	__ODBAPIO_H__
#define	__ODBAPIO_H__

#define	EQCNT_NLEN	2

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

/* for DBLINK/COBOL */
void	CBD1	COMMIT	CBD2( ( char *DBSTS ) );
void	CBD1	DBCLOS	CBD2( ( char *DBSTS ) );
void	CBD1	DBOPEN	CBD2( ( char *PGID, char *DBID, char *DBSTS, char *ROWCNT, char *TRANFLAG ) );
void	CBD1	DELETE	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS ) );
void	CBD1	INSERT	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS ) );
void	CBD1	READEQ	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS ) );
void	CBD1	READGE	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS, char *EQCNT ) );
void	CBD1	READGT	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS, char *EQCNT ) );
void	CBD1	READLE	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS, char *EQCNT ) );
void	CBD1	READLT	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS, char *EQCNT ) );
void	CBD1	READNX	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS, char *EQCNT ) );
void	CBD1	READPR	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS, char *EQCNT ) );
void	CBD1	ROLBAK	CBD2( ( char *DBSTS ) );
void	CBD1	UPDATE	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS ) );
void	CBD1	UREDEQ	CBD2( ( char *DBID, char *TBIDXID, char *BUFFER, char *DBSTS ) );
void	CBD1	UDCOPN	CBD2( ( char *DBID, char *CURNAME, char *DBSTS, char *VCNT_STR, char *SQLTXT_BUF, ... ) );
void	CBD1	UDCFET	CBD2( ( char *DBID, char *CURNAME, char *DBSTS ) );

#ifdef	__cplusplus
}
#endif

#endif	/* __ODBAPIO_H__ */

/****** The end of odbapio.h ********************************************/
