
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
  管道 | 将 find . b 得到的结果输入到 xargs 的标准输入流，即xargs进程的0号fd中
  xargs 需要从0号fd中读取 | 之前的命令执行的结果，并且拼接到 grep hello 后面，并启动一个新的进程来执行拼接出的命令
  grep hello 不从0号fd读取，而是对应 argv[1] 和 argv[2] ，即xargs的常规传参
*/

int main(int argc, char ** argv) {
   0:	aa010113          	addi	sp,sp,-1376
   4:	54113c23          	sd	ra,1368(sp)
   8:	54813823          	sd	s0,1360(sp)
   c:	54913423          	sd	s1,1352(sp)
  10:	55213023          	sd	s2,1344(sp)
  14:	53313c23          	sd	s3,1336(sp)
  18:	53413823          	sd	s4,1328(sp)
  1c:	53513423          	sd	s5,1320(sp)
  20:	53613023          	sd	s6,1312(sp)
  24:	51713c23          	sd	s7,1304(sp)
  28:	51813823          	sd	s8,1296(sp)
  2c:	51913423          	sd	s9,1288(sp)
  30:	56010413          	addi	s0,sp,1376
  34:	8cae                	mv	s9,a1
    char *line[128];   //存储格式化以后的所有参数
 
    int cnt = 0;      //第几个参数
    int bias = 0;     //每个参数的当前处理位

    for (int i = 1; i < argc; i++)  line[cnt++] = argv[i];  
  36:	4785                	li	a5,1
  38:	02a7de63          	bge	a5,a0,74 <main+0x74>
  3c:	00858713          	addi	a4,a1,8
  40:	aa040793          	addi	a5,s0,-1376
  44:	00050c1b          	sext.w	s8,a0
  48:	ffe5069b          	addiw	a3,a0,-2
  4c:	1682                	slli	a3,a3,0x20
  4e:	9281                	srli	a3,a3,0x20
  50:	068e                	slli	a3,a3,0x3
  52:	aa840613          	addi	a2,s0,-1368
  56:	96b2                	add	a3,a3,a2
  58:	6310                	ld	a2,0(a4)
  5a:	e390                	sd	a2,0(a5)
  5c:	0721                	addi	a4,a4,8
  5e:	07a1                	addi	a5,a5,8
  60:	fed79ce3          	bne	a5,a3,58 <main+0x58>
  64:	3c7d                	addiw	s8,s8,-1
            if(params[i] != '\n' && params[i] != ' ')  //处理常规字符
                tmp[bias++] = params[i];
            else if(params[i] == ' '){  //处理空格，即两个参数的分割
                tmp[bias] = '\0';
                line[cnt++] = tmp;
                bias = 0;
  66:	4b81                	li	s7,0
            if(params[i] != '\n' && params[i] != ' ')  //处理常规字符
  68:	02000a13          	li	s4,32
                line[cnt++] = tmp;
  6c:	ea040a93          	addi	s5,s0,-352
                bias = 0;
  70:	8b5e                	mv	s6,s7
  72:	a041                	j	f2 <main+0xf2>
    int cnt = 0;      //第几个参数
  74:	4c01                	li	s8,0
  76:	bfc5                	j	66 <main+0x66>
                tmp[bias++] = params[i];
  78:	fa040613          	addi	a2,s0,-96
  7c:	9626                	add	a2,a2,s1
  7e:	f0e60023          	sb	a4,-256(a2)
  82:	2485                	addiw	s1,s1,1
        for(int i=0; i<read_size; ++i){
  84:	0785                	addi	a5,a5,1
  86:	06d78963          	beq	a5,a3,f8 <main+0xf8>
            if(params[i] != '\n' && params[i] != ' ')  //处理常规字符
  8a:	0007c703          	lbu	a4,0(a5)
  8e:	03270363          	beq	a4,s2,b4 <main+0xb4>
  92:	ff4713e3          	bne	a4,s4,78 <main+0x78>
                tmp[bias] = '\0';
  96:	fa040713          	addi	a4,s0,-96
  9a:	94ba                	add	s1,s1,a4
  9c:	f0048023          	sb	zero,-256(s1)
                line[cnt++] = tmp;
  a0:	00399713          	slli	a4,s3,0x3
  a4:	fa040613          	addi	a2,s0,-96
  a8:	9732                	add	a4,a4,a2
  aa:	b1573023          	sd	s5,-1280(a4)
  ae:	2985                	addiw	s3,s3,1
                bias = 0;
  b0:	84da                	mv	s1,s6
  b2:	bfc9                	j	84 <main+0x84>
            }
            else if(params[i] == '\n'){  //处理回车，代表一行（组）参数的结束
                tmp[++bias] = '\0';   //'\n'时，当前参数已经到结尾，先进行类似'\0'情况下的处理
  b4:	2485                	addiw	s1,s1,1
  b6:	fa040793          	addi	a5,s0,-96
  ba:	94be                	add	s1,s1,a5
  bc:	f0048023          	sb	zero,-256(s1)
                line[cnt++] = tmp;
  c0:	00399793          	slli	a5,s3,0x3
  c4:	fa040713          	addi	a4,s0,-96
  c8:	97ba                	add	a5,a5,a4
  ca:	b157b023          	sd	s5,-1280(a5)
                bias = 0;
                line[cnt] = 0;   //参数的最后一位为0，标志参数数组的结尾
  ce:	0019879b          	addiw	a5,s3,1
  d2:	078e                	slli	a5,a5,0x3
  d4:	97ba                	add	a5,a5,a4
  d6:	b007b023          	sd	zero,-1280(a5)

                int pid = fork();  
  da:	00000097          	auipc	ra,0x0
  de:	30c080e7          	jalr	780(ra) # 3e6 <fork>
                if( pid == 0){
  e2:	c129                	beqz	a0,124 <main+0x124>
                    exec(argv[1], line);
                    fprintf(2, "exec error");
                    exit(0);
                }
                else if( pid > 0){
  e4:	06a05663          	blez	a0,150 <main+0x150>
                    wait(0);
  e8:	855e                	mv	a0,s7
  ea:	00000097          	auipc	ra,0x0
  ee:	30c080e7          	jalr	780(ra) # 3f6 <wait>
                bias = 0;
  f2:	89e2                	mv	s3,s8
  f4:	84de                	mv	s1,s7
            if(params[i] != '\n' && params[i] != ' ')  //处理常规字符
  f6:	4929                	li	s2,10
    while( (read_size = read(0, params, sizeof(params))) ){
  f8:	08000613          	li	a2,128
  fc:	f2040593          	addi	a1,s0,-224
 100:	855e                	mv	a0,s7
 102:	00000097          	auipc	ra,0x0
 106:	304080e7          	jalr	772(ra) # 406 <read>
 10a:	c135                	beqz	a0,16e <main+0x16e>
        for(int i=0; i<read_size; ++i){
 10c:	fea056e3          	blez	a0,f8 <main+0xf8>
 110:	f2040793          	addi	a5,s0,-224
 114:	fff5069b          	addiw	a3,a0,-1
 118:	1682                	slli	a3,a3,0x20
 11a:	9281                	srli	a3,a3,0x20
 11c:	f2140713          	addi	a4,s0,-223
 120:	96ba                	add	a3,a3,a4
 122:	b7a5                	j	8a <main+0x8a>
                    exec(argv[1], line);
 124:	aa040593          	addi	a1,s0,-1376
 128:	008cb503          	ld	a0,8(s9)
 12c:	00000097          	auipc	ra,0x0
 130:	2fa080e7          	jalr	762(ra) # 426 <exec>
                    fprintf(2, "exec error");
 134:	00000597          	auipc	a1,0x0
 138:	7d458593          	addi	a1,a1,2004 # 908 <malloc+0xe4>
 13c:	4509                	li	a0,2
 13e:	00000097          	auipc	ra,0x0
 142:	5fa080e7          	jalr	1530(ra) # 738 <fprintf>
                    exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	2a6080e7          	jalr	678(ra) # 3ee <exit>
                    cnt = _cnt; //line 27
                    break;
                }
                else{
                    fprintf(2, "fork error: fork() returned %d\n", pid);
 150:	862a                	mv	a2,a0
 152:	00000597          	auipc	a1,0x0
 156:	7c658593          	addi	a1,a1,1990 # 918 <malloc+0xf4>
 15a:	4509                	li	a0,2
 15c:	00000097          	auipc	ra,0x0
 160:	5dc080e7          	jalr	1500(ra) # 738 <fprintf>
                    exit(0);
 164:	4501                	li	a0,0
 166:	00000097          	auipc	ra,0x0
 16a:	288080e7          	jalr	648(ra) # 3ee <exit>
                }
            }
        }
    }
    exit(0);
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	27e080e7          	jalr	638(ra) # 3ee <exit>

0000000000000178 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17e:	87aa                	mv	a5,a0
 180:	0585                	addi	a1,a1,1
 182:	0785                	addi	a5,a5,1
 184:	fff5c703          	lbu	a4,-1(a1)
 188:	fee78fa3          	sb	a4,-1(a5)
 18c:	fb75                	bnez	a4,180 <strcpy+0x8>
    ;
  return os;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret

0000000000000194 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 194:	1141                	addi	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 19a:	00054783          	lbu	a5,0(a0)
 19e:	cb91                	beqz	a5,1b2 <strcmp+0x1e>
 1a0:	0005c703          	lbu	a4,0(a1)
 1a4:	00f71763          	bne	a4,a5,1b2 <strcmp+0x1e>
    p++, q++;
 1a8:	0505                	addi	a0,a0,1
 1aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	fbe5                	bnez	a5,1a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1b2:	0005c503          	lbu	a0,0(a1)
}
 1b6:	40a7853b          	subw	a0,a5,a0
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf91                	beqz	a5,1e6 <strlen+0x26>
 1cc:	0505                	addi	a0,a0,1
 1ce:	87aa                	mv	a5,a0
 1d0:	4685                	li	a3,1
 1d2:	9e89                	subw	a3,a3,a0
 1d4:	00f6853b          	addw	a0,a3,a5
 1d8:	0785                	addi	a5,a5,1
 1da:	fff7c703          	lbu	a4,-1(a5)
 1de:	fb7d                	bnez	a4,1d4 <strlen+0x14>
    ;
  return n;
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret
  for(n = 0; s[n]; n++)
 1e6:	4501                	li	a0,0
 1e8:	bfe5                	j	1e0 <strlen+0x20>

00000000000001ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f0:	ce09                	beqz	a2,20a <memset+0x20>
 1f2:	87aa                	mv	a5,a0
 1f4:	fff6071b          	addiw	a4,a2,-1
 1f8:	1702                	slli	a4,a4,0x20
 1fa:	9301                	srli	a4,a4,0x20
 1fc:	0705                	addi	a4,a4,1
 1fe:	972a                	add	a4,a4,a0
    cdst[i] = c;
 200:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 204:	0785                	addi	a5,a5,1
 206:	fee79de3          	bne	a5,a4,200 <memset+0x16>
  }
  return dst;
}
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret

0000000000000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  for(; *s; s++)
 216:	00054783          	lbu	a5,0(a0)
 21a:	cb99                	beqz	a5,230 <strchr+0x20>
    if(*s == c)
 21c:	00f58763          	beq	a1,a5,22a <strchr+0x1a>
  for(; *s; s++)
 220:	0505                	addi	a0,a0,1
 222:	00054783          	lbu	a5,0(a0)
 226:	fbfd                	bnez	a5,21c <strchr+0xc>
      return (char*)s;
  return 0;
 228:	4501                	li	a0,0
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
  return 0;
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <strchr+0x1a>

0000000000000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	711d                	addi	sp,sp,-96
 236:	ec86                	sd	ra,88(sp)
 238:	e8a2                	sd	s0,80(sp)
 23a:	e4a6                	sd	s1,72(sp)
 23c:	e0ca                	sd	s2,64(sp)
 23e:	fc4e                	sd	s3,56(sp)
 240:	f852                	sd	s4,48(sp)
 242:	f456                	sd	s5,40(sp)
 244:	f05a                	sd	s6,32(sp)
 246:	ec5e                	sd	s7,24(sp)
 248:	1080                	addi	s0,sp,96
 24a:	8baa                	mv	s7,a0
 24c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	892a                	mv	s2,a0
 250:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 252:	4aa9                	li	s5,10
 254:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 256:	89a6                	mv	s3,s1
 258:	2485                	addiw	s1,s1,1
 25a:	0344d863          	bge	s1,s4,28a <gets+0x56>
    cc = read(0, &c, 1);
 25e:	4605                	li	a2,1
 260:	faf40593          	addi	a1,s0,-81
 264:	4501                	li	a0,0
 266:	00000097          	auipc	ra,0x0
 26a:	1a0080e7          	jalr	416(ra) # 406 <read>
    if(cc < 1)
 26e:	00a05e63          	blez	a0,28a <gets+0x56>
    buf[i++] = c;
 272:	faf44783          	lbu	a5,-81(s0)
 276:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 27a:	01578763          	beq	a5,s5,288 <gets+0x54>
 27e:	0905                	addi	s2,s2,1
 280:	fd679be3          	bne	a5,s6,256 <gets+0x22>
  for(i=0; i+1 < max; ){
 284:	89a6                	mv	s3,s1
 286:	a011                	j	28a <gets+0x56>
 288:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 28a:	99de                	add	s3,s3,s7
 28c:	00098023          	sb	zero,0(s3)
  return buf;
}
 290:	855e                	mv	a0,s7
 292:	60e6                	ld	ra,88(sp)
 294:	6446                	ld	s0,80(sp)
 296:	64a6                	ld	s1,72(sp)
 298:	6906                	ld	s2,64(sp)
 29a:	79e2                	ld	s3,56(sp)
 29c:	7a42                	ld	s4,48(sp)
 29e:	7aa2                	ld	s5,40(sp)
 2a0:	7b02                	ld	s6,32(sp)
 2a2:	6be2                	ld	s7,24(sp)
 2a4:	6125                	addi	sp,sp,96
 2a6:	8082                	ret

00000000000002a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a8:	1101                	addi	sp,sp,-32
 2aa:	ec06                	sd	ra,24(sp)
 2ac:	e822                	sd	s0,16(sp)
 2ae:	e426                	sd	s1,8(sp)
 2b0:	e04a                	sd	s2,0(sp)
 2b2:	1000                	addi	s0,sp,32
 2b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	4581                	li	a1,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	176080e7          	jalr	374(ra) # 42e <open>
  if(fd < 0)
 2c0:	02054563          	bltz	a0,2ea <stat+0x42>
 2c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c6:	85ca                	mv	a1,s2
 2c8:	00000097          	auipc	ra,0x0
 2cc:	17e080e7          	jalr	382(ra) # 446 <fstat>
 2d0:	892a                	mv	s2,a0
  close(fd);
 2d2:	8526                	mv	a0,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	142080e7          	jalr	322(ra) # 416 <close>
  return r;
}
 2dc:	854a                	mv	a0,s2
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	64a2                	ld	s1,8(sp)
 2e4:	6902                	ld	s2,0(sp)
 2e6:	6105                	addi	sp,sp,32
 2e8:	8082                	ret
    return -1;
 2ea:	597d                	li	s2,-1
 2ec:	bfc5                	j	2dc <stat+0x34>

00000000000002ee <atoi>:

int
atoi(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f4:	00054603          	lbu	a2,0(a0)
 2f8:	fd06079b          	addiw	a5,a2,-48
 2fc:	0ff7f793          	andi	a5,a5,255
 300:	4725                	li	a4,9
 302:	02f76963          	bltu	a4,a5,334 <atoi+0x46>
 306:	86aa                	mv	a3,a0
  n = 0;
 308:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 30a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 30c:	0685                	addi	a3,a3,1
 30e:	0025179b          	slliw	a5,a0,0x2
 312:	9fa9                	addw	a5,a5,a0
 314:	0017979b          	slliw	a5,a5,0x1
 318:	9fb1                	addw	a5,a5,a2
 31a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 31e:	0006c603          	lbu	a2,0(a3)
 322:	fd06071b          	addiw	a4,a2,-48
 326:	0ff77713          	andi	a4,a4,255
 32a:	fee5f1e3          	bgeu	a1,a4,30c <atoi+0x1e>
  return n;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  n = 0;
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <atoi+0x40>

0000000000000338 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 33e:	02b57663          	bgeu	a0,a1,36a <memmove+0x32>
    while(n-- > 0)
 342:	02c05163          	blez	a2,364 <memmove+0x2c>
 346:	fff6079b          	addiw	a5,a2,-1
 34a:	1782                	slli	a5,a5,0x20
 34c:	9381                	srli	a5,a5,0x20
 34e:	0785                	addi	a5,a5,1
 350:	97aa                	add	a5,a5,a0
  dst = vdst;
 352:	872a                	mv	a4,a0
      *dst++ = *src++;
 354:	0585                	addi	a1,a1,1
 356:	0705                	addi	a4,a4,1
 358:	fff5c683          	lbu	a3,-1(a1)
 35c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 360:	fee79ae3          	bne	a5,a4,354 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
    dst += n;
 36a:	00c50733          	add	a4,a0,a2
    src += n;
 36e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 370:	fec05ae3          	blez	a2,364 <memmove+0x2c>
 374:	fff6079b          	addiw	a5,a2,-1
 378:	1782                	slli	a5,a5,0x20
 37a:	9381                	srli	a5,a5,0x20
 37c:	fff7c793          	not	a5,a5
 380:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 382:	15fd                	addi	a1,a1,-1
 384:	177d                	addi	a4,a4,-1
 386:	0005c683          	lbu	a3,0(a1)
 38a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 38e:	fee79ae3          	bne	a5,a4,382 <memmove+0x4a>
 392:	bfc9                	j	364 <memmove+0x2c>

0000000000000394 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 39a:	ca05                	beqz	a2,3ca <memcmp+0x36>
 39c:	fff6069b          	addiw	a3,a2,-1
 3a0:	1682                	slli	a3,a3,0x20
 3a2:	9281                	srli	a3,a3,0x20
 3a4:	0685                	addi	a3,a3,1
 3a6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	0005c703          	lbu	a4,0(a1)
 3b0:	00e79863          	bne	a5,a4,3c0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3b4:	0505                	addi	a0,a0,1
    p2++;
 3b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3b8:	fed518e3          	bne	a0,a3,3a8 <memcmp+0x14>
  }
  return 0;
 3bc:	4501                	li	a0,0
 3be:	a019                	j	3c4 <memcmp+0x30>
      return *p1 - *p2;
 3c0:	40e7853b          	subw	a0,a5,a4
}
 3c4:	6422                	ld	s0,8(sp)
 3c6:	0141                	addi	sp,sp,16
 3c8:	8082                	ret
  return 0;
 3ca:	4501                	li	a0,0
 3cc:	bfe5                	j	3c4 <memcmp+0x30>

00000000000003ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ce:	1141                	addi	sp,sp,-16
 3d0:	e406                	sd	ra,8(sp)
 3d2:	e022                	sd	s0,0(sp)
 3d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3d6:	00000097          	auipc	ra,0x0
 3da:	f62080e7          	jalr	-158(ra) # 338 <memmove>
}
 3de:	60a2                	ld	ra,8(sp)
 3e0:	6402                	ld	s0,0(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e6:	4885                	li	a7,1
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ee:	4889                	li	a7,2
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f6:	488d                	li	a7,3
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3fe:	4891                	li	a7,4
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <read>:
.global read
read:
 li a7, SYS_read
 406:	4895                	li	a7,5
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <write>:
.global write
write:
 li a7, SYS_write
 40e:	48c1                	li	a7,16
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <close>:
.global close
close:
 li a7, SYS_close
 416:	48d5                	li	a7,21
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <kill>:
.global kill
kill:
 li a7, SYS_kill
 41e:	4899                	li	a7,6
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <exec>:
.global exec
exec:
 li a7, SYS_exec
 426:	489d                	li	a7,7
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <open>:
.global open
open:
 li a7, SYS_open
 42e:	48bd                	li	a7,15
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 436:	48c5                	li	a7,17
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43e:	48c9                	li	a7,18
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 446:	48a1                	li	a7,8
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <link>:
.global link
link:
 li a7, SYS_link
 44e:	48cd                	li	a7,19
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 456:	48d1                	li	a7,20
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 45e:	48a5                	li	a7,9
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <dup>:
.global dup
dup:
 li a7, SYS_dup
 466:	48a9                	li	a7,10
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 46e:	48ad                	li	a7,11
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 476:	48b1                	li	a7,12
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 47e:	48b5                	li	a7,13
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 486:	48b9                	li	a7,14
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 48e:	1101                	addi	sp,sp,-32
 490:	ec06                	sd	ra,24(sp)
 492:	e822                	sd	s0,16(sp)
 494:	1000                	addi	s0,sp,32
 496:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 49a:	4605                	li	a2,1
 49c:	fef40593          	addi	a1,s0,-17
 4a0:	00000097          	auipc	ra,0x0
 4a4:	f6e080e7          	jalr	-146(ra) # 40e <write>
}
 4a8:	60e2                	ld	ra,24(sp)
 4aa:	6442                	ld	s0,16(sp)
 4ac:	6105                	addi	sp,sp,32
 4ae:	8082                	ret

00000000000004b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	7139                	addi	sp,sp,-64
 4b2:	fc06                	sd	ra,56(sp)
 4b4:	f822                	sd	s0,48(sp)
 4b6:	f426                	sd	s1,40(sp)
 4b8:	f04a                	sd	s2,32(sp)
 4ba:	ec4e                	sd	s3,24(sp)
 4bc:	0080                	addi	s0,sp,64
 4be:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c0:	c299                	beqz	a3,4c6 <printint+0x16>
 4c2:	0805c863          	bltz	a1,552 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4c6:	2581                	sext.w	a1,a1
  neg = 0;
 4c8:	4881                	li	a7,0
 4ca:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4ce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4d0:	2601                	sext.w	a2,a2
 4d2:	00000517          	auipc	a0,0x0
 4d6:	46e50513          	addi	a0,a0,1134 # 940 <digits>
 4da:	883a                	mv	a6,a4
 4dc:	2705                	addiw	a4,a4,1
 4de:	02c5f7bb          	remuw	a5,a1,a2
 4e2:	1782                	slli	a5,a5,0x20
 4e4:	9381                	srli	a5,a5,0x20
 4e6:	97aa                	add	a5,a5,a0
 4e8:	0007c783          	lbu	a5,0(a5)
 4ec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4f0:	0005879b          	sext.w	a5,a1
 4f4:	02c5d5bb          	divuw	a1,a1,a2
 4f8:	0685                	addi	a3,a3,1
 4fa:	fec7f0e3          	bgeu	a5,a2,4da <printint+0x2a>
  if(neg)
 4fe:	00088b63          	beqz	a7,514 <printint+0x64>
    buf[i++] = '-';
 502:	fd040793          	addi	a5,s0,-48
 506:	973e                	add	a4,a4,a5
 508:	02d00793          	li	a5,45
 50c:	fef70823          	sb	a5,-16(a4)
 510:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 514:	02e05863          	blez	a4,544 <printint+0x94>
 518:	fc040793          	addi	a5,s0,-64
 51c:	00e78933          	add	s2,a5,a4
 520:	fff78993          	addi	s3,a5,-1
 524:	99ba                	add	s3,s3,a4
 526:	377d                	addiw	a4,a4,-1
 528:	1702                	slli	a4,a4,0x20
 52a:	9301                	srli	a4,a4,0x20
 52c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 530:	fff94583          	lbu	a1,-1(s2)
 534:	8526                	mv	a0,s1
 536:	00000097          	auipc	ra,0x0
 53a:	f58080e7          	jalr	-168(ra) # 48e <putc>
  while(--i >= 0)
 53e:	197d                	addi	s2,s2,-1
 540:	ff3918e3          	bne	s2,s3,530 <printint+0x80>
}
 544:	70e2                	ld	ra,56(sp)
 546:	7442                	ld	s0,48(sp)
 548:	74a2                	ld	s1,40(sp)
 54a:	7902                	ld	s2,32(sp)
 54c:	69e2                	ld	s3,24(sp)
 54e:	6121                	addi	sp,sp,64
 550:	8082                	ret
    x = -xx;
 552:	40b005bb          	negw	a1,a1
    neg = 1;
 556:	4885                	li	a7,1
    x = -xx;
 558:	bf8d                	j	4ca <printint+0x1a>

000000000000055a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 55a:	7119                	addi	sp,sp,-128
 55c:	fc86                	sd	ra,120(sp)
 55e:	f8a2                	sd	s0,112(sp)
 560:	f4a6                	sd	s1,104(sp)
 562:	f0ca                	sd	s2,96(sp)
 564:	ecce                	sd	s3,88(sp)
 566:	e8d2                	sd	s4,80(sp)
 568:	e4d6                	sd	s5,72(sp)
 56a:	e0da                	sd	s6,64(sp)
 56c:	fc5e                	sd	s7,56(sp)
 56e:	f862                	sd	s8,48(sp)
 570:	f466                	sd	s9,40(sp)
 572:	f06a                	sd	s10,32(sp)
 574:	ec6e                	sd	s11,24(sp)
 576:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 578:	0005c903          	lbu	s2,0(a1)
 57c:	18090f63          	beqz	s2,71a <vprintf+0x1c0>
 580:	8aaa                	mv	s5,a0
 582:	8b32                	mv	s6,a2
 584:	00158493          	addi	s1,a1,1
  state = 0;
 588:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 58a:	02500a13          	li	s4,37
      if(c == 'd'){
 58e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 592:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 596:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 59a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 59e:	00000b97          	auipc	s7,0x0
 5a2:	3a2b8b93          	addi	s7,s7,930 # 940 <digits>
 5a6:	a839                	j	5c4 <vprintf+0x6a>
        putc(fd, c);
 5a8:	85ca                	mv	a1,s2
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	ee2080e7          	jalr	-286(ra) # 48e <putc>
 5b4:	a019                	j	5ba <vprintf+0x60>
    } else if(state == '%'){
 5b6:	01498f63          	beq	s3,s4,5d4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5ba:	0485                	addi	s1,s1,1
 5bc:	fff4c903          	lbu	s2,-1(s1)
 5c0:	14090d63          	beqz	s2,71a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5c4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5c8:	fe0997e3          	bnez	s3,5b6 <vprintf+0x5c>
      if(c == '%'){
 5cc:	fd479ee3          	bne	a5,s4,5a8 <vprintf+0x4e>
        state = '%';
 5d0:	89be                	mv	s3,a5
 5d2:	b7e5                	j	5ba <vprintf+0x60>
      if(c == 'd'){
 5d4:	05878063          	beq	a5,s8,614 <vprintf+0xba>
      } else if(c == 'l') {
 5d8:	05978c63          	beq	a5,s9,630 <vprintf+0xd6>
      } else if(c == 'x') {
 5dc:	07a78863          	beq	a5,s10,64c <vprintf+0xf2>
      } else if(c == 'p') {
 5e0:	09b78463          	beq	a5,s11,668 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5e4:	07300713          	li	a4,115
 5e8:	0ce78663          	beq	a5,a4,6b4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ec:	06300713          	li	a4,99
 5f0:	0ee78e63          	beq	a5,a4,6ec <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5f4:	11478863          	beq	a5,s4,704 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f8:	85d2                	mv	a1,s4
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	e92080e7          	jalr	-366(ra) # 48e <putc>
        putc(fd, c);
 604:	85ca                	mv	a1,s2
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e86080e7          	jalr	-378(ra) # 48e <putc>
      }
      state = 0;
 610:	4981                	li	s3,0
 612:	b765                	j	5ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 614:	008b0913          	addi	s2,s6,8
 618:	4685                	li	a3,1
 61a:	4629                	li	a2,10
 61c:	000b2583          	lw	a1,0(s6)
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	e8e080e7          	jalr	-370(ra) # 4b0 <printint>
 62a:	8b4a                	mv	s6,s2
      state = 0;
 62c:	4981                	li	s3,0
 62e:	b771                	j	5ba <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 630:	008b0913          	addi	s2,s6,8
 634:	4681                	li	a3,0
 636:	4629                	li	a2,10
 638:	000b2583          	lw	a1,0(s6)
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e72080e7          	jalr	-398(ra) # 4b0 <printint>
 646:	8b4a                	mv	s6,s2
      state = 0;
 648:	4981                	li	s3,0
 64a:	bf85                	j	5ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 64c:	008b0913          	addi	s2,s6,8
 650:	4681                	li	a3,0
 652:	4641                	li	a2,16
 654:	000b2583          	lw	a1,0(s6)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	e56080e7          	jalr	-426(ra) # 4b0 <printint>
 662:	8b4a                	mv	s6,s2
      state = 0;
 664:	4981                	li	s3,0
 666:	bf91                	j	5ba <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 668:	008b0793          	addi	a5,s6,8
 66c:	f8f43423          	sd	a5,-120(s0)
 670:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 674:	03000593          	li	a1,48
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e14080e7          	jalr	-492(ra) # 48e <putc>
  putc(fd, 'x');
 682:	85ea                	mv	a1,s10
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e08080e7          	jalr	-504(ra) # 48e <putc>
 68e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 690:	03c9d793          	srli	a5,s3,0x3c
 694:	97de                	add	a5,a5,s7
 696:	0007c583          	lbu	a1,0(a5)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	df2080e7          	jalr	-526(ra) # 48e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a4:	0992                	slli	s3,s3,0x4
 6a6:	397d                	addiw	s2,s2,-1
 6a8:	fe0914e3          	bnez	s2,690 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6ac:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b721                	j	5ba <vprintf+0x60>
        s = va_arg(ap, char*);
 6b4:	008b0993          	addi	s3,s6,8
 6b8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6bc:	02090163          	beqz	s2,6de <vprintf+0x184>
        while(*s != 0){
 6c0:	00094583          	lbu	a1,0(s2)
 6c4:	c9a1                	beqz	a1,714 <vprintf+0x1ba>
          putc(fd, *s);
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	dc6080e7          	jalr	-570(ra) # 48e <putc>
          s++;
 6d0:	0905                	addi	s2,s2,1
        while(*s != 0){
 6d2:	00094583          	lbu	a1,0(s2)
 6d6:	f9e5                	bnez	a1,6c6 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6d8:	8b4e                	mv	s6,s3
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	bdf9                	j	5ba <vprintf+0x60>
          s = "(null)";
 6de:	00000917          	auipc	s2,0x0
 6e2:	25a90913          	addi	s2,s2,602 # 938 <malloc+0x114>
        while(*s != 0){
 6e6:	02800593          	li	a1,40
 6ea:	bff1                	j	6c6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6ec:	008b0913          	addi	s2,s6,8
 6f0:	000b4583          	lbu	a1,0(s6)
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	d98080e7          	jalr	-616(ra) # 48e <putc>
 6fe:	8b4a                	mv	s6,s2
      state = 0;
 700:	4981                	li	s3,0
 702:	bd65                	j	5ba <vprintf+0x60>
        putc(fd, c);
 704:	85d2                	mv	a1,s4
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	d86080e7          	jalr	-634(ra) # 48e <putc>
      state = 0;
 710:	4981                	li	s3,0
 712:	b565                	j	5ba <vprintf+0x60>
        s = va_arg(ap, char*);
 714:	8b4e                	mv	s6,s3
      state = 0;
 716:	4981                	li	s3,0
 718:	b54d                	j	5ba <vprintf+0x60>
    }
  }
}
 71a:	70e6                	ld	ra,120(sp)
 71c:	7446                	ld	s0,112(sp)
 71e:	74a6                	ld	s1,104(sp)
 720:	7906                	ld	s2,96(sp)
 722:	69e6                	ld	s3,88(sp)
 724:	6a46                	ld	s4,80(sp)
 726:	6aa6                	ld	s5,72(sp)
 728:	6b06                	ld	s6,64(sp)
 72a:	7be2                	ld	s7,56(sp)
 72c:	7c42                	ld	s8,48(sp)
 72e:	7ca2                	ld	s9,40(sp)
 730:	7d02                	ld	s10,32(sp)
 732:	6de2                	ld	s11,24(sp)
 734:	6109                	addi	sp,sp,128
 736:	8082                	ret

0000000000000738 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 738:	715d                	addi	sp,sp,-80
 73a:	ec06                	sd	ra,24(sp)
 73c:	e822                	sd	s0,16(sp)
 73e:	1000                	addi	s0,sp,32
 740:	e010                	sd	a2,0(s0)
 742:	e414                	sd	a3,8(s0)
 744:	e818                	sd	a4,16(s0)
 746:	ec1c                	sd	a5,24(s0)
 748:	03043023          	sd	a6,32(s0)
 74c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 750:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 754:	8622                	mv	a2,s0
 756:	00000097          	auipc	ra,0x0
 75a:	e04080e7          	jalr	-508(ra) # 55a <vprintf>
}
 75e:	60e2                	ld	ra,24(sp)
 760:	6442                	ld	s0,16(sp)
 762:	6161                	addi	sp,sp,80
 764:	8082                	ret

0000000000000766 <printf>:

void
printf(const char *fmt, ...)
{
 766:	711d                	addi	sp,sp,-96
 768:	ec06                	sd	ra,24(sp)
 76a:	e822                	sd	s0,16(sp)
 76c:	1000                	addi	s0,sp,32
 76e:	e40c                	sd	a1,8(s0)
 770:	e810                	sd	a2,16(s0)
 772:	ec14                	sd	a3,24(s0)
 774:	f018                	sd	a4,32(s0)
 776:	f41c                	sd	a5,40(s0)
 778:	03043823          	sd	a6,48(s0)
 77c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 780:	00840613          	addi	a2,s0,8
 784:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 788:	85aa                	mv	a1,a0
 78a:	4505                	li	a0,1
 78c:	00000097          	auipc	ra,0x0
 790:	dce080e7          	jalr	-562(ra) # 55a <vprintf>
}
 794:	60e2                	ld	ra,24(sp)
 796:	6442                	ld	s0,16(sp)
 798:	6125                	addi	sp,sp,96
 79a:	8082                	ret

000000000000079c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 79c:	1141                	addi	sp,sp,-16
 79e:	e422                	sd	s0,8(sp)
 7a0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a6:	00000797          	auipc	a5,0x0
 7aa:	1b27b783          	ld	a5,434(a5) # 958 <freep>
 7ae:	a805                	j	7de <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b0:	4618                	lw	a4,8(a2)
 7b2:	9db9                	addw	a1,a1,a4
 7b4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b8:	6398                	ld	a4,0(a5)
 7ba:	6318                	ld	a4,0(a4)
 7bc:	fee53823          	sd	a4,-16(a0)
 7c0:	a091                	j	804 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c2:	ff852703          	lw	a4,-8(a0)
 7c6:	9e39                	addw	a2,a2,a4
 7c8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7ca:	ff053703          	ld	a4,-16(a0)
 7ce:	e398                	sd	a4,0(a5)
 7d0:	a099                	j	816 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d2:	6398                	ld	a4,0(a5)
 7d4:	00e7e463          	bltu	a5,a4,7dc <free+0x40>
 7d8:	00e6ea63          	bltu	a3,a4,7ec <free+0x50>
{
 7dc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7de:	fed7fae3          	bgeu	a5,a3,7d2 <free+0x36>
 7e2:	6398                	ld	a4,0(a5)
 7e4:	00e6e463          	bltu	a3,a4,7ec <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e8:	fee7eae3          	bltu	a5,a4,7dc <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7ec:	ff852583          	lw	a1,-8(a0)
 7f0:	6390                	ld	a2,0(a5)
 7f2:	02059713          	slli	a4,a1,0x20
 7f6:	9301                	srli	a4,a4,0x20
 7f8:	0712                	slli	a4,a4,0x4
 7fa:	9736                	add	a4,a4,a3
 7fc:	fae60ae3          	beq	a2,a4,7b0 <free+0x14>
    bp->s.ptr = p->s.ptr;
 800:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 804:	4790                	lw	a2,8(a5)
 806:	02061713          	slli	a4,a2,0x20
 80a:	9301                	srli	a4,a4,0x20
 80c:	0712                	slli	a4,a4,0x4
 80e:	973e                	add	a4,a4,a5
 810:	fae689e3          	beq	a3,a4,7c2 <free+0x26>
  } else
    p->s.ptr = bp;
 814:	e394                	sd	a3,0(a5)
  freep = p;
 816:	00000717          	auipc	a4,0x0
 81a:	14f73123          	sd	a5,322(a4) # 958 <freep>
}
 81e:	6422                	ld	s0,8(sp)
 820:	0141                	addi	sp,sp,16
 822:	8082                	ret

0000000000000824 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 824:	7139                	addi	sp,sp,-64
 826:	fc06                	sd	ra,56(sp)
 828:	f822                	sd	s0,48(sp)
 82a:	f426                	sd	s1,40(sp)
 82c:	f04a                	sd	s2,32(sp)
 82e:	ec4e                	sd	s3,24(sp)
 830:	e852                	sd	s4,16(sp)
 832:	e456                	sd	s5,8(sp)
 834:	e05a                	sd	s6,0(sp)
 836:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 838:	02051493          	slli	s1,a0,0x20
 83c:	9081                	srli	s1,s1,0x20
 83e:	04bd                	addi	s1,s1,15
 840:	8091                	srli	s1,s1,0x4
 842:	0014899b          	addiw	s3,s1,1
 846:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 848:	00000517          	auipc	a0,0x0
 84c:	11053503          	ld	a0,272(a0) # 958 <freep>
 850:	c515                	beqz	a0,87c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 854:	4798                	lw	a4,8(a5)
 856:	02977f63          	bgeu	a4,s1,894 <malloc+0x70>
 85a:	8a4e                	mv	s4,s3
 85c:	0009871b          	sext.w	a4,s3
 860:	6685                	lui	a3,0x1
 862:	00d77363          	bgeu	a4,a3,868 <malloc+0x44>
 866:	6a05                	lui	s4,0x1
 868:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 86c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 870:	00000917          	auipc	s2,0x0
 874:	0e890913          	addi	s2,s2,232 # 958 <freep>
  if(p == (char*)-1)
 878:	5afd                	li	s5,-1
 87a:	a88d                	j	8ec <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 87c:	00000797          	auipc	a5,0x0
 880:	0e478793          	addi	a5,a5,228 # 960 <base>
 884:	00000717          	auipc	a4,0x0
 888:	0cf73a23          	sd	a5,212(a4) # 958 <freep>
 88c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 88e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 892:	b7e1                	j	85a <malloc+0x36>
      if(p->s.size == nunits)
 894:	02e48b63          	beq	s1,a4,8ca <malloc+0xa6>
        p->s.size -= nunits;
 898:	4137073b          	subw	a4,a4,s3
 89c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 89e:	1702                	slli	a4,a4,0x20
 8a0:	9301                	srli	a4,a4,0x20
 8a2:	0712                	slli	a4,a4,0x4
 8a4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8a6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8aa:	00000717          	auipc	a4,0x0
 8ae:	0aa73723          	sd	a0,174(a4) # 958 <freep>
      return (void*)(p + 1);
 8b2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8b6:	70e2                	ld	ra,56(sp)
 8b8:	7442                	ld	s0,48(sp)
 8ba:	74a2                	ld	s1,40(sp)
 8bc:	7902                	ld	s2,32(sp)
 8be:	69e2                	ld	s3,24(sp)
 8c0:	6a42                	ld	s4,16(sp)
 8c2:	6aa2                	ld	s5,8(sp)
 8c4:	6b02                	ld	s6,0(sp)
 8c6:	6121                	addi	sp,sp,64
 8c8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8ca:	6398                	ld	a4,0(a5)
 8cc:	e118                	sd	a4,0(a0)
 8ce:	bff1                	j	8aa <malloc+0x86>
  hp->s.size = nu;
 8d0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8d4:	0541                	addi	a0,a0,16
 8d6:	00000097          	auipc	ra,0x0
 8da:	ec6080e7          	jalr	-314(ra) # 79c <free>
  return freep;
 8de:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8e2:	d971                	beqz	a0,8b6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e6:	4798                	lw	a4,8(a5)
 8e8:	fa9776e3          	bgeu	a4,s1,894 <malloc+0x70>
    if(p == freep)
 8ec:	00093703          	ld	a4,0(s2)
 8f0:	853e                	mv	a0,a5
 8f2:	fef719e3          	bne	a4,a5,8e4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8f6:	8552                	mv	a0,s4
 8f8:	00000097          	auipc	ra,0x0
 8fc:	b7e080e7          	jalr	-1154(ra) # 476 <sbrk>
  if(p == (char*)-1)
 900:	fd5518e3          	bne	a0,s5,8d0 <malloc+0xac>
        return 0;
 904:	4501                	li	a0,0
 906:	bf45                	j	8b6 <malloc+0x92>
