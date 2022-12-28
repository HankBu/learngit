# Docker学习笔记

## Docker掘金小册
[小册地址](https://juejin.cn/book/6844733746462064654)
[docker仓库](https://hub.docker.com/)

## 小册笔记
``` yaml
查看镜像列表    docker images
查看镜像/容器详情    docker inspect nginx
拉取镜像        docker pull nginx
删除镜像        docker rmi nginx
# --name 这个选项来配置容器名，一般容器和镜像名字一致，docker思想
创建容器        docker create --name nginx nginx
# 上面已经给容器命名 所以可以运行 nginx
启动容器        docker start nginx
# 创建+启动 -d ( -- detach ) 这个选项告诉 Docker 在启动后将程序与控制台分离，使其进入“后台”运行。
创建启动        docker run -d --name nginx nginx
# 核心是 linux 查看进程
查看容器        docker ps -a
删除容器        docker rm -f nginx
# -i ( --interactive ) 表示保持我们的输入流，只有使用它才能保证控制台程序能够正确识别我们的命令。而 -t ( --tty ) 表示启用一个伪终端，形成我们与 bash 的交互，如果没有它，我们无法看到 bash 内部的执行结果。
进入容器        docker exec -it nginx bash
````