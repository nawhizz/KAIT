#include <stdio.h>
#include <ctype.h>
#include <usrinc/atmi.h>	
#include <usrinc/fbuf.h>
#include "../fdl/demo_fdl.h"

EXEC SQL include sqlca.h;

exec sql begin declare section;
    int    col1;
    int    col2;
exec sql end declare section;
/*
FEBISSVC(TPSVCINFO *msg)
{
	FBUF *sndbuf;
	char tmpbuf[256];	
	int  i,loop;

	loop = atoi(msg->data);

	fprintf(stderr, "loop ---> [%d]\n", loop);

	if ((sndbuf = (FBUF *)tpalloc("FIELD",0,1000*3000)) == NULL){
		fprintf(stderr, "sndbuf tpalloc failed[%d]\n",tperrno);
		tpreturn(TPFAIL, -1, NULL, 0, 0);
	}
	for( i=0; i< loop; i++){
		memset(tmpbuf, 0x00, sizeof(tmpbuf));	
		sprintf(tmpbuf, "[%d]%s",i,"th data" );
		fprintf(stderr, "tmpbuf---> [%s]\n",tmpbuf);
		fbput( sndbuf, FML_1, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_2, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_3, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_4, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_5, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_6, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_7, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_8, (char *)tmpbuf, 0 );
		fbput( sndbuf, FML_9, (char *)tmpbuf, 0 );
	}	
	tpreturn(TPSUCCESS, 0, (char *)sndbuf, 0, 0);	
}
*/
FEBISSVC(TPSVCINFO *msg)
{

	char *rcvbuf;
	long rlen;

	col1 = atoi(msg->data);
	col2 = col1 + 100;

	EXEC SQL insert into test values( :col1,:col2);

	if (sqlca.sqlcode != 0) 
		tpreturn(TPFAIL,sqlca.sqlcode, NULL, 0, 0);

/*
	rcvbuf = tpalloc("STRING", NULL, 0);

	if (tpcall("TESTSVC2", msg->data, 0, &rcvbuf, &rlen, 0) <0){
		fprintf(stdout, "MEMTESTNXA service tpcall failed[%d]\n",tperrno );
		tpreturn(TPFAIL,sqlca.sqlcode, NULL, 0, 0);
	}
	if (tpcall("MEMTESTNXA", msg->data, 0, &rcvbuf, &rlen, 0) <0){
		fprintf(stdout, "MEMTESTNXA service tpcall failed[%d]\n",tperrno );
		tpreturn(TPFAIL,sqlca.sqlcode, NULL, 0, 0);
	}
*/
	tpreturn(TPSUCCESS, 0, NULL, 0, 0);			
}

TESTSVC1(TPSVCINFO *msg)		
{
    char *msgdata;
    int  ins_count, i;
    long lsndlen, lrcvlen;
    char return_val[10];

    col1 = atoi(msg->data);
    col2 = col1 + 200;

    printf("testsvr1 : col2 [%d] \n", col2);

    tx_begin();

    EXEC SQL 
    INSERT INTO test VALUES (:col1,:col2);

    if (sqlca.sqlcode != 0){
        printf("update error sqlerror=%d",sqlca.sqlcode);
        tpreturn(TPFAIL, sqlca.sqlcode, (char *)NULL, 0, 0);
    }

    if (tpcall( "TESTSVC2", msg->data, 0, (char **)&msg->data, (long *)&lrcvlen, 0) < 0){
        printf("tpcall TESTSVC2=%d, %d",tperrno, tpurcode);
	tx_rollback();
        tpreturn(TPFAIL, tpurcode, (char *)NULL, 0, 0);
    }
    sleep(30);
    tx_commit();
	
    tpreturn(TPSUCCESS, 1000, (char *)NULL, 0, 0);
}
tpsvctimeout(TPSVCINFO *msg)
{
	if(sqldone() == -439)
        {
            printf("[%s] TIMEOUT : SQLCODE[%d] ISAMERR[%d] SqlBreakCode[%d]\n",msg->name ,sqlca.sqlcode,sqlca.sqlerrd[1],sqlbreak());
        }
        else {
            printf("[%s] TIMEOUT : SQLCODE[%d] ISAMERR[%d]\n",msg->name ,sqlca.sqlcode,sqlca.sqlerrd[1]);
            tpreturn(TPFAIL, -1, (char *)msg->data, 0, 0);
        }

/*
	tpreturn(TPEXIT, -444, (char *)NULL, 0, 0);
*/
}


