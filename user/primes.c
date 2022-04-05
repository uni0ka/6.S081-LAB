#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void rec(int read_fd){
    int prime;
    int par_to_chi[2];
    pipe(par_to_chi);

    if( read(read_fd, &prime, sizeof(prime)) == 0 ) exit(0);
    printf("prime %d\n", prime);

    int pid = fork();
    if(pid == 0){   //child
        close(par_to_chi[1]);
        rec(par_to_chi[0]);
    }
    else{    //parent
        close(par_to_chi[0]);
        int tmp;
        while(read(read_fd, &tmp, sizeof(tmp)) > 0){
            if(tmp % prime != 0){
                int write_ret = write(par_to_chi[1], &tmp, sizeof(tmp));
                if(write_ret == 0)break;
            }
        }
        close(par_to_chi[1]);
        wait(0);
    }
}

int main(int argc, char **argv){
    int beginning = 2;
    int end = 35;
    
    int par_to_chi[2];
    pipe(par_to_chi);

    int pid = fork();
    if(pid == 0){   //child
        close(par_to_chi[1]);
        rec(par_to_chi[0]);
    }
    else{    //parent
        close(par_to_chi[0]);

        for (int i = beginning; i <= end; ++i){
            int tmp = i;
            write(par_to_chi[1], &tmp, sizeof(tmp));           
        }
        close(par_to_chi[1]);
        wait(0);
    }
    exit(0);
}