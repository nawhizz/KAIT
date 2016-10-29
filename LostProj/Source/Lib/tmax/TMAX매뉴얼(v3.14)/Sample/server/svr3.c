#include <stdio.h>
#include <usrinc/atmi.h>
#include <usrinc/fbuf.h>
#include "../fdl/demo_fdl.h"


FDLTOUPPER(TPSVCINFO *msg)
{
	int		i;
	char	rdata[100];
	FBUF	*stdata;

	stdata=(FBUF *)msg->data;
	memset(rdata, 0x00, sizeof(rdata));

	printf("FDLTOUPPER service is started!\n");

	if (fbget(stdata, INPUT, rdata, 0) == -1){
		printf("fbget failed errno = %d\n", fberror);
	}

	printf("INPUT : data=%s\n", rdata);

	for (i = 0; rdata[i]; i++)
		rdata[i] = toupper(rdata[i]);

	printf("OUTPUT: data=%s\n", rdata);

	if (fbput(stdata, OUTPUT, rdata, 0) == -1)
		printf("fbput failed\n");
	

	tpreturn(TPSUCCESS, 9, (char *)stdata, 0, 0);
}


FDLTOLOWER(TPSVCINFO *msg)
{
	int		i;
	char	rdata[100];
	FBUF	*stdata;

	stdata=(FBUF *)msg->data;
	memset(rdata, 0x00, sizeof(rdata));

	printf("FDLTOLOWER service is started!\n");

	if (fbget(stdata, INPUT, rdata, 0) == -1){
		printf("fbget failed errno = %d\n", fberror);
	}

	printf("INPUT : data=%s\n", rdata);

	for (i = 0; rdata[i]; i++)
		rdata[i] = tolower(rdata[i]);

	printf("OUTPUT: data=%s\n", rdata);

	if (fbput(stdata, OUTPUT, rdata, 0) == -1){ 
		printf("fbput failed\n");
	}

	tpreturn(TPSUCCESS, 9, (char *)stdata, 0, 0);
}
