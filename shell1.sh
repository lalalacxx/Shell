#   #用于注释

#   此时以./shell.sh的形式运行该shell程序，真实的目录并不会改变
#   如果运行时用.或者source修饰脚本，脚本的执行将会影响到父bash
#   .   source是shell的内建命令，这种方式不会创建子shell,
#   而是直接在交互式shell下逐行执行脚本中的命令
#pwd
#cd ..
#pwd

# shell变量
# 注意，变量名和等号之间不能有空格，
# 否则会被shell解释成命令和命令行参数
# 首个字符必须为字母（大小写无论）
# 中间不能有空格 可以使用下划线（_)
# 不能使用标点符号
# 不能使用bash里的关键字（可用help命令查看保留关键字）
#mystring="hello world"
#myint=100
#myfloat=13.14
#mychar=c
# 所有的变量不需要先定义后使用，可以直接使用

# 使用一个赋值过的变量，只要在变量名前加美元符号($)即可
# echo命令用于向窗口输出文本
#echo $mystring
#echo $myint
#echo $myfloat
#echo $mychar

# 一个问题：我们想要输出hello worldhello today这样的字符串
#mystring="hello world"
#echo "$mystringhello today"
# 实际上运行以后输出的是“ today”，
# 这时因为shell将mystring和hello认为是一个变量名
# 但是该变量并没有被使用过所以是一个空串
# 解决：
#mystring="hello world"
#echo "${mystring}hello today"
# 加花括号是为了识别变量名的边界

#已定义的变量 可以再次被重新定义
#mystring="haha"
#echo $mystring
#mystring="hehe"
#echo $mystring
# 需要注意的一点就是，第二次赋值的时候不能写成$mystring="hehe"
# 当变量名作为右值时才需要带上$符号

# 只读变量
# 使用readonly命令可以将变量定义为只读变量，只读变量的值不能被改变
#readonly mystring="haha"
#echo $mystring
# 视图改变变量mystring的值
# 但这是不行的，运行以后会报错
#mystring="hehe"
#echo $mystring

# 删除变量 使用unset命令可以删除变量，不能删除只读变量
#mystring="haha"
#readonly myint=100
#echo $mystring
#echo $myint
# 将mystring变量删除,删除以后的变量，内容会被清空
#unset mystring
#echo $mystring
# 将只读变量myint删除，（是不能删除只读变量的）
#unset myint
#echo $myint

#变量类型
#本地变量：只存在于当前shell进程，本地变量时shell特有的概念
#环境变量：可以从父进程传给子进程，因此shell进程的环境变量
#可以从当前shell进程传给fork出来的子进程，
#用printenv命令可以显示当前shell进程的环境变量
#echo $myval
#一个变量定义以后仅存在于当前shell进程，他是本地变量，
#用export命令可以吧本地变量导出为环境变量。

#字符串拼接，原则上来说只要将信息写在一起就完成了字符串的拼接
#str1='hello '
#str2=world
#echo $str1$str2' today'
#获取字符串长度
#echo ${#str1}
#提取子字符串 比如从字符串第2个字符开始截取6个字符
#str3="abcde12345"
#echo ${str3:1:6}
#查找子字符串
#str="nice to meet you"
#echo `expr index '$str' you`

#文件名待换
# 通配符*：匹配任意多个字符
# ？：匹配一个任意字符
# [若干字符]：匹配方括号中任意一个字符的一次出现
#列出所有名带有file的文件
#ls file*
#列出file1 file2 file3
#ls file[1-3]
#列出所有名带有file3的文件
#ls file3?

#命令代换和算术代换
#由反引号``引起来的也是一条命令，shell先执行该命令
#然后将输出结果立刻代换到当前命令行中
#date=`date +%Y:%m:%d`
#echo $date
#命令代换也可以用$()表示
#（（））中的shell变量取值将转换成整数，常用于算术计算
#myint=100
#echo $myint
#((myint++))
#echo $myint
#例题：计算1+1
#myint1=1
#myint2=2
#echo $(($myint1 + $myint2))
#赋值
#myint3=110
#echo $myint3
#res=$((++myint3))
#echo $myint3
#echo $res
#  (())中只能用+-*/运算符，并且只能做整数运算

#转义字符   \在shell中也被用作转义字符（和c一样）
#用于去除紧跟其后的单个字符的特殊意义（回车除外）
#换句话说，紧跟其后的字符取字面值，
#另外，\还可以紧跟其后的普通字符取特殊意义
#比如创建和删除一个文件名为$ $(中间有空格)的文件可以这样操作
#touch \$\ \$
#rm \$\ \$
# 在\后面敲回车表示续行，shell并不会立刻执行命令
# 而是把光标移到下一行，给出一个续行提示符>
# 等待用户继续输入，最后把所有的续行接到一起当做一个命令执行
#如：
#myint=100
#echo \
#    $myint

# 单引号双引号：都是字符串的界定符，不是字符的界定符
# 单引号用于保持引号内所有字符的字面值，即使引号内的\和回车也不例外
# 但是字符串中不能出现单引号，如果引号没有配对就输入回车
#shell会给出续行提示符，要求用户把引号配上对
#mystring="haha"
echo "hello $mystring \\ \" \\ \` `date +%Y:%m:%d`"
echo 'hello $mystring \\ \" \\ \` `date +%Y:%m:%d`'
#双引号用于保持引号内的所有字符的字面值（回车也不例外）
#但以下情况除外：
# 1、$加变量名可以取变量的值
# 2、反引号仍然表示命令替换
# 3、$表示$的字面值
# 4、`表示`的字面值（反引号）
# 5、\表示\的字面值，除以上情况外在其他字符前面的\无特殊含义，只表示字面值


