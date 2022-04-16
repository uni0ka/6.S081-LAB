#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

/*本体难点在于彻底理解xargs的作用：
    sh: find . b | xargs grep hello
  管道 | 将 find . b 得到的结果输入到 xargs 的标准输入流，即xargs进程的0号fd中
  xargs 需要从0号fd中读取 | 之前的命令执行的结果，并且拼接到 grep hello 后面，并启动一个新的进程来执行拼接出的命令
  grep hello 不从0号fd读取，而是对应 argv[1] 和 argv[2] ，即xargs的常规传参
*/

int main(int argc, char ** argv) {
    char params[128];  //暂存每次读取的一行参数
    char tmp[128];     //暂存每次处理的一个参数
    char *line[128];   //存储格式化以后的所有参数
 
    int cnt = 0;      //第几个参数
    int bias = 0;     //每个参数的当前处理位

    for (int i = 1; i < argc; i++)  line[cnt++] = argv[i];  
    /*根据exec定义
     char *argv[] = {"echo", "hello", "world", 0};
     exec("echo", argv);  //argv中的第一个字符串，是exec调用的程序的名字
    */
    
    int _cnt = cnt;  //记录通过argv传入的参数的个数，它们已经拼接到每一组通过 | 传入的参数前面
    int read_size;
    while( (read_size = read(0, params, sizeof(params))) ){
        for(int i=0; i<read_size; ++i){
            if(params[i] != '\n' && params[i] != ' ')  //处理常规字符
                tmp[bias++] = params[i];
            else if(params[i] == ' '){  //处理空格，即两个参数的分割
                tmp[bias] = '\0';
                line[cnt++] = tmp;
                bias = 0;
            }
            else if(params[i] == '\n'){  //处理回车，代表一行（组）参数的结束
                tmp[++bias] = '\0';   //'\n'时，当前参数已经到结尾，先进行类似'\0'情况下的处理
                line[cnt++] = tmp;
                bias = 0;
                line[cnt] = 0;   //参数的最后一位为0，标志参数数组的结尾

                int pid = fork();  
                if( pid == 0){
                    exec(argv[1], line);
                    fprintf(2, "exec error");
                    exit(0);
                }
                else if( pid > 0){
                    wait(0);
                    cnt = _cnt; //line 27
                    break;
                }
                else{
                    fprintf(2, "fork error: fork() returned %d\n", pid);
                    exit(0);
                }
            }
        }
    }
    exit(0);
}
