#include <stdio.h>
#include <usrinc/atmi.h>
#include "../sdl/demo.s"


SDLTOUPPER(TPSVCINFO *msg)
{
	int	i;
	struct	kstrdata *stdata;

	stdata = (struct kstrdata *)msg->data;
	printf("SDLTOUPPER service is started!\n");

	printf("INPUT : data=%s\n", stdata->sdata);

	for (i = 0; i < stdata->len; i++) 
		stdata->sdata[i] = toupper(stdata->sdata[i]);

	printf("OUTPUT: data=%s\n", stdata->sdata);

	tpreturn(TPSUCCESS,0,(char *)stdata, sizeof(struct kstrdata),0);
}	


SDLTOLOWER(TPSVCINFO *msg)
{
	int		i;
	struct	kstrdata *stdata;

	stdata = (struct kstrdata *)msg->data;
	printf("SDLTOLOWER service is started!\n");

	printf("INPUT : data=%s\n", stdata->sdata);

	for (i = 0; i < stdata->len; i++) 
		stdata->sdata[i] = tolower(stdata->sdata[i]);

	printf("OUTPUT: data=%s\n", stdata->sdata);

	tpreturn(TPSUCCESS,0,(char *)stdata, sizeof(struct kstrdata),0);
}	
