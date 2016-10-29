/* stpmacro.h */
/*----------------------------------------------------------------------*
| Descrip.	DLTP Application Program Header 			|
|									|
| Project	HYCASE							|
| System	DLTP							|
|									|
| Date		93.3.7 / 96.2.23					|
|									|
| Included by	DLTPAPPL						|
*-----------------------------------------------------------------------*/
#ifndef STPMACRO_H
#define STPMACRO_H

/*----------------------------------------------------------------------*/
/*  REDEFINE CONTROL DATA for EASY USE					*/
/*----------------------------------------------------------------------*/

#define	MYCLIID		TCA.cliid		/* char[8], current Client ID*/
#define	MYCLINAME	TCA.clinm		/* char[20], current Cli Name*/
#define	MYCLIKIND	TCA.clikind		/* char[1], current Cli Kind */

#define TERMID		TCA.termid		/* char[8], Terminal ID	     */
#define CLIHOSTNAME	TCA.clihostnm		/* char[16], Client Host Name*/
#define TPSTARTTM	TCA.tpstarttm		/* long, Client Host Name    */
#define SERVERPID	TCA.svpid		/* int, Server Process ID    */

#define	MYASID		TCA.asid		/* char[32], current ASID     */
#define	MYASHOME	TCA.ashome		/* char[80], current ASHOME  */
#define	MYASCFG		TCA.ascfg		/* char[80], current ASCFG   */
#define	MYHOSTID	TCA.myhostid		/* char[1], current Host ID  */
#define	MYTXCNTL	TCA.txcntl		/* char[80], current TXCNTL  */
#define	MYUSERCNTL	TCA.usercntl		/* char[80], current USERCNTL*/
#define	MYTXAPPL	TCA.txappl		/* char[80], current TXAPPL  */
#define	MYCUROWN	TCA.myowner		/* char[16], current MYOWNER */
#define	MYOWNID		TCA.myownid		/* int, current OWNER ID     */
#define	MYGRPID		TCA.mygrpid		/* int, current GROUP ID     */

#define USERID		TCA.usid		/* char[8], User ID	     */
#define USERNAME	TCA.usnm		/* char[12], User Name	     */
#define GROUPID		TCA.ugrp		/* char[4], Group ID	     */
#define GROUPNAME	TCA.ugrpnm		/* char[20], Group Name	     */
#define LEVELID		TCA.ulev		/* char[1], Level ID	     */
#define LEVELNAME	TCA.ulevnm		/* char[20], Level Name	     */
#define ULOGINTIME	TCA.ulogintm		/* long, User Login Time     */

#define CURTXID		TCA.txid		/* char[8], current TXID     */
#define CURPGID		TCA.pgid		/* char[8], current PGID     */
#define CURPGPATH	TCA.pgfpath		/* char[80], current PGID    */

/* 97.01.30  JJH DELETE  */
/* #define XCTLTXID	TCA.xctltxid	*/	/* char[8], XCTL하고싶은 TXID*/
			/* => 프로그램 종료시 SET하면 해당프로그램을 실행함  */

/**** 삭제할 예정임 961111 YI.
#define	RCVFROMSVRFD	TCA.rcvfromsvrfd
					 * int, receive pipe fd from server  *
#define	SNDTOSVRFD	TCA.sndtosvrfd
					 * int, send pipe fd from server     *
******* 여기까지 ****/
#define	TXSTARTTIME	TCA.txstarttm		/* long, TX Start Time	     */
#define	CURAPPLID	TCA.appid		/* int, appl. process ID     */

/*----------------------------------------------------------------------*/
/* GENERAL MACRO FUNCTION						*/
/*----------------------------------------------------------------------*/
/* binary 값 비교 */
#define LESSER(a,b)	(a<b?a:b)
#define GREATER(a,b)	(a<b?b:a)

/* string 비교 */
#define ISSAME(s,d)	(!strncmp(s,d,GREATER(sizeof(s),sizeof(d))))
#define ISSPACE(s)	d_isspacenstr(s,sizeof(s))
#define ISSPACENSTR(s,n) d_isspacenstr(s,n)

/* string copy */
#define MOVE(s,d)	strncpy(d,s,LESSER(sizeof(s),sizeof(d)))
#define MOVESTR(s,d)	strncpy(d,s,LESSER(strlen(s),sizeof(d)))
#define FILLDATA(s,c)	memset(  (char *)s, c, sizeof(s))
#define FILLSPACE(d)	memset( (char *)d,' ',sizeof(d))
#define FILLZERO(d)	memset( (char *)d,'0',sizeof(d))
#define FILLNULL(d)	memset( (char *)d,'\0',sizeof(d))

/* STRUCTURE handling */
#define STRUCTSPACE(s)	memset( (char*)&s, ' ', sizeof(s) )
#define STRUCTZERO(s)	memset( (char*)&s, '0', sizeof(s) )
#define STRUCTNULL(s)	memset( (char*)&s, 0, sizeof(s) )

/*----------------------------------------------------------------------*/
/* DLTP APPLICATION MACRO FUNCTION					*/
/*----------------------------------------------------------------------*/

#endif	/* STPMACRO_H */

/*----------------------------------------------------------------------*/
/* end of stpmacro.h */
/*----------------------------------------------------------------------*/
