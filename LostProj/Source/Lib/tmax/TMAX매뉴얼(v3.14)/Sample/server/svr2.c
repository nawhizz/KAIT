#include <stdio.h>
#include <usrinc/atmi.h>


TOUPPER(TPSVCINFO *msg)
{
	int		i;

	printf("TOUPPER service is started!\n");
	printf("INPUT : data=%s\n", msg->data);

	for (i = 0; i < msg->len; i++) 
		msg->data[i] = toupper(msg->data[i]);

	printf("OUTPUT: data=%s\n", msg->data);

	tpreturn(TPSUCCESS,0,(char *)msg->data, 0,0);
}	


TOLOWER(TPSVCINFO *msg)
{
	int		i;

	printf("TOLOWER service is started!\n");
	printf("INPUT : data=%s\n", msg->data);

	for (i = 0; i < msg->len; i++) 
		msg->data[i] = tolower(msg->data[i]);

	printf("OUTPUT: data=%s\n", msg->data);

	tpreturn(TPSUCCESS,0,(char *)msg->data, 0,0);
}	
