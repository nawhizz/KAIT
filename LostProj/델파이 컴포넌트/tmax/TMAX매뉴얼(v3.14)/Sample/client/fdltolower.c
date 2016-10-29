#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <usrinc/atmi.h>
#include <usrinc/fbuf.h>		
#include "../fdl/demo_fdl.h"


main(int argc, char *argv[])
{
	FBUF	*sndbuf, *rcvbuf;
	int 	fc, fg, ret;
	char	sndata[30],	rcvdata[30];
	char 	input[10], outdata[10];
	long	sndlen, rcvlen;


	if (argc != 2) {
		printf("Usage: fdltolower string\n");
		exit(1);
	}

	if ( (ret = tmaxreadenv( "tmax.env","TMAX" )) == -1 ){
		printf( "tmax read env failed\n" );
		exit(1);
	}


	if (tpstart((TPSTART_T *)NULL) == -1){
		printf("tpstart failed\n");
		exit(1);
	}

	if ((sndbuf = (FBUF *)tpalloc("FIELD", NULL, 0)) == NULL) {
		printf("tpalloc failed! errno = %d\n", tperrno);
		tpend();
		exit(1);
	}
	if ((rcvbuf = (FBUF *)tpalloc("FIELD", NULL, 0)) == NULL) {
		printf("tpalloc failed! errno = %d\n", tperrno);
		tpfree((char *)sndbuf);
		tpend();
		exit(1);
	}

	strcpy(input, "INPUT");
	strcpy(sndata, argv[1]);
	fc = fbput(sndbuf, fbget_fldkey(input), sndata, 0);

	if (tpcall("FDLTOLOWER", (char *)sndbuf, 0, (char **)&rcvbuf, &rcvlen, 0) == -1) {
		printf("tpcall failed! errno = %d\n", tperrno);
		tpfree((char *)sndbuf);
		tpfree((char *)rcvbuf);
		tpend();
		exit(1);
	}

	strcpy(outdata, "OUTPUT");
	fg = fbget(rcvbuf, fbget_fldkey(outdata), rcvdata, 0);
	fbprint(rcvbuf);
	
	tpfree((char *)sndbuf);
	tpfree((char *)rcvbuf);
	tpend();
}
