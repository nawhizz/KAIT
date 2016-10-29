/* apcom.x */
/************************************************************************
*									*
*	Descrip.	Client / Server xmit data layout header		*
*									*
*	Project		COMBI						*
*	System		combi tool					*
*									*
*	Date		97.10.1						*
*									*
************************************************************************/

#ifndef APCOM_X
#define APCOM_X

/* communicaton packet size <= 8000 bytes */
/* command layout size < communication packet size */

#define	PKTDATASIZE		7999

#define CMD_CSCA		'A'
#define CMD_SETCURSOR		'C'
#define CMD_DISPDATA		'D'
#define CMD_ERRENDOFAPPL	'E'
#define CMD_FLUSHSCREEN		'F'
#define CMD_CLEARDATA		'G'
#define CMD_GETOBJECT		'J'
#define CMD_DISPMSG		'M'
#define CMD_EDITOBJECT		'O'
#define CMD_PRINTOUT		'P'
#define CMD_RECVFILE		'R'
#define CMD_SENDFILE		'S'
#define CMD_ENDOFAPPL		'T'
#define CMD_USERCMD		'U'
#define CMD_EXECPCPGM		'X'

/* option for PRINT */
#define	PRTDATASIZE	PKTDATASIZE-1
#define	PRT_PAGE	'P'		
#define	PRT_SEGDATA	'S'
#define	PRT_ACK		'A'
#define	PRT_NACK	'N'
#define	PRT_START	'T'
#define	PRT_CONTINUE	'C'
#define	PRT_END		'X'

/* Client/Server communication packet : size (8000 bytes) */
struct	SENDDATA_TYPE	{
	char	cmd[1];
	char	data[PKTDATASIZE];
};

/* Client, Server Command Layout */
struct	DISPMSG_TYPE	{
	char	msgtype[1];
	char	msgid[8];
	char	msgstr[100];
};

struct	SETCURSOR_TYPE	{
	char	fieldnum[4];
};

struct	SENDFILE_TYPE	{
	char	ftype[1];
	char	compress[1];
	char	fpath[100];
};

struct	RECVFILE_TYPE	{
	char	overwrite[1];
	char	fpath[100];
};

struct	EDITOBJECT_TYPE	{
	char	job[1];
	char	objtype[2];
	char	objname[8];
};

struct	GETOBJECT_TYPE	{
	char	objtype[2];
};

struct	EXECPCPGM_TYPE	{
	char	type[1];
	char	cmdstr[100];
};

struct	PRTDATA_TYPE	{
	char	opt[1];			/* PRINT option : P/S/A/N/T/C/X */
	char	data[PRTDATASIZE];	/* PRINT DATA */
};

struct	PRT_ACK_TYPE	{
	char	ack[1];		/* PRINT result : 'S'uccess/'F'ail */
};

#endif	/* APCOM_X */

/******* The end of apcom.x ********************************************/
