#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <usrinc/atmi.h>

main(int argc, char *argv[])
{
	char	*sndbuf, *rcvbuf;
	long	rcvlen, sndlen;
	int	ret;
	int     loop;
/*
	if (argc != 2) {
		printf("Usage: toupper string\n");
		exit(1);
	}
*/
	if ( (ret = tmaxreadenv( "tmax.env","TMAX" )) == -1 ){
		printf( "tmax read env failed\n" );
		exit(1);
	}

	if (tpstart((TPSTART_T *)NULL) == -1){
		printf("tpstart failed\n");
		exit(1);
	}

	if ((sndbuf = (char *)tpalloc("STRING", NULL, 0)) == NULL) {
		printf("sendbuf alloc failed !\n");
		tpend();
		exit(1);
	}

	if ((rcvbuf = (char *)tpalloc("STRING", NULL, 0)) == NULL) {
		printf("recvbuf alloc failed !\n");
		tpfree((char *)sndbuf);
		tpend();
		exit(1);
	}

	strcpy(sndbuf, "7902");
	loop = atoi(argv[1]);

        for( ret = 0; ret < loop; ret++){
	if(tpcall("FDLAAA", sndbuf, 0, &rcvbuf, &rcvlen, 0)==-1){
		printf("Can't send request to service [%d][%d]\n",tperrno,tpurcode);
		tpfree((char *)sndbuf);
		tpfree((char *)rcvbuf);
		tpend();
		exit(1);
	}

	printf("send data: %s\n", sndbuf);
	printf("recv data: %s\n", rcvbuf);
	}
	tpfree((char *)sndbuf);
	tpfree((char *)rcvbuf);
	tpend();
}
