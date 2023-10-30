# 基本命令
git init 

    命令把这个目录变成git 可以管理的仓库

git add 文件名

     把文件添加到仓库

git status 

    git 仓库的状态

git commit -m "add readme.text file”

    把文件提交到仓库
    
    -m 是本次的提交说明

git diff readme.txt
    
    查看文件修改内容

git log 

    查看版本提交记录

    --pretty=oneline 只显示版本号和提交注视

    穿梭前，用git log可以查看提交历史，以便确定要回退到哪个版本。

在 git 中，当前版本用 HEAD 表示，上一个版本是 HEAD^ ,上上个版本是 HEAD^^

往上 100 个版本就是 100 个 ^ ,难写，所以写成 HEAD~100

git reset --hard HEAD^
    
    回到上一个版本

git reset --hard eb7378897e8996f1e

    根据版本号回到此版本

git reflog
    查看每一次的版本id

    要重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本。

git diff HEAD -- readme.txt 
git diff <source_branch> <target_branch>

    查看工作区与版本库里面的文件区别

git checkout -- readme.txt 
    
    把 readme.txt 文件在工作区的修改全部还原

    1、如果文件修改后，还没有放到暂寸区，撤销后，和版本的一样

    2、如果文件已经放到暂存区后(git add 过了)，又作了修改，现在，撤销修改就回到添加到暂存区后(git add 后)的状态。

git reset HEAD readme.txt 
    
    把暂存区的文件撤销掉，重新放回工作区

    场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令git checkout -- file。

    场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令git reset HEAD file，就回到了场景1，第二步按场景1操作。

    场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。

git rm test.php

    删除版本库里面的文件，需要再次 commit 

生成 ssh key 

    ssh-keygen -t rsa -C “youremail@example.com"

    一路默认

    /Users/yuanchao/.ssh  里面保存了生成的 key .pub 是公钥

添加远程仓库
    在 git 新建一个仓库

    把这个仓库与本地仓库关联
        git remote add origin git@github.com:yccphp/testgit.git （每个仓库不同）

    把我们本地仓库的所有内容推送到远程库
        git push -u origin master （第一次）

    以后每次提交
        git push origin master


从远程仓库克隆
    git clone git@github.com:yccphp/gitclonetest.git 

    不同的 git 不同的地址

    然后修改后，需要推送的话，还是使用推送命令 push


创建合并分支

    checkout -b   分支名
    
    -b 表示创建并且切换

git branch 分支名
    
     创建一个分支


git checkout 分支名
    
    切换到某个分支

git branch
    
    查看当前分支

git merge dev
    
    合并指定分支 到当前分支上

git branch -d dev

    删除指定分支

git log --graph --pretty=oneline -—abbrev-commit 
    
    查看分支合并情况

git merge --no-ff -m "merge with on-ff" dev

    合并创建一个新的提交

    —no-ff 普通合并，合并后的历史有分支，能看的出来曾经做过合并

bug 分支

当你接到一个修复一个代号101的bug的任务时，很自然地，你想创建一个分支issue-101来修复它，但是，等等，当前正在dev上进行的工作还没有提交：

git stash

    将当前工作区储存起来，等恢复以后继续工作

git stash pop

    将存储起来的内容，恢复

强行删除分支

    git branch -D feature-vulcan

    如果要丢弃一个没有被合并过的分支，可以通过git branch -D <name>强行删除。

git remote -v

    查看远程分支的信息

git pull

    从远程抓取分支

git push origin branch-name

    从本地推送分支

git checkout -b branch-name origin/branch-name

    在本地创建和远程分支对应的分支，本地和远程分支的名称最好一致；

git branch --set-upstream branch-name origin/branch-name

    建立本地分支和远程分支的关联

标签

切换到需要打标签的分支上

git tag <name>

    打一个新的标签  <name> 标签名 也可以指定一个 commit id

git tag

    查看所有标签

git tag v789 7a7e436

    根据某个提交id ,打新的标签

git show v789
    查看标签信息

git tag -a dev1.0 -m “开发版"

    -a 标签名
    -m 说明

git tag -d <name>

    删除标签 <name> 标签名

git push origin v1.0

    推送标签到远程服务器

git push origin --tags
    
    推送本地所有未推送的标签

删除远程服务器上面的标签

git tag -d v789 

    1、先从本地删除

git push origin :refs/tags/v0.9

    2、删除远程上的tag

# 实际使用

## 合并多个commit

以下是使用 Git Rebase 合并 Commit 的具体步骤：

### 1. 确定要合并的提交

首先，你需要确定要合并的提交。可以使用 `git log` 命令查看提交历史，找到要合并的提交的哈希值。

```
$ git log 
```

### 2. 执行 Git Rebase

接下来，执行 `git rebase -i` 命令，后面跟着要合并的提交的`父提交哈希值`。例如，如果要合并最近的三个提交，你可以这样操作：

```
$ git rebase -i HEAD~3
```

这将会打开一个编辑器，列出了你选择的提交。默认情况下，这些提交前面都会有 `pick` 关键字。

### 3. 选择要合并的提交

将你想要合并的提交前面的 `pick` 关键字改为 `squash`（或者简写为`s`）。保存并关闭编辑器。

例如，如果你想要合并最后两个提交，你可以将它们前面的 `pick` 改为 `squash` （或者简写为`s`） ：

```
pick 1234567 第一个提交
squash 2345678 第二个提交
squash 3456789 第三个提交
```

其实最终只保留一个 `pick`，把要合并的提交都改为 `squash` 这样就标记好最终合并的提交备注名称了。

### 4. 编辑合并后的提交信息

Git 会再次打开一个编辑器，让你编辑合并后的提交信息。你可以选择保留、删除或修改原始提交信息。保存并关闭编辑器。

这个时候你要把原先第二个和第三个提交的注释前面都改为 # 表示注释掉。

### 5. 完成 Git Rebase

完成以上操作后，Git 会自动执行 Rebase 操作。此时，你可以使用 `git log` 命令查看经过合并的提交历史。

如果你的分支已经推送到远程仓库，你需要使用 `git push --force` 命令强制推送更新后的分支。

::: warning 注意
这里的commit用的rebase合并方案是rebase的一种特殊用途，他会“破坏”你的提交，会导致丢失多个commit的注释，这就引申出一个rebase合并颗粒度的问题，建议按照模块进行合并，这样为未来代码分析，借助git commit注释了解这段代码编写时相关逻辑会有帮助。
:::