
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
	strcpy(target+1, argv[2]);
	find(argv[1], target);
	exit(0);
}

void find(char *path, char *target) {
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	23813823          	sd	s8,560(sp)
  2c:	0500                	addi	s0,sp,640
  2e:	892a                	mv	s2,a0
  30:	89ae                	mv	s3,a1
    char *p = buf;
    int fd;
    struct dirent de;  //dirent结构体存储目录信息，当fd是一个文件目录时，可用read从该fd中读取该目录包含的文件的dirent
    struct stat st;    //stat结构体存储文件属性，用fstat函数从fd中获取

    if( (fd = open(path, 0)) < 0){
  32:	4581                	li	a1,0
  34:	00000097          	auipc	ra,0x0
  38:	530080e7          	jalr	1328(ra) # 564 <open>
  3c:	84aa                	mv	s1,a0
  3e:	08054a63          	bltz	a0,d2 <find+0xd2>
        fprintf(2, "open error: can't open %s\n", path);
        close(fd);
        return;
    }

    if( fstat(fd, &st) < 0){
  42:	d8840593          	addi	a1,s0,-632
  46:	00000097          	auipc	ra,0x0
  4a:	536080e7          	jalr	1334(ra) # 57c <fstat>
  4e:	0a054263          	bltz	a0,f2 <find+0xf2>
        fprintf(2, "fstat error: can't get stat from %s\n", path);
        close(fd);
        return;
    }

	switch(st.type){
  52:	d9041783          	lh	a5,-624(s0)
  56:	0007869b          	sext.w	a3,a5
  5a:	4705                	li	a4,1
  5c:	0ce68563          	beq	a3,a4,126 <find+0x126>
  60:	4709                	li	a4,2
  62:	02e69c63          	bne	a3,a4,9a <find+0x9a>
        case T_FILE: //fd打开的是一个文件
            p = path + strlen(path) - strlen(target);
  66:	854a                	mv	a0,s2
  68:	00000097          	auipc	ra,0x0
  6c:	28e080e7          	jalr	654(ra) # 2f6 <strlen>
  70:	00050a1b          	sext.w	s4,a0
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	280080e7          	jalr	640(ra) # 2f6 <strlen>
  7e:	1a02                	slli	s4,s4,0x20
  80:	020a5a13          	srli	s4,s4,0x20
  84:	1502                	slli	a0,a0,0x20
  86:	9101                	srli	a0,a0,0x20
  88:	40aa0533          	sub	a0,s4,a0
            if( strcmp(p, target) == 0){ //如果path结尾与/target相等，则成功匹配到一个符合文件
  8c:	85ce                	mv	a1,s3
  8e:	954a                	add	a0,a0,s2
  90:	00000097          	auipc	ra,0x0
  94:	23a080e7          	jalr	570(ra) # 2ca <strcmp>
  98:	cd2d                	beqz	a0,112 <find+0x112>
                    find(buf, target); // 递归查找
                }
            }
            break;
        }
	close(fd);
  9a:	8526                	mv	a0,s1
  9c:	00000097          	auipc	ra,0x0
  a0:	4b0080e7          	jalr	1200(ra) # 54c <close>
}
  a4:	27813083          	ld	ra,632(sp)
  a8:	27013403          	ld	s0,624(sp)
  ac:	26813483          	ld	s1,616(sp)
  b0:	26013903          	ld	s2,608(sp)
  b4:	25813983          	ld	s3,600(sp)
  b8:	25013a03          	ld	s4,592(sp)
  bc:	24813a83          	ld	s5,584(sp)
  c0:	24013b03          	ld	s6,576(sp)
  c4:	23813b83          	ld	s7,568(sp)
  c8:	23013c03          	ld	s8,560(sp)
  cc:	28010113          	addi	sp,sp,640
  d0:	8082                	ret
        fprintf(2, "open error: can't open %s\n", path);
  d2:	864a                	mv	a2,s2
  d4:	00001597          	auipc	a1,0x1
  d8:	96c58593          	addi	a1,a1,-1684 # a40 <malloc+0xe6>
  dc:	4509                	li	a0,2
  de:	00000097          	auipc	ra,0x0
  e2:	790080e7          	jalr	1936(ra) # 86e <fprintf>
        close(fd);
  e6:	8526                	mv	a0,s1
  e8:	00000097          	auipc	ra,0x0
  ec:	464080e7          	jalr	1124(ra) # 54c <close>
        return;
  f0:	bf55                	j	a4 <find+0xa4>
        fprintf(2, "fstat error: can't get stat from %s\n", path);
  f2:	864a                	mv	a2,s2
  f4:	00001597          	auipc	a1,0x1
  f8:	96c58593          	addi	a1,a1,-1684 # a60 <malloc+0x106>
  fc:	4509                	li	a0,2
  fe:	00000097          	auipc	ra,0x0
 102:	770080e7          	jalr	1904(ra) # 86e <fprintf>
        close(fd);
 106:	8526                	mv	a0,s1
 108:	00000097          	auipc	ra,0x0
 10c:	444080e7          	jalr	1092(ra) # 54c <close>
        return;
 110:	bf51                	j	a4 <find+0xa4>
                printf("%s\n", path);
 112:	85ca                	mv	a1,s2
 114:	00001517          	auipc	a0,0x1
 118:	97450513          	addi	a0,a0,-1676 # a88 <malloc+0x12e>
 11c:	00000097          	auipc	ra,0x0
 120:	780080e7          	jalr	1920(ra) # 89c <printf>
 124:	bf9d                	j	9a <find+0x9a>
            if( strlen(path) +1 + DIRSIZ +1 > sizeof(buf)){
 126:	854a                	mv	a0,s2
 128:	00000097          	auipc	ra,0x0
 12c:	1ce080e7          	jalr	462(ra) # 2f6 <strlen>
 130:	2541                	addiw	a0,a0,16
 132:	20000793          	li	a5,512
 136:	00a7fc63          	bgeu	a5,a0,14e <find+0x14e>
                fprintf(2, "find error: path too long\n");
 13a:	00001597          	auipc	a1,0x1
 13e:	95658593          	addi	a1,a1,-1706 # a90 <malloc+0x136>
 142:	4509                	li	a0,2
 144:	00000097          	auipc	ra,0x0
 148:	72a080e7          	jalr	1834(ra) # 86e <fprintf>
                break;
 14c:	b7b9                	j	9a <find+0x9a>
            strcpy(buf, path);
 14e:	85ca                	mv	a1,s2
 150:	db040513          	addi	a0,s0,-592
 154:	00000097          	auipc	ra,0x0
 158:	15a080e7          	jalr	346(ra) # 2ae <strcpy>
            p = buf + strlen(buf);
 15c:	db040513          	addi	a0,s0,-592
 160:	00000097          	auipc	ra,0x0
 164:	196080e7          	jalr	406(ra) # 2f6 <strlen>
 168:	02051913          	slli	s2,a0,0x20
 16c:	02095913          	srli	s2,s2,0x20
 170:	db040793          	addi	a5,s0,-592
 174:	993e                	add	s2,s2,a5
            *p = '/';
 176:	02f00793          	li	a5,47
 17a:	00f90023          	sb	a5,0(s2)
            ++p;
 17e:	00190a93          	addi	s5,s2,1
                p[DIRSIZ]= '0';
 182:	03000a13          	li	s4,48
                if(strcmp(buf+strlen(buf)-2, "/.") != 0 && strcmp(buf+strlen(buf)-3, "/..") != 0) {
 186:	00001b17          	auipc	s6,0x1
 18a:	942b0b13          	addi	s6,s6,-1726 # ac8 <malloc+0x16e>
 18e:	00001c17          	auipc	s8,0x1
 192:	942c0c13          	addi	s8,s8,-1726 # ad0 <malloc+0x176>
                    printf("find: cannot stat %s\n", buf);
 196:	00001b97          	auipc	s7,0x1
 19a:	91ab8b93          	addi	s7,s7,-1766 # ab0 <malloc+0x156>
            while(read(fd, &de, sizeof(de)) == sizeof(de)){   //每次从 当前目录 读取 该目录中 一个文件的dirent信息， 存入de
 19e:	4641                	li	a2,16
 1a0:	da040593          	addi	a1,s0,-608
 1a4:	8526                	mv	a0,s1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	396080e7          	jalr	918(ra) # 53c <read>
 1ae:	47c1                	li	a5,16
 1b0:	eef515e3          	bne	a0,a5,9a <find+0x9a>
                if(de.inum == 0) continue;
 1b4:	da045783          	lhu	a5,-608(s0)
 1b8:	d3fd                	beqz	a5,19e <find+0x19e>
                memmove(p, de.name, DIRSIZ);  //把读取到的文件名拼接到buf的末尾，buf成为下一层递归的path
 1ba:	4639                	li	a2,14
 1bc:	da240593          	addi	a1,s0,-606
 1c0:	8556                	mv	a0,s5
 1c2:	00000097          	auipc	ra,0x0
 1c6:	2ac080e7          	jalr	684(ra) # 46e <memmove>
                p[DIRSIZ]= '0';
 1ca:	014907a3          	sb	s4,15(s2)
                if(stat(buf, &st) < 0){
 1ce:	d8840593          	addi	a1,s0,-632
 1d2:	db040513          	addi	a0,s0,-592
 1d6:	00000097          	auipc	ra,0x0
 1da:	208080e7          	jalr	520(ra) # 3de <stat>
 1de:	04054e63          	bltz	a0,23a <find+0x23a>
                if(strcmp(buf+strlen(buf)-2, "/.") != 0 && strcmp(buf+strlen(buf)-3, "/..") != 0) {
 1e2:	db040513          	addi	a0,s0,-592
 1e6:	00000097          	auipc	ra,0x0
 1ea:	110080e7          	jalr	272(ra) # 2f6 <strlen>
 1ee:	1502                	slli	a0,a0,0x20
 1f0:	9101                	srli	a0,a0,0x20
 1f2:	1579                	addi	a0,a0,-2
 1f4:	85da                	mv	a1,s6
 1f6:	db040793          	addi	a5,s0,-592
 1fa:	953e                	add	a0,a0,a5
 1fc:	00000097          	auipc	ra,0x0
 200:	0ce080e7          	jalr	206(ra) # 2ca <strcmp>
 204:	dd49                	beqz	a0,19e <find+0x19e>
 206:	db040513          	addi	a0,s0,-592
 20a:	00000097          	auipc	ra,0x0
 20e:	0ec080e7          	jalr	236(ra) # 2f6 <strlen>
 212:	1502                	slli	a0,a0,0x20
 214:	9101                	srli	a0,a0,0x20
 216:	1575                	addi	a0,a0,-3
 218:	85e2                	mv	a1,s8
 21a:	db040793          	addi	a5,s0,-592
 21e:	953e                	add	a0,a0,a5
 220:	00000097          	auipc	ra,0x0
 224:	0aa080e7          	jalr	170(ra) # 2ca <strcmp>
 228:	d93d                	beqz	a0,19e <find+0x19e>
                    find(buf, target); // 递归查找
 22a:	85ce                	mv	a1,s3
 22c:	db040513          	addi	a0,s0,-592
 230:	00000097          	auipc	ra,0x0
 234:	dd0080e7          	jalr	-560(ra) # 0 <find>
 238:	b79d                	j	19e <find+0x19e>
                    printf("find: cannot stat %s\n", buf);
 23a:	db040593          	addi	a1,s0,-592
 23e:	855e                	mv	a0,s7
 240:	00000097          	auipc	ra,0x0
 244:	65c080e7          	jalr	1628(ra) # 89c <printf>
                    continue;
 248:	bf99                	j	19e <find+0x19e>

000000000000024a <main>:
{
 24a:	de010113          	addi	sp,sp,-544
 24e:	20113c23          	sd	ra,536(sp)
 252:	20813823          	sd	s0,528(sp)
 256:	20913423          	sd	s1,520(sp)
 25a:	1400                	addi	s0,sp,544
	if(argc < 3){
 25c:	4789                	li	a5,2
 25e:	02a7c063          	blt	a5,a0,27e <main+0x34>
        fprintf(2, "usage: find <path> <target>\n");
 262:	00001597          	auipc	a1,0x1
 266:	87658593          	addi	a1,a1,-1930 # ad8 <malloc+0x17e>
 26a:	4509                	li	a0,2
 26c:	00000097          	auipc	ra,0x0
 270:	602080e7          	jalr	1538(ra) # 86e <fprintf>
		exit(0);
 274:	4501                	li	a0,0
 276:	00000097          	auipc	ra,0x0
 27a:	2ae080e7          	jalr	686(ra) # 524 <exit>
 27e:	84ae                	mv	s1,a1
	target[0] = '/';   //为想要查找的文件名(target)添加 / 
 280:	02f00793          	li	a5,47
 284:	def40023          	sb	a5,-544(s0)
	strcpy(target+1, argv[2]);
 288:	698c                	ld	a1,16(a1)
 28a:	de140513          	addi	a0,s0,-543
 28e:	00000097          	auipc	ra,0x0
 292:	020080e7          	jalr	32(ra) # 2ae <strcpy>
	find(argv[1], target);
 296:	de040593          	addi	a1,s0,-544
 29a:	6488                	ld	a0,8(s1)
 29c:	00000097          	auipc	ra,0x0
 2a0:	d64080e7          	jalr	-668(ra) # 0 <find>
	exit(0);
 2a4:	4501                	li	a0,0
 2a6:	00000097          	auipc	ra,0x0
 2aa:	27e080e7          	jalr	638(ra) # 524 <exit>

00000000000002ae <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b4:	87aa                	mv	a5,a0
 2b6:	0585                	addi	a1,a1,1
 2b8:	0785                	addi	a5,a5,1
 2ba:	fff5c703          	lbu	a4,-1(a1)
 2be:	fee78fa3          	sb	a4,-1(a5)
 2c2:	fb75                	bnez	a4,2b6 <strcpy+0x8>
    ;
  return os;
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	cb91                	beqz	a5,2e8 <strcmp+0x1e>
 2d6:	0005c703          	lbu	a4,0(a1)
 2da:	00f71763          	bne	a4,a5,2e8 <strcmp+0x1e>
    p++, q++;
 2de:	0505                	addi	a0,a0,1
 2e0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	fbe5                	bnez	a5,2d6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2e8:	0005c503          	lbu	a0,0(a1)
}
 2ec:	40a7853b          	subw	a0,a5,a0
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strlen>:

uint
strlen(const char *s)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2fc:	00054783          	lbu	a5,0(a0)
 300:	cf91                	beqz	a5,31c <strlen+0x26>
 302:	0505                	addi	a0,a0,1
 304:	87aa                	mv	a5,a0
 306:	4685                	li	a3,1
 308:	9e89                	subw	a3,a3,a0
 30a:	00f6853b          	addw	a0,a3,a5
 30e:	0785                	addi	a5,a5,1
 310:	fff7c703          	lbu	a4,-1(a5)
 314:	fb7d                	bnez	a4,30a <strlen+0x14>
    ;
  return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  for(n = 0; s[n]; n++)
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <strlen+0x20>

0000000000000320 <memset>:

void*
memset(void *dst, int c, uint n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 326:	ce09                	beqz	a2,340 <memset+0x20>
 328:	87aa                	mv	a5,a0
 32a:	fff6071b          	addiw	a4,a2,-1
 32e:	1702                	slli	a4,a4,0x20
 330:	9301                	srli	a4,a4,0x20
 332:	0705                	addi	a4,a4,1
 334:	972a                	add	a4,a4,a0
    cdst[i] = c;
 336:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 33a:	0785                	addi	a5,a5,1
 33c:	fee79de3          	bne	a5,a4,336 <memset+0x16>
  }
  return dst;
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret

0000000000000346 <strchr>:

char*
strchr(const char *s, char c)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 34c:	00054783          	lbu	a5,0(a0)
 350:	cb99                	beqz	a5,366 <strchr+0x20>
    if(*s == c)
 352:	00f58763          	beq	a1,a5,360 <strchr+0x1a>
  for(; *s; s++)
 356:	0505                	addi	a0,a0,1
 358:	00054783          	lbu	a5,0(a0)
 35c:	fbfd                	bnez	a5,352 <strchr+0xc>
      return (char*)s;
  return 0;
 35e:	4501                	li	a0,0
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret
  return 0;
 366:	4501                	li	a0,0
 368:	bfe5                	j	360 <strchr+0x1a>

000000000000036a <gets>:

char*
gets(char *buf, int max)
{
 36a:	711d                	addi	sp,sp,-96
 36c:	ec86                	sd	ra,88(sp)
 36e:	e8a2                	sd	s0,80(sp)
 370:	e4a6                	sd	s1,72(sp)
 372:	e0ca                	sd	s2,64(sp)
 374:	fc4e                	sd	s3,56(sp)
 376:	f852                	sd	s4,48(sp)
 378:	f456                	sd	s5,40(sp)
 37a:	f05a                	sd	s6,32(sp)
 37c:	ec5e                	sd	s7,24(sp)
 37e:	1080                	addi	s0,sp,96
 380:	8baa                	mv	s7,a0
 382:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 384:	892a                	mv	s2,a0
 386:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 388:	4aa9                	li	s5,10
 38a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 38c:	89a6                	mv	s3,s1
 38e:	2485                	addiw	s1,s1,1
 390:	0344d863          	bge	s1,s4,3c0 <gets+0x56>
    cc = read(0, &c, 1);
 394:	4605                	li	a2,1
 396:	faf40593          	addi	a1,s0,-81
 39a:	4501                	li	a0,0
 39c:	00000097          	auipc	ra,0x0
 3a0:	1a0080e7          	jalr	416(ra) # 53c <read>
    if(cc < 1)
 3a4:	00a05e63          	blez	a0,3c0 <gets+0x56>
    buf[i++] = c;
 3a8:	faf44783          	lbu	a5,-81(s0)
 3ac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3b0:	01578763          	beq	a5,s5,3be <gets+0x54>
 3b4:	0905                	addi	s2,s2,1
 3b6:	fd679be3          	bne	a5,s6,38c <gets+0x22>
  for(i=0; i+1 < max; ){
 3ba:	89a6                	mv	s3,s1
 3bc:	a011                	j	3c0 <gets+0x56>
 3be:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3c0:	99de                	add	s3,s3,s7
 3c2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3c6:	855e                	mv	a0,s7
 3c8:	60e6                	ld	ra,88(sp)
 3ca:	6446                	ld	s0,80(sp)
 3cc:	64a6                	ld	s1,72(sp)
 3ce:	6906                	ld	s2,64(sp)
 3d0:	79e2                	ld	s3,56(sp)
 3d2:	7a42                	ld	s4,48(sp)
 3d4:	7aa2                	ld	s5,40(sp)
 3d6:	7b02                	ld	s6,32(sp)
 3d8:	6be2                	ld	s7,24(sp)
 3da:	6125                	addi	sp,sp,96
 3dc:	8082                	ret

00000000000003de <stat>:

int
stat(const char *n, struct stat *st)
{
 3de:	1101                	addi	sp,sp,-32
 3e0:	ec06                	sd	ra,24(sp)
 3e2:	e822                	sd	s0,16(sp)
 3e4:	e426                	sd	s1,8(sp)
 3e6:	e04a                	sd	s2,0(sp)
 3e8:	1000                	addi	s0,sp,32
 3ea:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ec:	4581                	li	a1,0
 3ee:	00000097          	auipc	ra,0x0
 3f2:	176080e7          	jalr	374(ra) # 564 <open>
  if(fd < 0)
 3f6:	02054563          	bltz	a0,420 <stat+0x42>
 3fa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3fc:	85ca                	mv	a1,s2
 3fe:	00000097          	auipc	ra,0x0
 402:	17e080e7          	jalr	382(ra) # 57c <fstat>
 406:	892a                	mv	s2,a0
  close(fd);
 408:	8526                	mv	a0,s1
 40a:	00000097          	auipc	ra,0x0
 40e:	142080e7          	jalr	322(ra) # 54c <close>
  return r;
}
 412:	854a                	mv	a0,s2
 414:	60e2                	ld	ra,24(sp)
 416:	6442                	ld	s0,16(sp)
 418:	64a2                	ld	s1,8(sp)
 41a:	6902                	ld	s2,0(sp)
 41c:	6105                	addi	sp,sp,32
 41e:	8082                	ret
    return -1;
 420:	597d                	li	s2,-1
 422:	bfc5                	j	412 <stat+0x34>

0000000000000424 <atoi>:

int
atoi(const char *s)
{
 424:	1141                	addi	sp,sp,-16
 426:	e422                	sd	s0,8(sp)
 428:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 42a:	00054603          	lbu	a2,0(a0)
 42e:	fd06079b          	addiw	a5,a2,-48
 432:	0ff7f793          	andi	a5,a5,255
 436:	4725                	li	a4,9
 438:	02f76963          	bltu	a4,a5,46a <atoi+0x46>
 43c:	86aa                	mv	a3,a0
  n = 0;
 43e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 440:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 442:	0685                	addi	a3,a3,1
 444:	0025179b          	slliw	a5,a0,0x2
 448:	9fa9                	addw	a5,a5,a0
 44a:	0017979b          	slliw	a5,a5,0x1
 44e:	9fb1                	addw	a5,a5,a2
 450:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 454:	0006c603          	lbu	a2,0(a3)
 458:	fd06071b          	addiw	a4,a2,-48
 45c:	0ff77713          	andi	a4,a4,255
 460:	fee5f1e3          	bgeu	a1,a4,442 <atoi+0x1e>
  return n;
}
 464:	6422                	ld	s0,8(sp)
 466:	0141                	addi	sp,sp,16
 468:	8082                	ret
  n = 0;
 46a:	4501                	li	a0,0
 46c:	bfe5                	j	464 <atoi+0x40>

000000000000046e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 46e:	1141                	addi	sp,sp,-16
 470:	e422                	sd	s0,8(sp)
 472:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 474:	02b57663          	bgeu	a0,a1,4a0 <memmove+0x32>
    while(n-- > 0)
 478:	02c05163          	blez	a2,49a <memmove+0x2c>
 47c:	fff6079b          	addiw	a5,a2,-1
 480:	1782                	slli	a5,a5,0x20
 482:	9381                	srli	a5,a5,0x20
 484:	0785                	addi	a5,a5,1
 486:	97aa                	add	a5,a5,a0
  dst = vdst;
 488:	872a                	mv	a4,a0
      *dst++ = *src++;
 48a:	0585                	addi	a1,a1,1
 48c:	0705                	addi	a4,a4,1
 48e:	fff5c683          	lbu	a3,-1(a1)
 492:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 496:	fee79ae3          	bne	a5,a4,48a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	addi	sp,sp,16
 49e:	8082                	ret
    dst += n;
 4a0:	00c50733          	add	a4,a0,a2
    src += n;
 4a4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4a6:	fec05ae3          	blez	a2,49a <memmove+0x2c>
 4aa:	fff6079b          	addiw	a5,a2,-1
 4ae:	1782                	slli	a5,a5,0x20
 4b0:	9381                	srli	a5,a5,0x20
 4b2:	fff7c793          	not	a5,a5
 4b6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4b8:	15fd                	addi	a1,a1,-1
 4ba:	177d                	addi	a4,a4,-1
 4bc:	0005c683          	lbu	a3,0(a1)
 4c0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4c4:	fee79ae3          	bne	a5,a4,4b8 <memmove+0x4a>
 4c8:	bfc9                	j	49a <memmove+0x2c>

00000000000004ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ca:	1141                	addi	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4d0:	ca05                	beqz	a2,500 <memcmp+0x36>
 4d2:	fff6069b          	addiw	a3,a2,-1
 4d6:	1682                	slli	a3,a3,0x20
 4d8:	9281                	srli	a3,a3,0x20
 4da:	0685                	addi	a3,a3,1
 4dc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4de:	00054783          	lbu	a5,0(a0)
 4e2:	0005c703          	lbu	a4,0(a1)
 4e6:	00e79863          	bne	a5,a4,4f6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4ea:	0505                	addi	a0,a0,1
    p2++;
 4ec:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ee:	fed518e3          	bne	a0,a3,4de <memcmp+0x14>
  }
  return 0;
 4f2:	4501                	li	a0,0
 4f4:	a019                	j	4fa <memcmp+0x30>
      return *p1 - *p2;
 4f6:	40e7853b          	subw	a0,a5,a4
}
 4fa:	6422                	ld	s0,8(sp)
 4fc:	0141                	addi	sp,sp,16
 4fe:	8082                	ret
  return 0;
 500:	4501                	li	a0,0
 502:	bfe5                	j	4fa <memcmp+0x30>

0000000000000504 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 504:	1141                	addi	sp,sp,-16
 506:	e406                	sd	ra,8(sp)
 508:	e022                	sd	s0,0(sp)
 50a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 50c:	00000097          	auipc	ra,0x0
 510:	f62080e7          	jalr	-158(ra) # 46e <memmove>
}
 514:	60a2                	ld	ra,8(sp)
 516:	6402                	ld	s0,0(sp)
 518:	0141                	addi	sp,sp,16
 51a:	8082                	ret

000000000000051c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 51c:	4885                	li	a7,1
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <exit>:
.global exit
exit:
 li a7, SYS_exit
 524:	4889                	li	a7,2
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <wait>:
.global wait
wait:
 li a7, SYS_wait
 52c:	488d                	li	a7,3
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 534:	4891                	li	a7,4
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <read>:
.global read
read:
 li a7, SYS_read
 53c:	4895                	li	a7,5
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <write>:
.global write
write:
 li a7, SYS_write
 544:	48c1                	li	a7,16
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <close>:
.global close
close:
 li a7, SYS_close
 54c:	48d5                	li	a7,21
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <kill>:
.global kill
kill:
 li a7, SYS_kill
 554:	4899                	li	a7,6
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <exec>:
.global exec
exec:
 li a7, SYS_exec
 55c:	489d                	li	a7,7
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <open>:
.global open
open:
 li a7, SYS_open
 564:	48bd                	li	a7,15
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 56c:	48c5                	li	a7,17
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 574:	48c9                	li	a7,18
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 57c:	48a1                	li	a7,8
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <link>:
.global link
link:
 li a7, SYS_link
 584:	48cd                	li	a7,19
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 58c:	48d1                	li	a7,20
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 594:	48a5                	li	a7,9
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <dup>:
.global dup
dup:
 li a7, SYS_dup
 59c:	48a9                	li	a7,10
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a4:	48ad                	li	a7,11
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ac:	48b1                	li	a7,12
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b4:	48b5                	li	a7,13
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5bc:	48b9                	li	a7,14
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c4:	1101                	addi	sp,sp,-32
 5c6:	ec06                	sd	ra,24(sp)
 5c8:	e822                	sd	s0,16(sp)
 5ca:	1000                	addi	s0,sp,32
 5cc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d0:	4605                	li	a2,1
 5d2:	fef40593          	addi	a1,s0,-17
 5d6:	00000097          	auipc	ra,0x0
 5da:	f6e080e7          	jalr	-146(ra) # 544 <write>
}
 5de:	60e2                	ld	ra,24(sp)
 5e0:	6442                	ld	s0,16(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret

00000000000005e6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e6:	7139                	addi	sp,sp,-64
 5e8:	fc06                	sd	ra,56(sp)
 5ea:	f822                	sd	s0,48(sp)
 5ec:	f426                	sd	s1,40(sp)
 5ee:	f04a                	sd	s2,32(sp)
 5f0:	ec4e                	sd	s3,24(sp)
 5f2:	0080                	addi	s0,sp,64
 5f4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f6:	c299                	beqz	a3,5fc <printint+0x16>
 5f8:	0805c863          	bltz	a1,688 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fc:	2581                	sext.w	a1,a1
  neg = 0;
 5fe:	4881                	li	a7,0
 600:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 604:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 606:	2601                	sext.w	a2,a2
 608:	00000517          	auipc	a0,0x0
 60c:	4f850513          	addi	a0,a0,1272 # b00 <digits>
 610:	883a                	mv	a6,a4
 612:	2705                	addiw	a4,a4,1
 614:	02c5f7bb          	remuw	a5,a1,a2
 618:	1782                	slli	a5,a5,0x20
 61a:	9381                	srli	a5,a5,0x20
 61c:	97aa                	add	a5,a5,a0
 61e:	0007c783          	lbu	a5,0(a5)
 622:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 626:	0005879b          	sext.w	a5,a1
 62a:	02c5d5bb          	divuw	a1,a1,a2
 62e:	0685                	addi	a3,a3,1
 630:	fec7f0e3          	bgeu	a5,a2,610 <printint+0x2a>
  if(neg)
 634:	00088b63          	beqz	a7,64a <printint+0x64>
    buf[i++] = '-';
 638:	fd040793          	addi	a5,s0,-48
 63c:	973e                	add	a4,a4,a5
 63e:	02d00793          	li	a5,45
 642:	fef70823          	sb	a5,-16(a4)
 646:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 64a:	02e05863          	blez	a4,67a <printint+0x94>
 64e:	fc040793          	addi	a5,s0,-64
 652:	00e78933          	add	s2,a5,a4
 656:	fff78993          	addi	s3,a5,-1
 65a:	99ba                	add	s3,s3,a4
 65c:	377d                	addiw	a4,a4,-1
 65e:	1702                	slli	a4,a4,0x20
 660:	9301                	srli	a4,a4,0x20
 662:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 666:	fff94583          	lbu	a1,-1(s2)
 66a:	8526                	mv	a0,s1
 66c:	00000097          	auipc	ra,0x0
 670:	f58080e7          	jalr	-168(ra) # 5c4 <putc>
  while(--i >= 0)
 674:	197d                	addi	s2,s2,-1
 676:	ff3918e3          	bne	s2,s3,666 <printint+0x80>
}
 67a:	70e2                	ld	ra,56(sp)
 67c:	7442                	ld	s0,48(sp)
 67e:	74a2                	ld	s1,40(sp)
 680:	7902                	ld	s2,32(sp)
 682:	69e2                	ld	s3,24(sp)
 684:	6121                	addi	sp,sp,64
 686:	8082                	ret
    x = -xx;
 688:	40b005bb          	negw	a1,a1
    neg = 1;
 68c:	4885                	li	a7,1
    x = -xx;
 68e:	bf8d                	j	600 <printint+0x1a>

0000000000000690 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 690:	7119                	addi	sp,sp,-128
 692:	fc86                	sd	ra,120(sp)
 694:	f8a2                	sd	s0,112(sp)
 696:	f4a6                	sd	s1,104(sp)
 698:	f0ca                	sd	s2,96(sp)
 69a:	ecce                	sd	s3,88(sp)
 69c:	e8d2                	sd	s4,80(sp)
 69e:	e4d6                	sd	s5,72(sp)
 6a0:	e0da                	sd	s6,64(sp)
 6a2:	fc5e                	sd	s7,56(sp)
 6a4:	f862                	sd	s8,48(sp)
 6a6:	f466                	sd	s9,40(sp)
 6a8:	f06a                	sd	s10,32(sp)
 6aa:	ec6e                	sd	s11,24(sp)
 6ac:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ae:	0005c903          	lbu	s2,0(a1)
 6b2:	18090f63          	beqz	s2,850 <vprintf+0x1c0>
 6b6:	8aaa                	mv	s5,a0
 6b8:	8b32                	mv	s6,a2
 6ba:	00158493          	addi	s1,a1,1
  state = 0;
 6be:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6c0:	02500a13          	li	s4,37
      if(c == 'd'){
 6c4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6c8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6cc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6d0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d4:	00000b97          	auipc	s7,0x0
 6d8:	42cb8b93          	addi	s7,s7,1068 # b00 <digits>
 6dc:	a839                	j	6fa <vprintf+0x6a>
        putc(fd, c);
 6de:	85ca                	mv	a1,s2
 6e0:	8556                	mv	a0,s5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	ee2080e7          	jalr	-286(ra) # 5c4 <putc>
 6ea:	a019                	j	6f0 <vprintf+0x60>
    } else if(state == '%'){
 6ec:	01498f63          	beq	s3,s4,70a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6f0:	0485                	addi	s1,s1,1
 6f2:	fff4c903          	lbu	s2,-1(s1)
 6f6:	14090d63          	beqz	s2,850 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6fa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6fe:	fe0997e3          	bnez	s3,6ec <vprintf+0x5c>
      if(c == '%'){
 702:	fd479ee3          	bne	a5,s4,6de <vprintf+0x4e>
        state = '%';
 706:	89be                	mv	s3,a5
 708:	b7e5                	j	6f0 <vprintf+0x60>
      if(c == 'd'){
 70a:	05878063          	beq	a5,s8,74a <vprintf+0xba>
      } else if(c == 'l') {
 70e:	05978c63          	beq	a5,s9,766 <vprintf+0xd6>
      } else if(c == 'x') {
 712:	07a78863          	beq	a5,s10,782 <vprintf+0xf2>
      } else if(c == 'p') {
 716:	09b78463          	beq	a5,s11,79e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 71a:	07300713          	li	a4,115
 71e:	0ce78663          	beq	a5,a4,7ea <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 722:	06300713          	li	a4,99
 726:	0ee78e63          	beq	a5,a4,822 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 72a:	11478863          	beq	a5,s4,83a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 72e:	85d2                	mv	a1,s4
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	e92080e7          	jalr	-366(ra) # 5c4 <putc>
        putc(fd, c);
 73a:	85ca                	mv	a1,s2
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e86080e7          	jalr	-378(ra) # 5c4 <putc>
      }
      state = 0;
 746:	4981                	li	s3,0
 748:	b765                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 74a:	008b0913          	addi	s2,s6,8
 74e:	4685                	li	a3,1
 750:	4629                	li	a2,10
 752:	000b2583          	lw	a1,0(s6)
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	e8e080e7          	jalr	-370(ra) # 5e6 <printint>
 760:	8b4a                	mv	s6,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	b771                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 766:	008b0913          	addi	s2,s6,8
 76a:	4681                	li	a3,0
 76c:	4629                	li	a2,10
 76e:	000b2583          	lw	a1,0(s6)
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	e72080e7          	jalr	-398(ra) # 5e6 <printint>
 77c:	8b4a                	mv	s6,s2
      state = 0;
 77e:	4981                	li	s3,0
 780:	bf85                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 782:	008b0913          	addi	s2,s6,8
 786:	4681                	li	a3,0
 788:	4641                	li	a2,16
 78a:	000b2583          	lw	a1,0(s6)
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	e56080e7          	jalr	-426(ra) # 5e6 <printint>
 798:	8b4a                	mv	s6,s2
      state = 0;
 79a:	4981                	li	s3,0
 79c:	bf91                	j	6f0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 79e:	008b0793          	addi	a5,s6,8
 7a2:	f8f43423          	sd	a5,-120(s0)
 7a6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7aa:	03000593          	li	a1,48
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e14080e7          	jalr	-492(ra) # 5c4 <putc>
  putc(fd, 'x');
 7b8:	85ea                	mv	a1,s10
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e08080e7          	jalr	-504(ra) # 5c4 <putc>
 7c4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c6:	03c9d793          	srli	a5,s3,0x3c
 7ca:	97de                	add	a5,a5,s7
 7cc:	0007c583          	lbu	a1,0(a5)
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	df2080e7          	jalr	-526(ra) # 5c4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7da:	0992                	slli	s3,s3,0x4
 7dc:	397d                	addiw	s2,s2,-1
 7de:	fe0914e3          	bnez	s2,7c6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7e2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	b721                	j	6f0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ea:	008b0993          	addi	s3,s6,8
 7ee:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7f2:	02090163          	beqz	s2,814 <vprintf+0x184>
        while(*s != 0){
 7f6:	00094583          	lbu	a1,0(s2)
 7fa:	c9a1                	beqz	a1,84a <vprintf+0x1ba>
          putc(fd, *s);
 7fc:	8556                	mv	a0,s5
 7fe:	00000097          	auipc	ra,0x0
 802:	dc6080e7          	jalr	-570(ra) # 5c4 <putc>
          s++;
 806:	0905                	addi	s2,s2,1
        while(*s != 0){
 808:	00094583          	lbu	a1,0(s2)
 80c:	f9e5                	bnez	a1,7fc <vprintf+0x16c>
        s = va_arg(ap, char*);
 80e:	8b4e                	mv	s6,s3
      state = 0;
 810:	4981                	li	s3,0
 812:	bdf9                	j	6f0 <vprintf+0x60>
          s = "(null)";
 814:	00000917          	auipc	s2,0x0
 818:	2e490913          	addi	s2,s2,740 # af8 <malloc+0x19e>
        while(*s != 0){
 81c:	02800593          	li	a1,40
 820:	bff1                	j	7fc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 822:	008b0913          	addi	s2,s6,8
 826:	000b4583          	lbu	a1,0(s6)
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	d98080e7          	jalr	-616(ra) # 5c4 <putc>
 834:	8b4a                	mv	s6,s2
      state = 0;
 836:	4981                	li	s3,0
 838:	bd65                	j	6f0 <vprintf+0x60>
        putc(fd, c);
 83a:	85d2                	mv	a1,s4
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	d86080e7          	jalr	-634(ra) # 5c4 <putc>
      state = 0;
 846:	4981                	li	s3,0
 848:	b565                	j	6f0 <vprintf+0x60>
        s = va_arg(ap, char*);
 84a:	8b4e                	mv	s6,s3
      state = 0;
 84c:	4981                	li	s3,0
 84e:	b54d                	j	6f0 <vprintf+0x60>
    }
  }
}
 850:	70e6                	ld	ra,120(sp)
 852:	7446                	ld	s0,112(sp)
 854:	74a6                	ld	s1,104(sp)
 856:	7906                	ld	s2,96(sp)
 858:	69e6                	ld	s3,88(sp)
 85a:	6a46                	ld	s4,80(sp)
 85c:	6aa6                	ld	s5,72(sp)
 85e:	6b06                	ld	s6,64(sp)
 860:	7be2                	ld	s7,56(sp)
 862:	7c42                	ld	s8,48(sp)
 864:	7ca2                	ld	s9,40(sp)
 866:	7d02                	ld	s10,32(sp)
 868:	6de2                	ld	s11,24(sp)
 86a:	6109                	addi	sp,sp,128
 86c:	8082                	ret

000000000000086e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86e:	715d                	addi	sp,sp,-80
 870:	ec06                	sd	ra,24(sp)
 872:	e822                	sd	s0,16(sp)
 874:	1000                	addi	s0,sp,32
 876:	e010                	sd	a2,0(s0)
 878:	e414                	sd	a3,8(s0)
 87a:	e818                	sd	a4,16(s0)
 87c:	ec1c                	sd	a5,24(s0)
 87e:	03043023          	sd	a6,32(s0)
 882:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 886:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 88a:	8622                	mv	a2,s0
 88c:	00000097          	auipc	ra,0x0
 890:	e04080e7          	jalr	-508(ra) # 690 <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6161                	addi	sp,sp,80
 89a:	8082                	ret

000000000000089c <printf>:

void
printf(const char *fmt, ...)
{
 89c:	711d                	addi	sp,sp,-96
 89e:	ec06                	sd	ra,24(sp)
 8a0:	e822                	sd	s0,16(sp)
 8a2:	1000                	addi	s0,sp,32
 8a4:	e40c                	sd	a1,8(s0)
 8a6:	e810                	sd	a2,16(s0)
 8a8:	ec14                	sd	a3,24(s0)
 8aa:	f018                	sd	a4,32(s0)
 8ac:	f41c                	sd	a5,40(s0)
 8ae:	03043823          	sd	a6,48(s0)
 8b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b6:	00840613          	addi	a2,s0,8
 8ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8be:	85aa                	mv	a1,a0
 8c0:	4505                	li	a0,1
 8c2:	00000097          	auipc	ra,0x0
 8c6:	dce080e7          	jalr	-562(ra) # 690 <vprintf>
}
 8ca:	60e2                	ld	ra,24(sp)
 8cc:	6442                	ld	s0,16(sp)
 8ce:	6125                	addi	sp,sp,96
 8d0:	8082                	ret

00000000000008d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d2:	1141                	addi	sp,sp,-16
 8d4:	e422                	sd	s0,8(sp)
 8d6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8dc:	00000797          	auipc	a5,0x0
 8e0:	23c7b783          	ld	a5,572(a5) # b18 <freep>
 8e4:	a805                	j	914 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e6:	4618                	lw	a4,8(a2)
 8e8:	9db9                	addw	a1,a1,a4
 8ea:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ee:	6398                	ld	a4,0(a5)
 8f0:	6318                	ld	a4,0(a4)
 8f2:	fee53823          	sd	a4,-16(a0)
 8f6:	a091                	j	93a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f8:	ff852703          	lw	a4,-8(a0)
 8fc:	9e39                	addw	a2,a2,a4
 8fe:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 900:	ff053703          	ld	a4,-16(a0)
 904:	e398                	sd	a4,0(a5)
 906:	a099                	j	94c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 908:	6398                	ld	a4,0(a5)
 90a:	00e7e463          	bltu	a5,a4,912 <free+0x40>
 90e:	00e6ea63          	bltu	a3,a4,922 <free+0x50>
{
 912:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 914:	fed7fae3          	bgeu	a5,a3,908 <free+0x36>
 918:	6398                	ld	a4,0(a5)
 91a:	00e6e463          	bltu	a3,a4,922 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91e:	fee7eae3          	bltu	a5,a4,912 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 922:	ff852583          	lw	a1,-8(a0)
 926:	6390                	ld	a2,0(a5)
 928:	02059713          	slli	a4,a1,0x20
 92c:	9301                	srli	a4,a4,0x20
 92e:	0712                	slli	a4,a4,0x4
 930:	9736                	add	a4,a4,a3
 932:	fae60ae3          	beq	a2,a4,8e6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 936:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 93a:	4790                	lw	a2,8(a5)
 93c:	02061713          	slli	a4,a2,0x20
 940:	9301                	srli	a4,a4,0x20
 942:	0712                	slli	a4,a4,0x4
 944:	973e                	add	a4,a4,a5
 946:	fae689e3          	beq	a3,a4,8f8 <free+0x26>
  } else
    p->s.ptr = bp;
 94a:	e394                	sd	a3,0(a5)
  freep = p;
 94c:	00000717          	auipc	a4,0x0
 950:	1cf73623          	sd	a5,460(a4) # b18 <freep>
}
 954:	6422                	ld	s0,8(sp)
 956:	0141                	addi	sp,sp,16
 958:	8082                	ret

000000000000095a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 95a:	7139                	addi	sp,sp,-64
 95c:	fc06                	sd	ra,56(sp)
 95e:	f822                	sd	s0,48(sp)
 960:	f426                	sd	s1,40(sp)
 962:	f04a                	sd	s2,32(sp)
 964:	ec4e                	sd	s3,24(sp)
 966:	e852                	sd	s4,16(sp)
 968:	e456                	sd	s5,8(sp)
 96a:	e05a                	sd	s6,0(sp)
 96c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96e:	02051493          	slli	s1,a0,0x20
 972:	9081                	srli	s1,s1,0x20
 974:	04bd                	addi	s1,s1,15
 976:	8091                	srli	s1,s1,0x4
 978:	0014899b          	addiw	s3,s1,1
 97c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 97e:	00000517          	auipc	a0,0x0
 982:	19a53503          	ld	a0,410(a0) # b18 <freep>
 986:	c515                	beqz	a0,9b2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 988:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98a:	4798                	lw	a4,8(a5)
 98c:	02977f63          	bgeu	a4,s1,9ca <malloc+0x70>
 990:	8a4e                	mv	s4,s3
 992:	0009871b          	sext.w	a4,s3
 996:	6685                	lui	a3,0x1
 998:	00d77363          	bgeu	a4,a3,99e <malloc+0x44>
 99c:	6a05                	lui	s4,0x1
 99e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9a2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a6:	00000917          	auipc	s2,0x0
 9aa:	17290913          	addi	s2,s2,370 # b18 <freep>
  if(p == (char*)-1)
 9ae:	5afd                	li	s5,-1
 9b0:	a88d                	j	a22 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 9b2:	00000797          	auipc	a5,0x0
 9b6:	16e78793          	addi	a5,a5,366 # b20 <base>
 9ba:	00000717          	auipc	a4,0x0
 9be:	14f73f23          	sd	a5,350(a4) # b18 <freep>
 9c2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9c4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9c8:	b7e1                	j	990 <malloc+0x36>
      if(p->s.size == nunits)
 9ca:	02e48b63          	beq	s1,a4,a00 <malloc+0xa6>
        p->s.size -= nunits;
 9ce:	4137073b          	subw	a4,a4,s3
 9d2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d4:	1702                	slli	a4,a4,0x20
 9d6:	9301                	srli	a4,a4,0x20
 9d8:	0712                	slli	a4,a4,0x4
 9da:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9dc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e0:	00000717          	auipc	a4,0x0
 9e4:	12a73c23          	sd	a0,312(a4) # b18 <freep>
      return (void*)(p + 1);
 9e8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ec:	70e2                	ld	ra,56(sp)
 9ee:	7442                	ld	s0,48(sp)
 9f0:	74a2                	ld	s1,40(sp)
 9f2:	7902                	ld	s2,32(sp)
 9f4:	69e2                	ld	s3,24(sp)
 9f6:	6a42                	ld	s4,16(sp)
 9f8:	6aa2                	ld	s5,8(sp)
 9fa:	6b02                	ld	s6,0(sp)
 9fc:	6121                	addi	sp,sp,64
 9fe:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a00:	6398                	ld	a4,0(a5)
 a02:	e118                	sd	a4,0(a0)
 a04:	bff1                	j	9e0 <malloc+0x86>
  hp->s.size = nu;
 a06:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a0a:	0541                	addi	a0,a0,16
 a0c:	00000097          	auipc	ra,0x0
 a10:	ec6080e7          	jalr	-314(ra) # 8d2 <free>
  return freep;
 a14:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a18:	d971                	beqz	a0,9ec <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1c:	4798                	lw	a4,8(a5)
 a1e:	fa9776e3          	bgeu	a4,s1,9ca <malloc+0x70>
    if(p == freep)
 a22:	00093703          	ld	a4,0(s2)
 a26:	853e                	mv	a0,a5
 a28:	fef719e3          	bne	a4,a5,a1a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a2c:	8552                	mv	a0,s4
 a2e:	00000097          	auipc	ra,0x0
 a32:	b7e080e7          	jalr	-1154(ra) # 5ac <sbrk>
  if(p == (char*)-1)
 a36:	fd5518e3          	bne	a0,s5,a06 <malloc+0xac>
        return 0;
 a3a:	4501                	li	a0,0
 a3c:	bf45                	j	9ec <malloc+0x92>
