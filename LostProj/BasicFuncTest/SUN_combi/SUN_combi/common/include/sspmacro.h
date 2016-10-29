/* sspmacro.h */
/*----------------------------------------------------------------------*
| Descrip.	DLTP Application Program Header( SSPAPPL ) 		|
|									|
| Project	IEAP							|
| System	DLTP							|
|									|
| Date		96.12.16						|
|									|
| Included by	DLTPAPPL( SSPAPPL )					|
*-----------------------------------------------------------------------*/
#ifndef SSPMACRO_H
#define SSPMACRO_H

/*----------------------------------------------------------------------*/
/*  REDEFINE CONTROL DATA for EASY USE					*/
/*----------------------------------------------------------------------*/

#define	MYCLIID		TCA.cliid		/* char[8], current Client ID*/
#define	MYCLINAME	TCA.clinm		/* char[20], current Cli Name*/
#define	MYCLIKIND	TCA.clikind		/* char[1], current Cli Kind */
#define	MYCLIOS		TCA.clios		/* char[1], current Cli O/S  */
#define	TRACELEVEL	TCA.traceloglev		/* int, Trace Log Level	     */
#define	DATALEVEL	TCA.dataloglev		/* int, Data Log Level	     */

#define	MYASID		TCA.asid		/* char[32], current ASID    */
#define	MYASCFGPATH	TCA.ascfgpath		/* char[80], current ASCFG   */
#define	MYMAINHOSTID	TCA.mainhostid		/* char[1], current Main Server Host ID  */
#define	MYSPLOGPATH	TCA.splogpath		/* char[80], current log path*/

#define USERID		TCA.usid		/* char[8], User ID	     */
#define PASSWD		TCA.pswd		/* char[8], Password	     */
#define USERNAME	TCA.usnm		/* char[12], User Name	     */
#define GROUPID		TCA.ugrp		/* char[4], Group ID	     */
#define GROUPNAME	TCA.ugrpnm		/* char[20], Group Name	     */
#define LEVELID		TCA.ulev		/* char[1], Level ID	     */
#define LEVELNAME	TCA.ulevnm		/* char[20], Level Name	     */

#define SSNO		TCA.ssno		/* char[4], Session Number   */
#define PROTO		TCA.proto		/* char[1], Protocol	     */
#define LOGINMODE	TCA.loginmode		/* char[1], Login Mode	     */
#define PERSIST		TCA.persist		/* char[1], Sess. Persistency*/
#define CURHOSTID	TCA.hostid		/* char[1], Host ID	     */
#define CURPORTNO	TCA.portno		/* int, port number	     */
#define CURHOSTNAME	TCA.hostname		/* char[20], Host Name	     */
#define CURTXID		TCA.txid		/* char[8], TXID in Session  */
#define RUNTXID		TCA.runtxid		/* char[8], Running TXID     */
#define CURBIND		TCA.bind		/* char[1], 셰션접속모드     */
#define TRACELOGPATH	TCA.trclogpath		/* char[80], Trace Log Path  */
#define TRACELOGFD	TCA.trclogfd		/* int, Trace Log FD	     */

#define	SSLOGINTIME	TCA.sslogintm		/* time_t, Sess. Login Time  */
#define	TPSTARTTIME	TCA.tpstarttm		/* time_t, TP Start Time     */
#define	TXSTARTTIME	TCA.txstarttm		/* time_t, TX Start Time     */
#define	ULOGINTIME	TCA.ulogintm		/* time_t, User Login Time   */

/*----------------------------------------------------------------------*/
/* GENERAL MACRO FUNCTION						*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/* DLTP APPLICATION MACRO FUNCTION					*/
/*----------------------------------------------------------------------*/

#endif	/* SSPMACRO_H */

/*----------------------------------------------------------------------*/
/* end of sspmacro.h */
/*----------------------------------------------------------------------*/
