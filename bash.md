# Bash学习笔记

## 教程地址
[Bash脚本教程(阮一峰)](https://wangdoc.com/bash/)

## 小册笔记
``` bash
# 如果想要在命令行使用这些不可打印的字符，可以把它们放在引号里面，然后使用echo命令的-e参数。
$ echo a\tb
atb
$ echo -e "a\tb"
a        b
# Bash 没有数据类型的概念，所有的变量值都是字符串。
# 变量声明的语法    variable=value
$ foo=1;bar=3
$ foo=2
# 读取变量，直接在变量名前加上$就可以了
$ echo $foo $bar
2 3
# 删除一个变量，也可以将这个变量设成空字符串。
# 上面两种写法，都是删除了变量foo。由于不存在的值默认为空字符串，所以后一种写法可以在等号右边不写任何值。
$ foo=''
$ foo=
# 用户创建的变量仅可用于当前 Shell，子 Shell 默认读取不到父 Shell 定义的变量。为了把变量传递给子 Shell，需要使用export命令。这样输出的变量，对于子 Shell 来说就是环境变量。
# export命令用来向子 Shell 输出变量。变量的赋值和输出也可以在一个步骤中完成。
$ export NAME=value
# 上面命令执行后，当前 Shell 及随后新建的子 Shell，都可以读取变量$NAME。
# 子 Shell 如果修改继承的变量，不会影响父 Shell。
# eg:
# 输出变量 $foo
$ export foo=bar
# 新建子 Shell
$ bash
# 读取 $foo
$ echo $foo
bar
# 修改继承的变量
$ foo=baz
# 退出子 Shell
$ exit
# 读取 $foo
$ echo $foo
bar
# declare命令可以声明一些特殊类型的变量，为变量设置一些限制，比如声明只读类型的变量和整数类型的变量。
declare OPTION VARIABLE=value

````

```bash
显示所有环境变量    env
显示所有变量以及所有的 Bash 函数  set
当前 Shell 的进程 ID    $$
上一个命令的最后一个参数  $_
```

[Bash技巧：介绍 $0、$1、$2、$#、$@、$*、$? 的含义](https://segmentfault.com/a/1190000021435389)
```bash
# 假设执行 ./test.sh a b c 这样一个命令，则可以使用下面的参数来获取一些值：
$0 # 对应 ./test.sh 这个值。如果执行的是 ./work/test.sh，
# 则对应 ./work/test.sh 这个值，而不是只返回文件名本身的部分。
$1 # 会获取到 a，即 $1 对应传给脚本的第一个参数。
$2 # 会获取到 b，即 $2 对应传给脚本的第二个参数。
$3 # 会获取到 c，即 $3 对应传给脚本的第三个参数。$4、$5 等参数的含义依此类推。
$# # 会获取到 3，对应传入脚本的参数个数，统计的参数不包括 $0。
$@ # 会获取到 "a" "b" "c"，也就是所有参数的列表，不包括 $0。
$* #也会获取到 "a" "b" "c"， 其值和 $@ 相同。但 "$*" 和 "$@" 有所不同。
# "$*" 把所有参数合并成一个字符串，而 "$@" 会得到一个字符串参数数组。
$? # 可以获取到执行 ./test.sh a b c 命令后的返回值。
# 在执行一个前台命令后，可以立即用 $? 获取到该命令的返回值。
# 该命令可以是系统自身的命令，可以是 shell 脚本，也可以是自定义的 bash 函数。
```

```bash
# 条件判断
if commands; then
  commands
[elif commands; then
  commands...]
[else
  commands]
fi

# 判断表达式
# $FILE要放在双引号之中，这样可以防止变量$FILE为空，从而出错。因为$FILE如果为空，这时[ -e $FILE ]就变成[ -e ]，这会被判断为真。而$FILE放在双引号之中，[ -e "$FILE" ]就变成[ -e "" ]，这会被判断为伪。
FILE=~/.bashrc
if [ -e "$FILE" ]; then
  if [ -f "$FILE" ]; then
    echo "$FILE is a regular file."
  fi
  if [ -d "$FILE" ]; then
    echo "$FILE is a directory."
  fi
  if [ -r "$FILE" ]; then
    echo "$FILE is readable."
  fi
  if [ -w "$FILE" ]; then
    echo "$FILE is writable."
  fi
  if [ -x "$FILE" ]; then
    echo "$FILE is executable/searchable."
  fi
else
  echo "$FILE does not exist"
  exit 1
fi
```

```bash
# 循环
while condition; do
  commands
done
# eg:
number=0
while [ "$number" -lt 10 ]; do
  echo "Number = $number"
  number=$((number + 1))
done

for variable in list; do
  commands
done
# eg:
for i in word1 word2 word3; do
  echo $i
done

for (( expression1; expression2; expression3 )); do
  commands
done
# eg:
for (( i=0; i<5; i=i+1 )); do
  echo $i
done

select name
[in list]
do
  commands
done
# eg:
select brand in Samsung Sony iphone symphony Walton
do
  echo "You have chosen $brand"
done

```

```bash
# 函数
# Bash 函数体内直接声明的变量，属于全局变量，整个脚本都可以读取。这一点需要特别小心。 所以要有 local 命令声明局部变量

fn () {
  local foo
  foo=1
  echo "fn: foo = $foo"
}
fn
echo "global: foo = $foo"
```

```bash
# 数组
# 申明一个数组
declare -a ARRAYNAME
# 创建一个数组
ARRAY=(value1 value2 ... valueN)
# 读取所有成员
# @和*是数组的特殊索引，表示返回数组的所有成员。
$ foo=(a b c d e f)
$ echo ${foo[@]}
a b c d e f
# 这两个特殊索引配合for循环，就可以用来遍历数组。
for i in "${names[@]}"; do
  echo $i
done
# 拷贝数组
hobbies=( "${activities[@]}" )
# 添加成员
hobbies=( "${activities[@]}" diving )
# 读取成员
# 引用一个不带下标的数组变量，则引用的是0号位置的数组元素。
# 上面例子中，引用数组元素的时候，没有指定位置，结果返回的是0号位置。
$ foo=(a b c d e f)
$ echo ${foo}
a
$ echo $foo
a
# 获取数组长度
${#array[*]}
${#array[@]}
# 提取成员
# ${array[@]:position:length}的语法可以提取数组成员。
$ food=( apples bananas cucumbers dates eggs fajitas grapes )
$ echo ${food[@]:1:1}
bananas
$ echo ${food[@]:1:3}
bananas cucumbers dates
# 追加成员
# 使用+=赋值运算符。它能够自动地把值追加到数组末尾
$ foo=(a b c)
$ echo ${foo[@]}
a b c
$ foo+=(d e f)
$ echo ${foo[@]}
a b c d e f
```

```bash
# 大多数情况下，这不是开发者想要的行为，遇到变量不存在，脚本应该报错，而不是一声不响地往下执行。
# set -u就用来改变这种行为。脚本在头部加上它，遇到不存在的变量就会报错，并停止执行。
# set -E从根本上解决了这个问题，它使得脚本只要发生错误，就终止执行。

#!/usr/bin/env bash
set -u
echo $a
echo bar
# 运行结果如下。
$ bash script.sh
bash: script.sh:行4: a: 未绑定的变量

# 这种写法建议放在所有 Bash 脚本的头部。
set -Eeuxo pipefail
# 另一种办法是在执行 Bash 脚本的时候，从命令行传入这些参数。
$ bash -euxo pipefail script.sh
```

### Bash 启动环境
用户每次使用 Shell，都会开启一个与 Shell 的 Session（对话）。
登录 Session 是用户登录系统以后，系统为用户开启的原始 Session，通常需要用户输入用户名和密码进行登录。

登录 Session 一般进行整个系统环境的初始化，启动的初始化脚本依次如下。

/etc/profile：所有用户的全局配置脚本。
/etc/profile.d目录里面所有.sh文件
~/.bash_profile：用户的个人配置脚本。如果该脚本存在，则执行完就不再往下执行。
~/.bash_login：如果~/.bash_profile没找到，则尝试执行这个脚本（C shell 的初始化脚本）。如果该脚本存在，则执行完就不再往下执行。
~/.profile：如果~/.bash_profile和~/.bash_login都没找到，则尝试读取这个脚本（Bourne shell 和 Korn shell 的初始化脚本）。
Linux 发行版更新的时候，会更新/etc里面的文件，比如/etc/profile，因此不要直接修改这个文件。如果想修改所有用户的登陆环境，就在/etc/profile.d目录里面新建.sh脚本。

如果想修改你个人的登录环境，一般是写在~/.bash_profile里面。下面是一个典型的.bash_profile文件。
```bash
# .bash_profile
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin
PATH=$PATH:$HOME/bin

SHELL=/bin/bash
MANPATH=/usr/man:/usr/X11/man
EDITOR=/usr/bin/vi
PS1='\h:\w\$ '
PS2='> '

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

export PATH
export EDITOR

# 可以看到，这个脚本定义了一些最基本的环境变量，然后执行了~/.bashrc。
```

非登录 Session 是用户进入系统以后，手动新建的 Session，这时不会进行环境初始化。比如，在命令行执行bash命令，就会新建一个非登录 Session。

非登录 Session 的初始化脚本依次如下。

/etc/bash.bashrc：对全体用户有效。
~/.bashrc：仅对当前用户有效。(用户的 Bash 配置文件)
对用户来说，~/.bashrc通常是最重要的脚本。非登录 Session 默认会执行它，而登录 Session 一般也会通过调用执行它。每次新建一个 Bash 窗口，就相当于新建一个非登录 Session，所以~/.bashrc每次都会执行。```注意```，执行脚本相当于新建一个非互动的 Bash 环境，但是这种情况不会调用~/.bashrc。

### 其他
- #!/usr/bin/env bash 声明比#!/bin/bash 兼容性更好。
- 使用花括号（{}）包围变量。否则，bash将尝试访问 /srv/$environment_app 中的 $environment_app 变量，而您实际上可能希望是：/srv/${environment}_app。
- 把变量放在双引号 "" 中，如：```if [ "${NAME}" = "Kevin" ]```，如果 ${NAME} 变量声明，那么BASH会报语法错误（参见：nounset ）。

```
# 大规则
• 总是用双引号括起变量, 包括子shell. 不要裸体的$符号.
• 全部代码进函数. 即使只有一个函数,main.
• 除非是库脚本, 你可以全局进行脚本设置并调用 main. 如此而已.
• 避免使用全局变量. 如定义常量则使用 readonly
• 可执行脚本总有main函数, 调用时用main或main "$@"
• 如果脚本也用作库, 调用时用 ```[[ "$0" == "$BASH_SOURCE" ]]``` && main "$@" 判断
• 设置变量时总是用local修饰, 除非有理由用declare
• 少数例外情况是当你故意想在外层空间设置一个变量.
• 变量都用小写, 除非想输出到环境中.
• 总用set -eo pipefail. 快速失败并检查退出状态(exit codes).
• 在那些你有意让退出状态不为零的程序里使用 || true .
• 切勿使用弃用的样式. 最值得注意的:
• 函数定义成 myfunc() { ... }, 而不是 function myfunc { ... }
• 判断条件总是用 [[ 替代 [ 或 test
• 从不使用反引号, 使用 $( ... )
• 优先使用绝对路径 (借助 $PWD), 总用 ./ 来修饰相对路径.
• 两行以上的函数总是在顶部用declare声名变量和为参数命名
• 如: declare arg1="$1" arg2="$2"
• 定义可变参数函数时例外。见下文.
• 使用 mktemp 创建临时文件, 总是用 trap 来清理.
• 警告和错误应该发送到 STDERR, 任何可解析的内容都应该转到 STDOUT.
• 完成后尝试本地化 shopt 使用和禁用选项.
如果你知道你在做什么，你可以曲解或破坏其中的一些规则，但通常它们是正确的并且非常有帮助。

# 最佳实践和技巧
• 如果可能，请在 awk/sed 之前使用 Bash 变量替换.
• 通常使用双引号，除非使用单引号更有意义.
• 对于简单的条件，请尝试使用 && 和 ||.
• 不要害怕 printf, 它比 echo 更强大.
• 把 then, do, 等入在同一行, 不换行.
• 如果您可以测试退出代码, 请避免在 if 表达式中中使用 [[ ... ]].
• 如果要包含/源码执行文件请使用 .sh 或 .bash 扩展名. 但不用在可执行脚本上.
• 把复杂的单行 sed, perl命令等放在一个独立的函数中, 且使用描述性名称.
• 包含 [[ "$TRACE" ]] && set -x 是个好主意.
• 做简单明了的设计.
• 避免使用选项标志和解析，而是尝试使用可选的环境变量.
• 将子命令用于必要的不同“模式”.
• 在大型系统或任何CLI命令中，向函数添加描述.
• 在函数顶部使用 declare desc="description"，甚至在参数声明之上.
• 这可以使用反射查询/提取。例如:
eval $(type FUNCTION_NAME | grep 'declare desc=') && echo "$desc"
• 意识到需要可移植性。在容器中运行 Bash 可以比 Bash 在多个平台上运行做出更多的假设.
• 在期望或导出环境变量时，考虑可能涉及子 shell 的命名空间变量.
• 使用硬tab符。Heredocs忽略了前导tab符，允许更好的缩进.
```