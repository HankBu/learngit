# Docker学习笔记

## Docker资料
[小册地址](https://juejin.cn/book/6844733746462064654)
[Docker从入门到实践](https://yeasy.gitbook.io/docker_practice/)
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
# 创建+启动 
# -d ( -- detach ) 这个选项告诉 Docker 在启动后将程序与控制台分离，使其进入“后台”运行。
# -v 将这个目录共享到服务器的真实目录下。通过 -v 参数以冒号进行分割，左边是服务器目录，右边是容器目录。
# -p 参数指定将容器的 3306 端口映射到服务器的 2468 端口。通过 -p 参数以冒号进行分割，左边端口号是服务器端口，右边端口号是容器端口。
# -e 表示启动时候添加环境变量；MYSQL_ROOT_PASSWORD 就是给 mysql 设置 root 的密码为 root。
创建启动        docker run -d --name nginx nginx
               docker run -d -v /root/mysqldata:/var/lib/mysql -p 2468:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.7
# 创建一个名为 mysql 的容器卷 (容器卷也是对应了服务器上实际的文件目录，只是为了方便，能够集中式地统一管理这些文件目录。)
# 容器卷的数据默认存放在 Docker 安装目录下的 volumes 里面，默认全路径是 /var/lib/docker/volumes
创建容器卷      docker volume create mysql
查看容器卷      docker volume ls
删除容器卷      docker volume rm mysql
创建启动(配合容器卷)    docker run -d -v mysql:/var/lib/mysql -p 2468:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.7
# 核心是 linux 查看进程
查看容器        docker ps -a
删除容器        docker rm -f nginx
# -i ( --interactive ) 表示保持我们的输入流，只有使用它才能保证控制台程序能够正确识别我们的命令。而 -t ( --tty ) 表示启用一个伪终端，形成我们与 bash 的交互，如果没有它，我们无法看到 bash 内部的执行结果。
进入容器        docker exec -it nginx bash
````

## Docker从入门到实践笔记
```yaml
Mac安装     brew install --cask docker

```

## 借鉴相关小册
[践行DevOps](https://juejin.cn/book/7099044294765314055/section/7099065551682535454)
```yaml
# Nginx 可以充当文件服务器的功能，只需要将文件放在其默认的 
/usr/share/nginx/html
```

