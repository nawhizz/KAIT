#include <stdio.h>
#include <usrinc/atmi.h>
#include "../sdl/demo.s"


SYNC(TPSVCINFO *msg)
{
	int		i;
	struct	kstrdata *stdata;

	stdata = (struct kstrdata *)msg->data;
	printf("SYNC service is started!\n");

	printf("INPUT : data=%s\n", stdata->sdata);

	for (i = 0; i < stdata->len; i++) 
		stdata->sdata[i] = toupper(stdata->sdata[i]);

	printf("OUTPUT: data=%s\n", stdata->sdata);

	tpreturn(TPSUCCESS,0,(char *)stdata, sizeof(struct kstrdata),0);
}	


ASYNC(TPSVCINFO *msg)
{
	int i = 0;
	struct kstrdata *stdata;

	stdata = (struct kstrdata *)msg->data;
	
   	while( stdata->sdata[i]!='\0') {
		stdata->sdata[i] = toupper(stdata->sdata[i]);
		i++;
	};

 	printf("return data=%s\n", stdata->sdata);
	tpreturn(TPSUCCESS,0,(char *)stdata, sizeof(struct kstrdata),0);
}


SSYNC(TPSVCINFO *msg)
{
	int		i;

	printf("SSYNC service is started!\n");
	printf("INPUT : data=%s\n", msg->data);

	for (i = 0; i < msg->len; i++) 
		msg->data[i] = toupper(msg->data[i]);

	printf("OUTPUT: data=%s\n", msg->data);

	tpreturn(TPSUCCESS,0,(char *)msg->data, 0,0);
}	
