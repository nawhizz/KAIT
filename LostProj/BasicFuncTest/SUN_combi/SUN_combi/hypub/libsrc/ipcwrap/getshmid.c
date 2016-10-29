#include "ipcwrapdef.h"

//extern SHMT		shmt[];
int CBD1	
getshmid(int pshmid)
{
	int	i;
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

	if (pshmid>=MAXNOOFIPC)
	{
		errno=EINVAL;
		return -1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		errno=EFAULT;
		return -1;
	}

	if (pshmid<0)	i = 0;
	else		i = pshmid+1;

	for (; i<MAXNOOFIPC; i++)
	{
/*2001.1.9
		if (ipct->shmt[i].key!=-1)
******************************************/
		if (ipct->shmt[i].key>0)
		{
			FreeIPCT(hIpct, ipct);
			return i;
		}
	}

	FreeIPCT(hIpct, ipct);
	return -1;
}
