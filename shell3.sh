# 正则表达式学习笔记

# 应用场景
# 验证：表单提交信息，进行用户名密码验证
# 查找：从大量信息中快速提取指定内容
# 替换：将指定格式的文本，进行正则匹配查找，
# 找到之后进行特定替换

# 正则表达式基本要素
# 字符类，数量限定符，位置限定符，特殊符号

# 字符类

# . : 匹配任意一个字符
# echo "hello world" | grep -E 'hell.'
# echo "hello world" | grep -E --color 'hell.'
# grep采用贪婪匹配，匹配当前行中所有的匹配内容
# echo "hehe" | grep -E --color '.'

# []:匹配括号中的任意一个字符
# echo "hello world" | grep -E --color 'h[Ee]llo'
# echo "hEllo world" | grep -E --color 'h[Ee]llo'

# - :在[]括号内表示字符范围
# echo "hello world" | grep -E --color 'he[a-m]lo'
# echo "henlo world" | grep -E --color 'he[a-m]lo'

# ^ :位于[]号内的开头，匹配除括号中的字符之外的任意一个字符
# echo "hello world" | grep -E --color 'he[^a-m]lo'
# echo "henlo world" | grep -E --color 'he[^a-m]lo'

# [[:xxx:]] :grep工具预定义的一些命令字符类
# echo "hello worl3d" | grep -E --color 'worl[[:digit:]]d'
# echo "hello worltd" | grep -E --color 'worl[[:digit:]]d'

# 数量限定符

# ？：紧跟在它前面的单元应匹配0次或1次
# echo "hello aworld" | grep -E --color 'a?'
# echo "hello aaworld" | grep -E --color 'a?'
# echo "hello world" | grep -E --color 'a?'

# + ：紧跟在他前面的单元应匹配1次或多次
# echo "hello aworld" | grep -E --color 'a+'
# echo "hello aaworld" | grep -E --color 'a+'
# 匹配不成功，因为至少一次
# echo "hello world" | grep -E --color 'a+'

# * ：紧跟在他前面的单元应匹配0次或多次
# echo "hello awiorld" | grep -E --color 'a*'
# echo "hello aaworld" | grep -E --color 'a*'
# 会匹配成功，因为允许匹配0次
# echo "hello world" | grep -E --color 'a*'

# {N} : 紧跟在他前面的单元应精确匹配N次
# echo "hello world" | grep -E --color 'a{2}'
# echo "hello aworld" | grep -E --color 'a{2}'
# echo "hello aaworld" | grep -E --color 'a{2}'
# echo "hello aaaworld" | grep -E --color 'a{2}'

# {N,} : 紧跟在他前面的单元应匹配至少N次
# echo "hello world" | grep -E --color 'a{2,}'
# echo "hello aworld" | grep -E --color 'a{2,}'
# echo "hello aaworld" | grep -E --color 'a{2,}'
# echo "hello aaaworld" | grep -E --color 'a{2,}'

# {,M} : 紧跟在他前面的单元应最多匹配M次
# echo "hello world" | grep -E --color 'a{,2}'
# echo "hello aworld" | grep -E --color 'a{,2}'
# echo "hello aaworld" | grep -E --color 'a{,2}'
# echo "hello aaaworld" | grep -E --color 'a{,2}'

# {N,M} ： 紧跟在他前面的单元应匹配至少N次，最多M次
# echo "hello world" | grep -E --color 'a{2,3}'
# echo "hello aworld" | grep -E --color 'a{2,3}'
# echo "hello aaworld" | grep -E --color 'a{2,3}'
# echo "hello aaaworld" | grep -E --color 'a{2,3}'
# echo "hello aaaaworld" | grep -E --color 'a{2,3}'

# 位置限定符

# ^:匹配行首的位置
# echo "world aworld worlda aworldb world" | grep -E --color '^world'
# $:匹配行尾的位置
# echo "world aworld worlda aworldb world" | grep -E --color 'world$'
# 如何严格匹配一行？
# echo "world aworld worlda aworldb world" | grep -E --color '^world$'
# echo "world" | grep -E --color '^world$'
# ^$可用于匹配空行
# ^ $ 在正则表达式中确定目标串出现的位置，我们称之为锚点

# \<:匹配单词开头的位置
# echo "world aworld worlda aworldb world" | grep -E --color '\<world'
# \>:匹配单词结尾的位置
# echo "world aworld worlda aworldb world" | grep -E --color 'world\>'
# 匹配以单词开头和结尾的位置
# echo "world aworld worlda aworldb world" | grep -E --color '\<world\>'

# \b:匹配单词开头或结尾的位置
# echo "world aworld worlda aworldb world" | grep -E --color '\bworld'
# echo "world aworld worlda aworldb world" | grep -E --color 'world\b'
# echo "world aworld worlda aworldb world" | grep -E --color '\bworld\b'
# \B:匹配非单词开头和结尾的位置
# echo "world aworld worlda aworldb world" | grep -E --color '\Bworld'
# echo "world aworld worlda aworldb world" | grep -E --color 'world\B'
# echo "world aworld worlda aworldb world" | grep -E --color '\Bworld\B'
# \b用来限定是目标串中是否有以指定字符串开头的单词
# 我们称之为词界，\B称之为非词界

# 特殊符号

# \:转义字符，普通字符和特殊字符之间的转换
# 我们到目前为止写的所有的grep语句都加了-E选项
# 如果去掉？？(匹配失败)
# echo "abcabcdef" | grep --color '(abc){2}'
# 如何理解？了解一下基本正则和扩展正则
# 二者的区别就在于正则表达式的Extended规范和Basic
# 规范基本相同，知识在Basic规范下，有些字符？+ {} | ()
# 应解释为普通字符,要解释上述字符就需要加\转义
# 反之，在Extended规范下，？+ {} | ()应被理解为特殊含义
# 要取其字面值，也要对其加\进行转义
# grep 工具加上-E选项表示使用扩展正则进行匹配，
# 不加则使用基本正则进行匹配
# egrep与grep -E 等价
# 解决问题：
# echo "abcabcdef" | grep --color '\(abc\)\{2\}'
# 如果字符串中本身就已经包含了？+{}|()
# 想匹配这些字符怎么写呢？？
# echo "asd{}()|?+lkj" | grep --color '{}()|?+'
# echo "asd{}()|?+lkj" | grep -E --color '{}()|?+'
# echo "asd{}()|?+lkj" | grep -E --color '\{\}\(\)\|\?\+'

# ():将正则表达式的一部分括起来组成一个单元，
# 可以对整个单元使用数量限定符
# echo "abcabcdef" | grep -E --color '(abc){3}'
# echo "abcabcabcdef" | grep -E --color '(abc){3}'
# echo "abcabcabcabcdef" | grep -E --color '(abc){3}'
# 此时()括起来的内容为一个整体，作为一个单元，
# 进而可以用数量限定符进行限定


# | : 连接两个子表达式，表示或的关系
# 用来级联多个条件，只要有任意一个匹配即可匹配成功
# echo "aa{}()|?+bb" | grep -E --color 'aa'
# echo "aa{}()|?+bb" | grep -E --color 'bb'
# echo "aa{}()|?+bb" | grep -E --color 'aa|bb'

# 其他常用通用字符集及其替换
# \d : [0-9]         数字字符
# echo "ab1239cd_@#" | grep -E --color '\d'
# \D : [^0-9]        非数字字符
# echo "ab1239cd_@#" | grep -E --color '\D'
# 发现上述两条语句并不能正常匹配
# grep和egrep支持除了基本正则和扩展正则之外，还支持perl正则
# 加上-P选项则表示要使用PRES(Perl正则)
# echo "ab1239cd_@+" | grep -P --color '\d'
# echo "ab1239cd_@+" | grep -P --color '\D'

# \w : [a-zA-Z0-9_]  数字字母下划线
# echo "ab1239cd_@+" | grep -P --color '\w'
# \W : [^\w]         非数字字母下划线
# echo "ab1239cd_@+" | grep -P --color '\W'

# \s : [_\r\t\n\f]   表格换行换页等空白区域
# echo "ab1239cd_@+ " | grep -P --color '\s'
# \S : [^\s]         非空白区域
# echo "ab1239cd_@+ " | grep -P --color '\S'

# 贪婪模式与非贪婪模式
# 贪婪模式：正则表达式匹配时会尽量多的匹配符合条件的内容
# echo "abcabcabcd" | grep -E --color 'a.*'
# grep 默认为贪婪匹配
# 非贪婪模式：尽量少的匹配符合条件的内容，也就是说，
# 一旦发现匹配符合要求，立马就会匹配成功，而不会继续匹配下去
# echo "abcabcabcd" | grep -E --color 'a.*?c'
# 可以看到，非贪婪模式的标识符驾驶贪婪模式的标识符后面加上一个？

# 零宽断言
# 断言用来声明一个应该为真的事实，在正则匹配中只有当断言为真时
# 才会继续进行匹配，接下来的四个用于查找在某些内容（但并不包括
# 这些内容）之前或之后的东西，也就是说他们像\b,^,$那样用于指定
# 一个位置这个位置应该满足一定的条件（即断言），因此他们也称之
# 为零宽断言。下面举例说明：
# (?=exp)也叫零宽度正预测线性断言
# 他断言自身出现的位置的后面能匹配表达式exp，比如\b\w+(?=ing\b)
# 匹配以ing结尾的单词的前面部分（除了ing以外的部分）
# echo "i am singing while you are dancing" | 
#    grep -oP --color '\b\w+(?=ing\b)'
# (?<=exp)也叫零宽度正回顾后发断言
# 他断言自身出现的位置的前面能匹配表达式exp，比如(?<=\bre)\w+\b
# 会匹配以re开头的单词的后半部分（除了re)
# echo "reading a book" | grep -oP --color '(?<=\bre)\w+\b'
# 例：
# echo "abc123def" | grep -oP --color '(?<=[a-z]{3})\w+(?=[a-z]{3})'

# 练习1：找出手机号码
# 手机号的特点：
# 1：第一位固定为1
# 2：第二位固定为34578这5个数字中的其中一个
# 3：全都是数字，长度固定为11
# cat file | grep -E --color '1[34578][0-9]{9}'

# 练习2：匹配非0的正整数
# echo "1234" | grep -P --color '^[1-9]\d*$'
# echo "0234" | grep -P --color '^[1-9]\d*$'
# echo "-1" | grep -P --color '^[1-9]\d*$'
# echo "0" | grep -P --color '^[1-9]\d*$'

# 练习3：匹配非零开头的最多带两位小数的数字
# echo "1234.99" | grep -E --color '^[1-9][0-9]*\.[0-9]{1,2}$'
# echo "0234.99" | grep -E --color '^[1-9][0-9]*\.[0-9]{1,2}$'
# echo "1234.9" | grep -E --color '^[1-9][0-9]*\.[0-9]{1,2}$'
# echo "1234." | grep -E --color '^[1-9][0-9]*\.[0-9]{1,2}$'

# 练习4：ip地址
# 方法1：快速过滤，数字可能超出范围
# echo "192.168.1.106" | grep -P --color '\d+\.\d+\.\d+\.\d+'
# echo "256.168.1.106" | grep -P --color '\d+\.\d+\.\d+\.\d+'
# 方法2：
# echo "192.168.1.106" | grep -P --color \
#     '((25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))'
# echo "256.168.1.106" | grep -P --color \
#     '((25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))'




























