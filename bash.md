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
