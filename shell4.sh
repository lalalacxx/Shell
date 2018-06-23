#!/bin/bash

# shell基本工具使用学习笔记


# sort工具
# sort将文件的每一行作为一个单位，相互比较，
# 比较原则是从首字符向后，依次按照ASCLL码值
# 进行比较，最后结果按升序输出
# sort file
# 常见选项：
# -r选项。sort默认升序排序，加上-r选项改为降序排序
# sort -r file
# -u选项。将输出结果中的重复行去掉
# sort -u file
# 也可以：sort -ur file
# -n选项。以数值排序
# sort file
# sort -n file
# -t选项：指定间隔符
# -k选项：指定列数排序
# 如指定间隔符为：按照第二列进行排序
# sort -t':' -nk 2 file
# 其他选项：
# -f:会将小写字母都转换为大写字母来进行比较，
# 即忽略大小写
# -c:会检查文件是否已经排好序，若乱序则输出
# 第一个乱序的行的相关信息，最后返回1
# -C: 会检查文件是否已经排好序，如果乱序，
# 不会输出内容，仅返回1
# -b: 会忽略每一行前面的所有空白部分，从第
# 一个可见字符开始进行比较


# uniq工具
# 去出重复行，但是只能去出相邻的重复行
# uniq file
# 常用选项：
# -c:在每行行首加上本行在文件中出现的次数
# uniq -c file
# -d:只显示重复行
# uniq -d file
# -u:只显示文件中不重复的行
# uniq -u file
# 练习：结合sort和uniq求两个文件的交集并集和补集
# 交集(先将两个文件中的内容放到一个文件中，
# 排序后只输出重复行就是二者的交集)
# cat file1 file2 | sort | uniq -d
# 并集(先将两个文件中的内容放到一个文件中，
# 排序后去掉重复行输出就是二者的并集)
# cat file1 file2 | sort | uniq 
# 补集(现将两个文件中的内容放到一个文件中，
# 排序后只输出所有的不重复行就是二者的补集)
# cat file1 file2 | sort | uniq -u

# paste工具
# 主要用来将多个文件的内容合并，paste将按行
# 将不同文件行信息放在一行，缺省情况下，paste连接时
# 用空格和tab键分割新行中的不同文本
# paste file1 file2
# 常用选项：
# -d:指定分隔符
# paste -d':' file1 file2
# -s:将每个文件合并成行而不是按行粘贴
# paste -s -d'~' file1 file2
# -:对每一个-，从标准输入中赌一次数据默认使用空格
# 或者tab键作为分隔符，-选项可以定制输出格式
# ls /etc | paste - - - - - -

# cut工具
# 从文件的每一行剪切字节，字符，和字段并将这些字符
# 字节，和字段写至标准输出，如果不指定File参数，
# cut命令将读取标准输入，必须指定-b -c 或-f标志之一

# 常见选项：
# -b:以字节为单位进行分割
# n 分割第n个字节
# echo "hello world" | cut -b 1
# echo "hello world" | cut -b 3
# n-m 分割第n个到第m个字节
# echo "hello world" | cut -b 1-3
# n,m 分割第n个字节和第m个字节
# echo "hello world" | cut -b 1,3

# -c:以字符为单位进行分割
# echo "hello world" | cut -c 1
# echo "hello world" | cut -c 1-3
# echo "hello world" | cut -c 1,3
# -c与-b选项完全一样？？？看看中文
# echo "中国" | cut -b 1
# echo "中国" | cut -c 1
# echo "中国" | cut -c 2
# 使用-c选项(以字符为单位)，输出正常
# 使用-b选项(以字节为单位)，输出乱码
# 这里的字符，不是我们在C语言当中的占有一个
# 字节的字符，可以简单理解汉字是由多个字节组
# 成的多字节字符
# -d:自定义分隔符，默认为制表符
# -f:与-d一起使用，指定显示那个区域
# echo "hello world" | cut -d' ' -f 1
# echo "hello world" | cut -d' ' -f 1,2
# echo "hello world" | cut -d' ' -f 1-
# echo "hello world" | cut -d' ' -f -2


# xargs工具
# 给其他命令传递参数的一个过滤器，也是组合
# 多个命令的一个工具。擅长将标准输入数据转换成
# 命令行参数，能够处理管道或者stdin并将其转换成
# 特定命令的命令参数。也可以将单行或多行文本输入
# 转换为其他格式，例如多行变单行，单行变多行
# xargs默认命令是echo，空格是默认定界符，这意味着
# 通过管道传递给xargs的输入将会包含换行和空白，
# 不过通过xargs处理，换行和空白江北空格取代。

# 使用一下：
# 对文件进行格式化输出，将文件多行输入转成单行输出
# cat file | xargs
# 常用选项：
# -n：指定列数，并多行输出
# cat file | xargs -n3
# -d:自定义一个分隔符，将特定列打散，并指定格式输出
# echo "a@b@c@d" | xargs -d@ -n1
# echo "a@b@c@d" | xargs -d@ -n2
# 将格式化后的字符串作为命令行参数传递给其他命令，
# 组装完成批量任务
# find /etc -name "*.cat" 2>/dev/null | xargs ls
# find /etc -name "*.cat" 2>/dev/null | xargs -p ls
# xargs默认是将分割处理后的结果整体传递到命令的尾部
# 但是有些时候需要把参数传递到中间的某个位置，
# 就需要使用替换符号进行占位
# -i:默认使用{}作为替换符号
# -I:可以指定替换符号

# 创建根目录下和目录同名的.log文件
# ls / | xargs -I {} touch {}.log
# ls / | xargs -I {} rm {}.log

# find xargs rm 混合使用
# count=0
# while [ $count -le 100 ]
# do
#     touch test$count
#     let count++
# done
# find . -name "test*" -print0 | xargs -0 rm
# find指令的-print0：打印结果以\0做结尾
# xargs的-0：使用'\0'做分割符，使用这两个参数
# 是为了处理文件名中带有空格的情况

# grep工具
# 常用选项：
# -E：扩展模式的正则表达式
# -v:只显示不匹配的行
# -r/R:递归查找
# -q:安静模式，查找时不输出任何结果
# -i：忽略大小写
# -n:输出匹配行的行号
# -o:值输出文件中匹配到的部分
# 具体使用见正则表达式学习笔记

# sed工具
# 处理时，把当前处理的行存储在临时缓冲区中，称为
# 模式空间，接着用sed命令处理缓冲区中的内容，处
# 理完成后，把缓冲区的内容送往屏幕，接着处理下一行
# 这样不断重复，直到文件末尾。但原文件的内容并不改变
# sed默认按照Basic规范基本匹配

# 常见基本使用：
# 打印：
# sed '/^a\+$/p' file
# p命令：打印。但是默认没有匹配到的行也会打印出来
# sed是把待处理文件的内容连同处理结果一起输出到标
# 准输出的，因此p命令表示除了把文件内容打印出来
# 之外还额外打印一遍匹配到的行，要想值输出匹配结果
# 可使用-n选项，该用法相当于grep命令

# 删除：
# 删掉c程序代码中的printf语句
# sed '/^.*printf.*;$/d' test.c
# 需要注意的是sed命令并不会改变原文件的内容，
# 所谓的删除知识不打印我们想要删除的行，但并不影
# 响原文件中的内容

# 替换
# /pattrens/pattern1/pattern2/g:
# 查找符合pattern的行，将该行所有匹配pattern1的
# 字符串替换为pattern2
# sed '/^a\+/s/a/~a~/' file
# sed '/^a\+/s/a/~a~/g' file
# 已匹配字符串标记&，可以表示匹配pattern1之后的
# 所有的字符
# echo "this is a test line" | sed 's/\w\+/[&]/g'
# 子串匹配标记\1,\2,...\n
# echo "number 12" | sed 's/\([0-9]\)\([0-9]\)/\2\1/'
# \(..\)用于匹配子串，对于匹配到的第一个子串就
# 标记为\1,依次类推匹配到的第二个结果就是\2,我
# 们通过对标签进行重组,从而完成数据逆置
# 我们也可以看到该语句中没有pattern这一项，
# 这里就要说一下定址：定址用于决定对那些行进行编辑，
# 地址的形式可以是数字、正则表达式、或二者的结合
# 如果没有指定地址，sed将处理输入文件的所有行
# for i in {a..z}
# do
#    echo $i
# done > file3 | sed -n '3,5p' file 

# sed '3,5d' file

# sed -n '/^f/,/^h/p' file # 打印以'f'开头行和以'h'
# 开头的行之间的行

# sed和grep命令不一样的是，无论是否找到指定的模式，
# 他的退出状态都是0，只有当命令存在语法错误时，sed
# 退出状态才不是0



# 模式空间保持空间
# sed在正常情况下，将处理的行读入模式空间，脚本中的
# sed命令，就一条接着一条进行处理，直到脚本执行完毕
# 然后该行被输出，模式被清空，接着，在重复执行刚才
# 的动作，文件中的新的一行被读入，直到文件处理完毕
# 一般情况下，数据的处理只使用模式空间。按照如上的
# 逻辑即可完成主要任务，但是某些时候，使用通过使用
# 保持空间，还可以带来意想不到的效果

# 模式空间：可以假设为工程里面的流水线，数据就直接
# 在它上面进行处理
# 保持空间：可以想象成仓库，我们在进行数据处理的时候
# 作为数据的暂存区域，正常情况下，如果不显示使用某些
# 高级命令，保持空间不会使用到,接着来看一下高级命令：
# sed高级命令：
# g:将保持空间中的内容拷贝到模式空间中，
# 原来模式空间中的内容被清除
# G:将保持空间中的内容追加到模式空间中的\n后
# h:将模式空间中的内容拷贝到白痴空间中，
# 原来的保持空间的内容被清除
# H:将模式空间中的内容追加到保持空间的\n之后
# x:交换保持空间和模式空间的内容
# n:读取下一行到模式空间中
# N:将下一行添加到模式空间中

# 给每一行结尾添加一行空行
# sed 'G' file4
# 模拟tac的功能（倒序输出）
# sed '1!G;h;;$!d' file4
# 追加匹配行到文件结尾
# sed -e '/^a\|^b/H' -e '$G' file4
# 行列转化
# sed -n 'H;${x;s/\n/ /g;p}' file4



# awk工具
# sed是以行为单位处理文件，awk比sed强的地方再与不仅
# 能以行为单位还能以列为单位处理文件。awk缺省的行分
# 隔符是换行，缺省的列分隔符是连续的空格和tab，但是
# 行分隔符和列分隔符都可以自定义，比如/etc/passwd
# 文件的每一行有若干个字段，字段之间以：分割，就可
# 以重新定义awk的列分隔符为：并以列为单位处理该文件
# 和sed一样，awk处理的文件既可以由标准输入重定向得到
# 也可以当命令行参数传入，编辑命令可以直接当命令行
# 参数传入，也可以用-f参数指定一个脚本文件。
# 编辑命令的基本格式为：
# /pattern/{actions}
# condition{actions}
# 和sed类似，pattern是正则表达式，actions是一系列操作
# awk程序一行一行独处待处理文件，如果某一行与pattern匹配
# 或者满足condition条件，则执行相应的actions，若一条awk
# 命令只有actions部分，则actions部分作用于待处理文件的每一行

# print命令
# awk '/^producta.*$/{print $1}' file
# 使用print命令输出符合正则表达式的结果行，这里的$0代表整条
# 记录行。
# awk '/^producta.*$/{print $1}' file
# awk '/^producta.*$/{print $2}' file
# 这里的$1 $2表示指定的域（列）

# 输出多个域时，print使用，（逗号）作为分隔符
# awk '/^producta.*$/{print $2,$1,$0}' file

# 根据条件进行输出
# $2大于50的时候才输出该行记录
# awk '$2 > 50{print $0}' file
# $2大于50时将该条记录的$2替换为yes然后输出整条记录
# $2小于等于50时将该条记录的$2替换为no然后输出整条记录
# awk '$2>50{print $1,"yes"} $2 <=50{print $1,"no"}' file






































