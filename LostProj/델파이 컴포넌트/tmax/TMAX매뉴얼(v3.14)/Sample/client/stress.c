/********************* CLIENT FOR STRESS TEST *************************/

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

#define CLIENT_PGM			"demo_client"

void wait_proc(int sig_num);


char	*base_dir;
char	client_pgm[30];

/*-------------------- main ------------------------------------------*/
main(int argc, char *argv[])
{
	int		i;
	int		client_num, process_num;
	char	service_name[30];

	memset(client_pgm,   0x00, sizeof(client_pgm));
	memset(service_name, 0x00, sizeof(service_name));
	client_num = process_num = 0;

	printf("STRESS TEST START !\n\n");
	printf("Ŭ���̾�Ʈ ��: ");
	scanf("%d", &client_num);
	printf("���� ó�� Ƚ��: ");
	scanf("%d", &process_num);
/*
	printf("ó���� ���ϴ� ���񽺸�: ");
	scanf("%s", service_name);
*/
	printf("Ŭ���̾�Ʈ ���α׷���: ");
	scanf("%s", client_pgm);

	printf("\nŬ���̾�Ʈ ��: [%d],  ó��Ƚ��: [%d],  Ŭ���̾�Ʈ: [%s]\n",  
		client_num, process_num, client_pgm);

/*
	if (service_name[0] == 0x00) {
		printf("���񽺸��� �Էµ��� �ʾҽ��ϴ�\n");
		exit(1);
	}
*/
	base_dir = (char *)getenv("TMAXDIR");
	if (base_dir == NULL) {
		printf("TMAXDIR not found\n");
		exit(1);
	}

	signal(SIGCLD, wait_proc);
	for (i = 0; i < client_num; i++) {
		if (client_fork(process_num, service_name) < 0) exit(1);
		sleep(0.01); 
	}
	exit(0);
}


void wait_proc(int sig_num)
{
	int		pid, status;

	while ((pid = wait3(&status, WNOHANG, (struct rusage *)0)) > 0);

	signal(SIGCLD, wait_proc);
}


int client_fork(int num, char *service)
{
	int	pid;
	char	path[100];
	char	env1[30], env2[30];

	sprintf(path, "/tmax41/sample/client/%s", client_pgm);
	sprintf(env1, "%d", num);
	strcpy(env2, service);

	pid = fork();
	if (pid < 0) {
		printf("client program fork failed\n");
		return -1;
	} else if(pid == 0) {  
		execl(path, client_pgm, env1, env2, (char *)NULL);
	} else ;
 
	return 0;
}

