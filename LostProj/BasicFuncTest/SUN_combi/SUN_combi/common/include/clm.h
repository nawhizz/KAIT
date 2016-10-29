/* clm.h */
/*----------------------------------------------------------------------*/
/* CLM	TABLE								*/
/*----------------------------------------------------------------------*/
#ifndef	CLM_H
#define	CLM_H

struct	CLM_INFO		/* 256 bytes			*/
{
	char	kind[ 1];	/*   1 'T'rial, 'R'egistered,	*/
				/*     'U'nlimited		*/
	int	clmsize;	/*   4 clmFORM size		*/
	int	tpmuser;	/*   4 dltp. 사용자 수		*/
	int	tpmins;		/*   4 dltp. 인스턴스 수	*/
	int	dbcuser;	/*   4 dbcenter	"		*/
	int	dbcins;		/*   4 dbcenter	"		*/
	int	webuser;	/*   4 combiweb	"		*/
	int	webins;		/*   4 combiweb	"		*/
	char	version[ 8];	/*   8 ##.### null term.	*/
	char	setupdate[ 8];	/*   8 설치 일자		*/
	char	updatedate[ 8];	/*   8 수정 일자		*/
	char	ieaphome[128];	/* 128 combi home		*/
	int	n_date;		/*   4 Trial 인경우 사용 날짜	*/
#ifdef	WIN32
	char	hostid[39];	/*  39 HW PROFILE GUID		*/
	char	filler[28];	/*  32 filler			*/
#else
	char	hostid[18];	/*  18 서버 고유 id		*/
	char	filler[49];	/*  53 filler			*/
#endif
};

#define	CLM_SIZE	sizeof(struct CLM_INFO)

#endif /* CLM_H */
