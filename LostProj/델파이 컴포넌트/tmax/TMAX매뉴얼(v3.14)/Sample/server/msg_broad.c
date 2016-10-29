#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include "atmi.h"

#define MAX_CLI 600 

int num_cli; 
int client_id[MAX_CLI]; 
int count; 

tpsvrinit(int argc, char *argv[]) 
{ 
num_cli = 0; 
count = 0; 
} 

int 
usermain(int argc, char *argv[]) /* tmax@G ucs 8p5e?!<- main0z 00@: :N:P */ 
{ 
int i, jobs; 
int interval, ret; 
long len; 
char *sndbuf; 
static int count = 0; 

printf("usermain start\n"); 
sndbuf = (char *)tpalloc("CARRAY", NULL, 2048); 

while(1) { 

jobs = tpschedule(10); 
if (jobs <= 0){ 
printf( "Time is Over...... Rewait....\n"); 
continue; 
} 

for (i = 0; i < num_cli; i++) { 
sprintf(sndbuf, "Success tpsendtocli [%d] 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890", count++); 

#ifdef _DEBUG 
tp_usleep(1000000); 
len = random() % 2048; 
interval = random() % 100000; 
tp_usleep(interval); 
ret = tpsendtocli (client_id[i], sndbuf, len, TPUDP); 
#else 
ret = tpsendtocli (client_id[i], sndbuf, 2048, TPUDP); 
printf("ret num = %d, tperr = %d\n", ret, tperrno); 
#endif 
/*********** 
ret = tpsendtocli (client_id[i], sndbuf, 2048, TPUDP|TPFLOWCONTROL); 
ret = tpsendtocli (client_id[i], sndbuf, 2048, TPUDP); 
ret = tpsendtocli (client_id[i], sndbuf, 2048, TPFLOWCONTROL); 
************/ 
if (ret < 0) { 
printf("tpsendtocli error = [%d], [%s]\n", ret, tpstrerror(tperrno)); 
} 
} 
/*if ((count % 10) == 0) { 
printf("usleep\n"); 
fflush(stdout); 
usleep(1000000); 
}*/ 
} 
} 

BROAD_CLOCK(TPSVCINFO *msg) 
{ 
char *sndbuf; 
int clid; 
int ret; 
int i; 

for (i = 0; i < msg->len; i++) { 
printf("%c", msg->data[i]); 
} 
printf("\n"); 
#ifdef _DEBUG 
printf("msg->data = [%.*s]\n", msg->len, msg->data); 
fflush(stdout); 
#endif 

sndbuf = (char *)tpalloc("CARRAY", NULL, 1000); 

sprintf(sndbuf, "Success transaction"); 
sprintf(sndbuf + 50, "Success transaction"); 

if (num_cli < MAX_CLI) { 
client_id[num_cli] = tpgetclid(); 
printf("client id(clid) = %d\n", client_id[num_cli]); 
num_cli++; 
} 

tpreturn(TPSUCCESS, 0, (char *)sndbuf, 1000, 0); 
} 

BROAD_MSG(TPSVCINFO *msg) 
{ 
int i; 

char *str0; 

str0 = (char *)msg->data; 

printf("strlen = %d\n", strlen(str0)); 
printf("msg->len = %d\n", msg->len); 
printf("str = %s\n", str0); 
printf("msg->data = %s\n", msg->data); 

for (i = 0; i < strlen(str0); i++) { 
str0[i] = toupper(str0[i]); 
} 

tpreturn (TPSUCCESS, 1, (char *)str0, 0, 0); 
} 

