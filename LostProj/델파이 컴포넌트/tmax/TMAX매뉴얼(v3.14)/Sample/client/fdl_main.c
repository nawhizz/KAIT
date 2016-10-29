#include <stdio.h>
#include <stdlib.h>
#include <usrinc/atmi.h>
#include <usrinc/fbuf.h>
#include "../fdl/demo_fdl.h"

int print_main();
int fdl_ins();
int fdl_sel();
int fdl_upt();
int fdl_del();

struct temp_str{
	int   empno;
	char  ename[11];
	char  job[10];
	int   mgr;
	char  date[11];
	float sal;
	float comm;
	int   deptno;
};
typedef struct temp_str *str;

main()
{
	int    in_num;
	int    ret;
	FBUF   *sndbuf, *rcvbuf;
	long   rcvlen;


	if ((ret = tmaxreadenv("tmax.env","TMAX")) == -1) {
		printf( "tmax read env failed\n" );
		exit(1);
	}

	in_num = print_main();	
	
	if ( in_num == 0 ){
		printf( "This Program is Over..... Bye Bye\n" );
		exit(0);
	}

	if ( tpstart((TPSTART_T *)NULL) == -1 ){
		printf( "tpstart failed[%s]\n",tpstrerror(tperrno));	
		exit(1);
	}

	if ((sndbuf = (FBUF *)tpalloc("FIELD",NULL,0)) == NULL){
		printf( "sndbuf tpalloc failed[%s]\n",tpstrerror(tperrno));
		tpend();
		exit(1);
	}	
	if ((rcvbuf = (FBUF *)tpalloc("FIELD",NULL,0)) == NULL){
		printf( "sndbuf tpalloc failed[%s]\n",tpstrerror(tperrno));
		tpfree((char *)sndbuf);
		tpend();
		exit(1);
	}	

	switch(in_num){
		case 1:
		   ret = fdl_ins(sndbuf,rcvbuf);	
		   if (ret == 0)
			printf( "\n\n******** Insert Successfully!! *********\n" );
		   else {
			printf( "\n\n******** Insert Failed!! **********\n" );
			printf( "**********   Sqlca.SqlCode = %d   **********\n",tpurcode);
		   }
		   break;
		case 2:
		   ret = fdl_sel(sndbuf,rcvbuf);	
		   if (ret == 0)
			printf( "\n\n******** Select Successfully!! *********\n" );
		   else if( ret == 100){
			printf("\n***************************************************\n");
			printf( "***   Not Registered Employee Number!!!   ***\n" );
			printf("***************************************************\n\n\n");
		   }
		   else {
			printf( "\n\n******** Select Failed!! **********\n" );
			printf( "**********   Sqlca.SqlCode = %d   **********\n",tpurcode);
		   }
		   break;
		case 3:
		   ret = fdl_upt(sndbuf, rcvbuf);	
		   if (ret == 0)
			printf( "\n\n******** Update Successfully!! *********\n" );
		   else {
			printf( "\n\n******** Update Failed!! **********\n" );
			printf( "**********   Sqlca.SqlCode = %d   **********\n",tpurcode);
		   }
		   break;
		case 4:
		   ret = fdl_del(sndbuf, rcvbuf);	
		   if (ret == 0)
			printf( "\n\n******** Delete Successfully!! *********\n" );
		   else {
			printf( "\n\n******** Delete Failed!! **********\n" );
			printf( "**********   Sqlca.SqlCode = %d   **********\n",tpurcode);
		   }
	}
	tpfree((char *)sndbuf);
	tpfree((char *)rcvbuf);
	tpend();
}

int fdl_sel(FBUF *sndbuf, FBUF *rcvbuf)
{
	long rlen;
	int  empno;
	str  tmpbuf;

	printf( "Employee Number : " ); scanf("%d", &empno);

	fbput( sndbuf, EMPNO, (char *)&empno, 0 );

	if (tpcall("FDLSEL",(char *)sndbuf, 0, (char **)&rcvbuf, &rlen, 0)==-1){
		printf( "tpcall FDLSEL failed[%s]\n",tpstrerror(tperrno));
		return -1;
	}

	if (tpurcode == 1403)
		return 100;

	tmpbuf = malloc(sizeof(struct temp_str));

	fbget( rcvbuf, EMPNO, (char *)&tmpbuf->empno, 0 );
	fbget( rcvbuf, ENAME, (char *)tmpbuf->ename, 0 );
	fbget( rcvbuf, JOB,   (char *)tmpbuf->job  , 0 );
	fbget( rcvbuf, MGR,   (char *)&tmpbuf->mgr , 0 );
	fbget( rcvbuf, DATE,  (char *)tmpbuf->date , 0 );
	fbget( rcvbuf, SAL,   (char *)&tmpbuf->sal , 0 );
	fbget( rcvbuf, COMM,  (char *)&tmpbuf->comm, 0 );
	fbget( rcvbuf, DEPTNO,(char *)&tmpbuf->deptno, 0);

	printf("\n***************************************************\n");
	printf( "| Selected Employee Number : %d\n", tmpbuf->empno );
	printf( "| Selected Employee Name   : %s\n", tmpbuf->ename );
	printf( "| Selected Employee Job    : %s\n", tmpbuf->job );
	printf( "| Selected Manager  Number : %d\n", tmpbuf->mgr );
	printf( "| Selected Hiredate(yymmdd): %s\n", tmpbuf->date );
	printf( "| Selected Salary          : %.2f\n", tmpbuf->sal );
	printf( "| Selected Commission      : %.2f\n", tmpbuf->comm );
	printf( "| Selected Department No   : %d\n", tmpbuf->deptno );
	printf("***************************************************\n\n");

	return 0;
}
int fdl_upt(FBUF *sndbuf, FBUF *rcvbuf)
{
	char sel;
	int  empno;
	char ename[11], job[10];
	long rlen;

	printf( "Employee Number : " ); scanf("%d", &empno);
	printf( "\n\n" );

	printf("***************************************************\n");
	printf( "You can change only Employee Name or Employee Job \n" ); 
	printf("***************************************************\n");
	printf( "|  Employee Name: "); scanf("%s", ename ); 
	printf( "|  Employee Job : "); scanf("%s", job ); 
	printf("***************************************************\n\n");

	fbput( sndbuf, EMPNO, (char *)&empno, 0 );
	fbput( sndbuf, ENAME, (char *)ename,  0 );
	fbput( sndbuf, JOB,   (char *)job,    0 );

	if (tpcall("FDLUPT",(char *)sndbuf,0,(char **)&rcvbuf,&rlen,0)==-1){
		printf( "tpcall FDLUDT failed[%s]\n",tpstrerror(tperrno));
		return -1;
	}

	return 0;	
}
int fdl_del(FBUF *sndbuf, FBUF *rcvbuf)
{
	long rlen;
	int  empno;

	printf( "Employee Number : " ); scanf("%d", &empno);
	
	fbput( sndbuf, EMPNO, (char *)&empno, 0 );

	if (tpcall("FDLDEL",(char *)sndbuf, 0, (char **)&rcvbuf, &rlen, 0)==-1){
		printf( "tpcall FDLDEL failed[%s]\n",tpstrerror(tperrno));
		return -1;
	}
	
	return 0;
}
int fdl_ins(FBUF *sndbuf, FBUF *rcvbuf)
{
	int ret;
	long rlen;	
	str tmpbuf;

	tmpbuf = malloc(sizeof(struct temp_str));

	printf("\n******************************************\n");
	printf( "|  Employee Number : " ); scanf ( "%d", &tmpbuf->empno );
	printf( "|  Employee Name   : " ); scanf ( "%s", tmpbuf->ename );
	printf( "|  Employee Job    : " ); scanf ( "%s", tmpbuf->job );
	printf( "|  Manager  Number : " ); scanf ( "%d", &tmpbuf->mgr );
	printf( "|  Hiredate(yymmdd): " ); scanf ( "%s", tmpbuf->date);
	printf( "|  Salary          : " ); scanf ( "%f", &tmpbuf->sal );
	printf( "|  Commission      : " ); scanf ( "%f", &tmpbuf->comm );
	printf( "|  Department No   : " ); scanf ( "%d", &tmpbuf->deptno );
	printf("******************************************\n\n");

	fbput( sndbuf, EMPNO, (char *)&tmpbuf->empno, 0 );
	fbput( sndbuf, ENAME, (char *)tmpbuf->ename, 0 );
	fbput( sndbuf, JOB,   (char *)tmpbuf->job, 0 );
	fbput( sndbuf, MGR,   (char *)&tmpbuf->mgr, 0 );
	fbput( sndbuf, DATE,  (char *)tmpbuf->date, 0 );
	fbput( sndbuf, SAL,   (char *)&tmpbuf->sal, 0 );
	fbput( sndbuf, COMM,  (char *)&tmpbuf->comm, 0 );
	fbput( sndbuf, DEPTNO,(char *)&tmpbuf->deptno, 0 );

	if (tpcall("FDLINS", (char *)sndbuf,0, (char **)&rcvbuf, &rlen, 0 ) == -1){
		printf( "tpcall FDLINS failed[%s]\n", tpstrerror(tperrno));
		return -1;
	}

	return 0; 
}
int print_main()
{
	int in_num;

	printf( "********************************************\n");
	printf( "**         Selection Menu List            **\n");
	printf( "********************************************\n");
	printf( "**                                        **\n");
	printf( "**              0. Exit                   **\n");
	printf( "**              1. Insert                 **\n");
	printf( "**              2. Select                 **\n");
	printf( "**              3. Update                 **\n");
	printf( "**              4. Delete                 **\n");
	printf( "**                                        **\n");
	printf( "********************************************\n\n\n");
	printf( "Select Menu Number[0-4] : ");
	scanf("%d",&in_num);

	return in_num;	
}
