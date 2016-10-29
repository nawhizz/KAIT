#include "ipcwrapdef.h"

int CBD1
getsemid(int psemid)
{
	int i;
	HANDLE hIpct = NULL;
	IPCT *ipct = NULL;
	
	if (psemid>=MAXNOOFIPC)
	{
		errno=EINVAL;
		return -1;
	}
	
	if (GetIPCT(&hIpct, &ipct)<0)
	{
		errno=EFAULT;
		return -1;
	}
	
	if (psemid<0)	i = 0;
	else	i = psemid+1;
	
	for (; i<MAXNOOFIPC; i++)
	{
		if (ipct->semt[i].key!=-1)
		{
			FreeIPCT(hIpct, ipct);
			return i;
		}
	}
	
	FreeIPCT(hIpct, ipct);
	return -1;
}