# 条件测试 
# shell脚本中测试是通过命令来完成的
# 常见的测试命令包括test或[
# 听过检查该类命令的退出码，决定条件测试是否成立
# 注意：shell中退出码为0表示测试条件成立，为1表示不成立
# read myint
# test $myint -eq 100
# echo $?
# 测试类型
# 整数测试：-eq(=) -ne(!=) -lt(<) -gt(>) -le(<=) -gt(>=)
# read myint
# test $myint -eq 100
# echo $?
# [ $myint -ne 100 ]#此处一定注意语句和[]之间必须要有空格
# echo $?
# 字符串测试：== (=) != -z -n
# read mystring
# [ "X$mystring" == "Xhello" ]
# echo $?
# [ "X$mystring" != "Xhello" ]
# echo $?
# [ -z $mystring ] #是否为空串
# echo $?
# [ -n $mystring ] #是否为非空串
# echo $?
# 文件测试：-d -f -b -c
# [ -c /dev/tty ] #测试是否为字符设备文件
# echo $?
# [ -b /dev/sda ] #测试是否为块设备文件
# echo $?
# [ -f ./shell2.sh ] #测试是否为普通文件
# echo $?
# [ -d / ] #测试是否为目录
# echo $?
# test 或[ 可以测试一个条件是否成立，如果测试结果为真
# 则该命令的退出码为0，为假则退出码为1
# 使用[命令测试时，传给命令的各参数之间应该用空格隔开
# test和[测试命令的参数形式是相同的
# 只不过[命令后面多了一个]参数 

# 多条件测试
# 逻辑反: !
# read mystring
# [ ! "X$mystring" == "Xhello" ]
# echo $?
# 逻辑与: -a   (and)
# printf "Enter data1: "
# read data1
# printf "Enter data2: "
# read data2
# [ $data1 -eq 100 -a $data2 -eq 200 ]
# echo $?
# 逻辑或：-o   (or)
# printf "Enter data1: "
# read data1
# printf "Enter data2: "
# read data2
# [ $data1 -eq 100 -o $data2 -eq 200 ]
# echo $?

# if语句
# printf "Enter string: "
# read string
# if [ "X$string" == "Xhello" ]
# then
#     echo "get hello"
# fi
# 如果两条命令卸载同一行则需要用；隔开
# 一行致谢一条命令就不需要写；号
# then后面有换行，但这条命令没写完，shell会自动续行
# 把下一行接在then后面当做一条命令处理
# 和[命令一样，要注意命令和个参数之间必须用空格隔开
# printf "Enter string: "
# read string
# if [ "X$string" == "Xhello" ];then
#     echo "get hello"
# fi
# 条件嵌套
# printf "Enter data: "
# read data
# if [ $data -lt 100 ];then
#     if [ $data -eq 50 ];then
#         echo "data is eq than 50"
#     elif [ $data -lt 50 ];then
#         echo "data is lt than 50"
#     else
#         echo "data is gt than 50 and lt than 100"
#     fi
# else
#     echo "data is gt than 100"
# fi
# if命令的参数组成一条子命令，如果该子命令的退出码
# 为0则表示真，则执行then后面的子命令
# 如果非0则表示假，则执行elif，else或者fi后面的子命令
# if后面的子命令通常是测试命令，但也可以是其他命令
# 所以说，只要某个命令的退出码为0或者为1来表名执行结果
# 该命令都可以放在if后
# 练习：检测文件中是否含有222这样的关键字
# 思路：用if进行条件判断，直接判断grep命令的执行结果
# -E:使用扩展正则匹配
# -q：使用安静模式匹配
# printf "Enter filename: "
# read filename
# if grep -Eq '222' "$filename";then
#     echo "yes"
# else
#     echo "no"
# fi
# shell中没有{}。所以用fi表示if语句块的结束

# 空代码块
# 在shell中，如果我们在一个应该出现语句的地方
# 却不需要任何语句执行任何事情，如果空下不写语句
# 则shell就会报错
# read myint
# if [ $myint -eq 100 ];then
# else
#     echo "then后面是个空余句"
# fi
# 解决办法：用：。：是一个特殊的命令，称为空命令
# 该命令不做任何事情，但退出码总是为真
# 此外也可以执行/bin/true或/bin/false
# 得到真或者假的退出码
# printf "Enter data: "
# read data
# if [ $data -eq 100 ];then
#     false   # 这里也可以用true/false命令代替
# else
#     echo "data is ne than 100"
# fi

# ||和&&
# ||
# printf "Enter data1: "
# read data1
# [ $data1 -eq 100 ] && echo "yes"
# [ $data1 -eq 100 ] && {
#     echo "yes"
# }
# &&
# printf "Enter data2: "
# read data2
# [ $data2 -eq 100 ] && echo "YES1"
# [ $data2 -eq 100 ] || {
#     echo "YES2"
# }
# &&相当于if……then.而||相当于if not …… then.
# && 和 || 用于连接两个命令，
# 而上面讲的-a(逻辑与)和-o(逻辑或)仅用于
# 在测试表达式中连接两个测试条件
# shell这里的{}中包含的语句会在当前shell进程中执行
# 而()中包含的语句会创建新的shell进程执行

# case命令 类比c的switch/case语句 esac表示语句块的结束
# c中的switch/case只能匹配整型或字符型常量表达式
# 而shell中的case可以匹配字符串和Wildcard
# 每个匹配分支可以有若干条命令，末尾必须以;;（两个分号）结束
# 执行时找到第一个匹配的分支并执行相应的命令
# 然后直接跳到esac之后，不用像c一样用break跳出
# case $1 in 
# $1是一个特殊变量执行脚本时自动取值为第一个命令行参数
#     'start' )
#         echo "start...done"
#         ;;
#     'stop' )
#         echo "stop...done"
#         ;;
#     * )
#         echo "default"
#         ;;
# esac
# 假如有两种情况需要走同一段逻辑如何处理
# case $1 in
#     'start' | -s )
#         echo "start...done"
#         ;;
#     'stop' | -p )
#         echo "stop...done"
#         ;;
#     * )
#         echo "default"
#         ;;
# esac
# 支持通配符的情况
# case $1 in
#     [sS]tart | -s )
#         echo "start...done"
#         ;;
#     [sS]top | -p )
#         echo "stop...done"
#         ;;
#     * )
#         echo "default"
#         ;;
# esac

# for循环语句
# 方式1
# 在(())结构中所有的运算和C是一样的
# for ((i = 0;i <= 5;i++ ))
# do
#     echo "hello $i"
# done
# 方式2
# for i in {0..5}
# do
#     echo "hello $i"
# done
# for in这样的循环的独到之处就是遍历字符等
# for i in {a..e}
# do
#     echo "hello $i"
# done
# 也可以组合
# for i in {a..c}{1..3}
# do
#     echo "hello $i"
# done
# 或者这样组合
# for i in {a..c} {1..3}
# do
#     echo "hello $i"
# done

# while循环
# i=0
# while [ $i -le 5 ]
# do
#     echo "hello $i"
#     (( i++ )) #该句也可以使用let i++，二者等价
# done
# until循环，shell特有
# i=0
# until [ $i -ge 5 ]
# do
#     echo "hello $i"
#     let i++
# done
# 总结一下：
# while循环是当条件为真时执行后面紧跟的do后面的语句
# until循环是条件为假时才执行

# 死循环
# 方式1
# for (( ; ; ))
# do
#     echo "hello"
# done
# 方式2
# while :   # 或者while true
# do
#     echo "hello"
# done
# 方式3
# until false
# do
#     echo "hello"
# done

# 命令行循环
# 命令行循环与删哪个面我们写过的循环并无不同
# 只是在命令行上写时没一条语句的后面都需要加上分号

# 练习1：求1~100的和
# 方式1：for循环
# sum=0
# for i in {1..100}
# do
#     ((sum=sum+$i))
# done
# echo "sum=$sum"
# 方式2：while循环
# i=1
# sum=0
# while [ $i -le 100 ]
# do
#     let sum+=i
#     let i++
# done
# echo "sum="$sum
# 练习2：求1~100的和并打印执行过程
# sum=0
# string=''
# for i in {1..100}
# do
#     let sum+=i
#     if [ -z "$string" ];then  # 判断是否为一个空字符串
#         string=$i
#     else
#         string=$string'+'$i # 字符串拼接
#     fi
#     let i++
# done
# echo $string=$sum

# 位置参数和特殊变量
# $0:相当于C语言main函数中的argv[0]还有$1,$2...
# 这些称为位置参数，相当于C语言中的argv[1],argv[2]...
# $#:相当于C语言中main函数中的argc-1
# $@:表示参数列表$1,$2...,可以用在for循环中的in后面
# $?:上一条命令的退出码
# $$：当前shell的进程号
# echo "\$0 -> $0"
# echo "\$1 -> $1"
# echo "\$2 -> $2"
# echo "\$3 -> $3"
# echo "\$# -> $#"
# echo "\$@ -> $@"
# echo "\$? -> $?"
# shift位置参数可以用shift命令左移
# 比如shift 3表示原来的$4现在变成$1
# 原来的$5变成$2等，原来的$1,$2,$3丢弃，$0不移动
# 不带参数的shift命令相当于shift 1
# shift 2
# echo "\$0 -> $0"
# echo "\$1 -> $1"
# echo "\$2 -> $2"
# echo "\$3 -> $3"
# echo "\$# -> $#"
# echo "\$@ -> $@"
# echo "\$? -> $?"
# 如何遍历命令行参数
# 方法1
# for i in $@
# do
#     echo $i
# done
# 方法2
# while [ $# -ne 0 ]
# do
#     echo $1
#     shift 1
# done

# 函数，函数定义中没有返回值也没有参数列表
# function myfun()
# {
#     echo "hello world"
# }
# myfun   #调用函数
# shell中的函数必须先定义才能调用
# 函数传参，传参时将shell函数当成迷你脚本
# shell函数没有参数列表并不表示不能传参数
# 事实上函数就像是迷你脚本，调用函数时可以传任一个参数
# 在函数内同样是用$1,$2等变量来提取参数
# function myfun()
# {
#     echo $0
#     echo $1
#     echo $2
#     echo $#
#     echo $@
#     echo "hello world"
# }
# myfun arg1 arg2
# $0并不会作为函数参数进行传参任务
# 函数中的位置参数相当于函数的局部变量
# 改变这些变量并不会影响函数外面的$1,$2等变量

# 函数返回值
# 函数调用或者返回时，将shell函数当成命令
# 只要是命令，那么函数调用成功与否，可以通过$?判定
# 一般函数中可以用return命令返回，如果return后面
# 跟一个数字则表示函数的退出码
# function myfun()
# {
#     echo "exec some code"
#     return 123
# }
# myfun
# echo $?
# 如何判断函数执行是否正确？
# 方式1
# function myfun()
# {
#     echo "exec some code"
#     return 123
# }
# myfun
# if [ $? -eq 123 ];then
#     echo "exec success"
# else
#     echo "exec false"
# fi
# if条件认为0为真，非0为假
# if条件判断是根据命令的退出码判断的
# 方式2
# function myfun()
# {
#     echo "hello world"
#     return 0
# }
# if myfun;then
#     echo "exec success"
# else
#     echo "exec false"
# fi
# 方式3
# echo方式，不关心函数的退出码而关心他的数据
# function myfun()
# {
#     echo "success"
# }
# ret=$(myfun)
# if [ "X$ret" == "Xsuccess" ];then
#     echo "exec success"
# fi

# shell脚本的调试方法：通过调试选项进行
# -n:读一遍脚本中的命令但不执行
# -v:一边执行脚本一边将执行过的脚本命令打印到标准错误输出
# -x:提供跟踪执行信息，将执行的每一条命令和结果依次打印出来
# 使用这些选项的三种方法
# 方法1：命令行使用
# echo "haha1"
# echo "haha2"
# echo "haha3"
# myint=90 
# if [$myint -lt 100];then  # 错误语句
#     echo "yes"
# fi
# 方法2：在脚本开头提供参数 #! /bin/sh -x
# ! /bin/sh -x
# echo "haha1"
# echo "haha2"
# echo "haha3"
# myint=90 
# if [$myint -lt 100];then  # 错误语句
#     echo "yes"
# fi
# 方法3：在脚本中用set命令启用或禁用参数
# set -x和set +x 分别表示开启和禁用-x参数，
# 这样就可以只对脚本中的某一段进行跟踪调试
# echo "haha1"
# echo "haha2"
# set +x
# echo "haha3"
# echo "haha4"
# echo "haha5"
# set -x
# echo "haha6"
# echo "haha7"

# 数组：数组中可存放多个值(只支持一维)
# 初始化时不需要定义数组大小，并且没有限定数组的大小
# 下标从0开始，下标可以是整数或算术表达式，其值大于等于0
# shell数组用括号表示，元素用空格分割开，可以不使用连续的下标
# 并且下标的范围没有限制
# 语法格式：arr_name=(value1 value2...valuen)
# 或者：
# arr_name[0]=""
# arr_name[1]=""
# arr_name[10]=""
# ...
# 读取数组指定元素值的一般格式为：${arr_name[index]}
# arr=(1 a 3.14 'A' "string")
# echo "0:${arr[0]}"
# echo "1:${arr[1]}"
# echo "2:${arr[2]}"
# echo "3:${arr[3]}"
# echo "4:${arr[4]}"
# 获取数组中的所有元素
# arr=(1 a 3.14 'A' "string")
# echo ${arr[@]}
# echo ${arr[*]}
# 获取数组的长度
# arr=(1 a 3.14 'A' "string")
# echo ${#arr[@]}
# echo ${#arr[*]}
# 遍历数组
# 方式1：
# arr=(1 a 3.14 'A' "string")
# for (( i=0;i <${#arr[@]};i++ ))
# do
#     echo "$i -> ${arr[i]}"
# done
# 方式2：
# arr=(1 a 3.14 'A' "string")
# for i in ${arr[@]}
# do
#     echo $i
# done
# 我们在前面也说过shell中的数组下标可以是不连续的
# 假如我们在数组中添加一个元素arr[7]，没有下标为5,6的元素
# 这个时候我们使用方式1是是不会访问到下标为7的元素的
# 解决办法：推荐使用方式2

# shell与文件：大多数UNIX系统命令从我们的终端接受输入
# 并将所产生的输出发送回我们的终端。一个命令通常从一个
# 叫标准输入的地方读取输入，默认情况下，这恰好是我们的终端
# 同样，一个命令通常将其输出写入到标准输出，默认情况下
# 这也会是我们的终端

# shell输出重定向：
# echo "hello world" > file
# for i in {1..3}
# do
#     echo "haha $i"
# done > file
# shell追加重定向
# echo "hello world" > file
# for i in {1..3}
# do
#     echo "haha $i"
# done >> file

# shell输入重定向
# 只能读文件中的一行
# read line < file
# echo $line
# 可按行读取整个文件的内容
# while read line
# do
#     echo $line
# done < file
# 给每行添加一个字符串，并且备份到另外一个文件中
# while read line
# do
#     echo 'YES '$line
# done < file >> file2

# 默认情况下。command > file将stdout重定向到file
# command < file将stdin重定向到file
# stderr重定向到file：
# 2表示标准错误文件（stderr）
# find aaaaa 2> file  # 重定向
# find bbbbb 2>> file  # 追加重定向
# 注意这里的 2> 是一个整体，2和>之间不能有空格
# 如果要将stdout和stderr合并后重定向到file，可以这样写：
# command >> file 2>&1
# find / -name shell2.sh > out 2>&1

# Here Document:是一种特殊的重定向方式
# 用来将输入重定向到一个交互式shell脚本或程序，基本形式：
# command << delimiter
#         document
# delimiter
# 作用：将两个delimiter之间的内容(document)作为输入传递给command
# 结尾的delimiter一定要顶格写，前后不能有任何字符，包括空格和tab
# 开始的delimiter前后的空格会被忽略掉
# 统计EOF之间有多少行string
# wc -l <<EOF
# aaaa
# bbbb
# cccc
# EOF
# 使用Here Document生成Makefile文件
# cat <<EOF > Makefile
# test:test.c
#         gcc -o test test.c
# .PHONY:clean
# clean:
#         rm -f test
# EOF

# /dev/null:如果希望执行某个命令，但又不希望
# 在屏幕上显示输出结果，可将结果重定向到/dev/null
# 该文件是一个特殊的文件，写入到他的内容都会被丢弃
# 不会从该文件中读到任何内容，但是有用的是会有禁止输出的效果
# 如果希望屏蔽stdout和stderr可以这样写：
# find / -name shell2.sh > out 2>&1 > /dev/null

# shell与信号，常见处理方式如下：
# trap 'commands' signal-list:当脚本收到signal-list
# 清单列出的信号时，trap命令会执行引号中的命令
# trap 'echo "hello"; ls' 3
# while :
# do
#     :
# done
# trap signal-list:trap不指定任何命令，接受信号的默认操作
# 默认操作是结束进程的运行
# trap '' signal-list:trap命令指定一个空命令串，允许忽视信号

# shell文件包含：使用 . 和 source
# . api.sh
# source api.sh
# read d1 d2
# res=$(intAdd $d1 $d2)
# echo $res
# 新建一个文件写以下函数
# function intAdd()
# {
#     let data=$1+$2
#     echo $data
# }

# shell运算符
# echo
# 显示字符串
# echo "hello"  # 可省略双引号
# echo hello
# 显示换行
# echo -e "hello! \nworld"
# 显示不换行
# echo "hello!\c"
# echo "world"
# printf:使用printf的脚本比使用echo的移植性好
# printf使用引用文本或空格分割的参数，外面可以在printf
# 中使用格式化字符串，还可以定制字符串的宽度，左右对齐方式等
# 默认printf不会像echo自动添加换行符，可手动添加\n
# mystring='string'
# myint=100
# myfloat=3.14
# printf "%s:%d:%f\n" $mystring $myint $myfloat

# 产生一个随机数
# echo $RANDOM

# 练习1：进度条
# i=0
# bar=''
# lable=("|" "/" "-" "\\")
# while [ $i -le 100 ]
# do
#     printf "[%d%%][%c]%s\r" "$i" "${lable[i%4]}" "$bar"
#     let i++
#     bar=${bar}'#'  # 字符串拼接
#     sleep 0.1   # shell 中按秒计算
# done
# printf "\n"
# 练习2：传入至少3个参数，计算最大最小和平均值
# 需判断传入的参数个数是否足够，否则输出警告
# 平均值保留两位有效小数
# if [ $# -lt 3 ];then
#     echo "参数太少"
#     exit 1
# fi
# max=$1
# min=$1
# sum=0
# for i in $@
# do
#     [ $i -lt $min ] && min=$i
#     [ $i -gt $max ] && max=$i
#     let sum=$sum+$i
# done
# echo "min="$min
# echo "max="$max
# # 使用命令代换（这里使用反引号），bc是计算器
# # ibase=10：按十进制计算，scale=2:保留两位小数
# avg=`echo "ibase=10;scale=2;$sum/$#" | bc`
# echo $avg
# 练习3：有一列数字如下









