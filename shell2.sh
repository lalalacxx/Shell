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

























