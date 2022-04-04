#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char **argv){
	int par_to_chi[2], chi_to_par[2];
	pipe(par_to_chi);
	pipe(chi_to_par);
	char buf[100];

	int pid = fork();
    if(pid == 0){   //child
		close(par_to_chi[1]);
		close(chi_to_par[0]);
		write(chi_to_par[1], "ping\n", strlen("ping\n"));
		read(par_to_chi[0], buf, sizeof(buf));
	    fprintf(1, "%d: received %s", getpid(), buf);
		exit(0);
	}
	else{   //parent
		close(par_to_chi[0]);
		close(chi_to_par[1]);
		read(chi_to_par[0], buf, sizeof(buf));
	    fprintf(1, "%d: received %s", getpid(), buf);
		write(par_to_chi[1], "pong\n", strlen("pong\n"));  //在打印完ping后再向child传pong，避免两个string交替打印造成结果错误
		wait(0);
	}
	exit(0);
}
