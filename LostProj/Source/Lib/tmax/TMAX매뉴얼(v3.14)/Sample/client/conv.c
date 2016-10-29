/*
Usage : conv input-file
*/
/* input file format
*tpconnect SKU_C_1
#필드명         index   value
fdl_str1        0       "8804397605"
fdl_str2        0       ""
*/
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <usrinc/atmi.h>
#include <usrinc/fbuf.h>
#include <tuxinc/macro.h>
#include <errno.h>
#include <usrinc/tx.h>

int flag=0;
char filename[64];

void main(int argc, char *argv[])
{
    char val[512], *p;
    char rbuf[512+1];
    char svcname[17];
    int timeout;
    long revent, rcvlen;
    FLDKEY key;
    FBUF *transf;
    FILE *fp;
    int cd, n, fflag=0, i, idx=0;
    int ret;

/*
    if (argc != 2) {
        fprintf(stderr, "Usage:%s input-file\n", argv[0]);
        exit(1);
    }
*/

    if(parseArg(argc, argv)<0){
	printf("parseArg error!!\n");
	exit(1);
    }

    if( (fp=fopen(filename, "r")) == (FILE *)0 ){
        printf( "file open error [%d:%s]\n", errno, strerror(errno) );
        exit( 1 );
    }

    memset( svcname, 0x00, sizeof(svcname) );

    if( get_svcname(fp, svcname) < 0 ){
        printf( "get_svcname() failed!! -- (input-file=%s)\n", argv[1] );
        exit(1);
    }


    timeout = 5;

    n = tpstart((TPSTART_T *)NULL);
    if (n < 0) {
       fprintf(stderr, "tpstart fail tperrno = %s\n", tperrno);
       exit(1);
    }
    printf("tpstart ok!\n");


    transf = fballoc(100, 100);

    if( transf == NULL) {
        fprintf(stderr, "fballoc fail: rcvbuf tperrno = %d\n", tperrno);
        tpend();
        exit(1);
    }

    Finit(transf, Fsizeof(transf));

    while( 1 ){
       memset( rbuf, 0x00, sizeof(rbuf) );
       if( fgets(rbuf, sizeof(rbuf)-1, fp)==(char *) 0 ){
           break;
       }

       p = strchr(rbuf, '\n');
       if( p == (char *)0 && strlen(rbuf) >= sizeof(rbuf)-1 ){
           printf( "한 라인의 길이가 너무 길어 무시합니다..\n" );
           printf( "=>[%s]\n", rbuf );
           continue;
       }
       *p = 0x00;

       memset( val, 0x00, sizeof(val) );
       key = 0;

       if( line_proc(rbuf, &key, &idx, val)<0 ) continue;
       PUT(key, idx, val);
printf( "key=%d, idx=%d, val=%s\n", key, idx, val );
       fflag = 1;
    }

    if( !fflag ){
        printf( "not exist send data .....\n" );
        fbfree( transf );
        tpend();
        exit(1);
    }

printf( ">>service[%s], send data->\n", svcname );
fbprint( transf );
printf( "\t----------------------------------------------------\n\n\n" );
fflush( stdout );

/* original
    cd = tpconnect(svcname, (char *)transf, fbget_fbsize(transf), TPRECVONLY);
*/
    if(flag==1){
	ret = tx_begin();
	printf("tx_begin() [%s] \n", ret==TX_OK ? "success" : "fail");
	if(ret!=TX_OK) exit(1);
    }
    cd = tpcall(svcname, (char *)transf, fbget_fbsize(transf), (char **)&transf, (long *)&rcvlen, 0);
    if (cd < 0) {
    if(flag==1){
	ret = tx_rollback();
	printf("tx_rollback() [%s] \n", ret==TX_OK ? "success" : "fail");
	if(ret!=TX_OK) exit(1);
    }
        fprintf(stderr, "tpcall fail tperrno = %d\n", tperrno);
        fbfree( transf );
        tpend();
        exit(1);
    }
    fprintf(stdout, "TPCALL SUCCESS!!\n");
    if(flag==1){
	ret = tx_commit();
	printf("tx_commit() [%s] \n", ret==TX_OK ? "success" : "fail");
	if(ret!=TX_OK) exit(1);
    }
/*
    i = 0;
    while( 1 ){

       Finit(transf, Fsizeof(transf));

       n = tprecv(cd, (char **)&transf, (long *)&rcvlen, 0, &revent);

       if (n < 0 && tperrno == TPEEVENT ){
           if(revent == TPEV_SVCSUCC )
                  printf( "service completed(TPSUCC) !\n" );
           else if(revent == TPEV_SVCFAIL )
                  printf( "service completed(TPFAIL) !\n" );
           else{
                  printf( "tprecv error : event[0x%08X], tperrno[%d]\n", revent, tperrno );
                  break;
           }
       }
       else if( n < 0 ){
           printf( "tprecv error(no event) : tperrno[%d]\n", tperrno );
           break;
       }

       fbprint( transf );
       printf( "\t------------------------------------------------------[%3d th]\n\n", i++ );
       fflush( stdout );
       if (n < 0 ) break;
    }
*/

    fbfree(transf);

    tpend();
}

int get_svcname( FILE *fp, char *svc )
{
char rbuf[512+1];
char tmp[10];

    while( 1 ){
       memset( rbuf, 0x00, sizeof(rbuf) );
       if( fgets(rbuf, sizeof(rbuf), fp)==(char *) 0 ){
           break;
       }
/*
       if( !memcmp(rbuf, "*tpconnect", 10) ){
*/
       if( !memcmp(rbuf, "*tpcall", 6) ){
           sscanf( rbuf, "%s %s", tmp, svc );
           if( real_len(svc, 17) <= 0 ) return -1;
           return 1;
       }
    }
    return -1;
}

int line_proc( char *s, FLDKEY *key, int *idx, char *value )
{
int len;
char *f, k[16], v[512];
char *sp, *ep;

   if( s[0] <= 0x20 ) return -1;

   f = strchr(s, '#');
   if( f!=(char *)0 ) memset( f, 0x00, strlen(s)-(f-s) );

   len = real_len( s, strlen(s) );
   if( len < 3 ) return -1;

   memset( k, 0x00, sizeof(k) );
   memset( v, 0x00, sizeof(v) );

   sscanf( s, "%s %d %s", k, idx, v );

   *key = fbget_fldkey(k);

   sp = strchr( s, '\"' );
   if( sp != (char *)0 ){
       ep = strrchr( s,'\"' );

       if( sp==ep ) return -1;

       sp++;
       memcpy( value, sp, ep - sp );
   }
   else if( v != (char *)0 ){
       memcpy( value, v, strlen(v) );
   }
   else
       return -1;

   return 1;
}

int real_len( char *s, int len )
{
int i;
char *t;

   if( len < 1 ) return 0;
   t = s;
   for( i=len-1; i >= 0; i-- ) 
        if( *(t+i)>0x20 ) break;
   return i+1;

}

int parseArg(int argc, char *argv[])
{
    int parse_return=0;
    int c;

    while ((c = getopt(argc, argv, "i:X")) != EOF) {
        switch (c) {
	case 'i':
	    memset(filename, 0x00, sizeof(filename));
	    strcpy(filename, optarg);
	parse_return++;
	    break;

        case 'X':
	     flag = 1;
	parse_return++;
	     break;

/*
        case 'u':
             strcpy(username, optarg); break;
        case 'p':
             strcpy(password, optarg); break;
        case '?':
             break;
*/
        }
    }
    return(parse_return==2 ? 1 : -1);
}
