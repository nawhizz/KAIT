/************************************************************************
*	1. FILE    NAME : finfo						*
*	2. PREFIX	: finfo			210  BYTES		*
*	3. SYSTEM	: ISAM						*
*	4. DATE 	: 1998. 12. 30. 				*
*	5. REMASK	: Combi Server version manage data		*
************************************************************************/

#ifndef FINFO_H
#define FINFO_H

struct	finfoFORM	{		/*				210 */
	char	fname	[20];		/* file name			  0 */
	char	fpath	[128];		/* file path			 20 */
	char	dnpath	[60];		/* file path of down host	148 */
	char	compress[ 1];		/* compress kind		208
					   'a' : arj
					   'z' : zip
					   'l' : lha
					   ' ' : none
					*/
	char	ftype	[ 1];		/* file type			209
					   'T' : text
					   'B' : binary
					*/
	char	verid	[14];
};

#endif

/************************************************************************
*	The End of Header	finfo.h					*
************************************************************************/
