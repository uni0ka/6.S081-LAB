#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

#define BUFSIZE 512

void find(char *path, char *target);

int main(int argc, char *argv[])
{
	if(argc < 3){
        fprintf(2, "usage: find <path> <target>\n");
		exit(0);
	}
	char target[BUFSIZE];
	target[0] = '/';   //为想要查找的文件名(target)添加 / 
	strcpy(target+1, argv[2]);
	find(argv[1], target);
	exit(0);
}

void find(char *path, char *target) {
    char buf[BUFSIZE];
    char *p = buf;
    int fd;
    struct dirent de;  //dirent结构体存储目录信息，当fd是一个文件目录时，可用read从该fd中读取该目录包含的文件的dirent
    struct stat st;    //stat结构体存储文件属性，用fstat函数从fd中获取

    if( (fd = open(path, 0)) < 0){
        fprintf(2, "open error: can't open %s\n", path);
        close(fd);
        return;
    }

    if( fstat(fd, &st) < 0){
        fprintf(2, "fstat error: can't get stat from %s\n", path);
        close(fd);
        return;
    }

	switch(st.type){
        case T_FILE: //fd打开的是一个文件
            p = path + strlen(path) - strlen(target);
            if( strcmp(p, target) == 0){ //如果path结尾与/target相等，则成功匹配到一个符合文件
                printf("%s\n", path);
            }
            break;
        case T_DIR: //fd打开的是一个目录
            if( strlen(path) +1 + DIRSIZ +1 > sizeof(buf)){
                fprintf(2, "find error: path too long\n");
                break;
            }
            strcpy(buf, path);
            p = buf + strlen(buf);
            *p = '/';
            ++p;

            while(read(fd, &de, sizeof(de)) == sizeof(de)){   //每次从 当前目录 读取 该目录中 一个文件的dirent信息， 存入de
                if(de.inum == 0) continue;
                memmove(p, de.name, DIRSIZ);  //把读取到的文件名拼接到buf的末尾，buf成为下一层递归的path
                //p += DIRSIZ;      
                //*p = '0';      //这种写法和p[DIRSIZ]应该是等价的，但通过不了，暂未找到原因
                p[DIRSIZ]= '0';
                if(stat(buf, &st) < 0){
                    printf("find: cannot stat %s\n", buf);
                    continue;
                }
                // 不要进入 `.` 和 `..`
                if(strcmp(buf+strlen(buf)-2, "/.") != 0 && strcmp(buf+strlen(buf)-3, "/..") != 0) {
                    find(buf, target); // 递归查找
                }
            }
            break;
        }
	close(fd);
}
