# Nginx学习笔记

## 学习地址
[Nginx 从入门到实践，万字详解！](https://juejin.cn/post/6844904144235413512)

## 安装
### Mac
```bash
# 更新brew
brew update
# 查看安装信息
brew -v
# 查看是否安装了nginx
brew info nginx
# 安装
brew install nginx
# 启动
nginx
# -s signal : send signal to a master process: stop, quit, reopen, reload
# 停止服务（直接走）
nginx -s stop
# 退出（处理完事情走）
nginx -s quit
# 重新加载
nginx -s reload
# 重新启动
nginx -s reopen 重新启动
# 查看完整命令
nginx -h
# 校验nginx的配置
nginx -t -q

# nginx的安装路径
/opt/homebrew/Cellar/nginx/1.23.1
# nginx的配置文件路径
/opt/homebrew/etc/nginx/nginx.conf
# nginx的服务器默认路径 Docroot
/opt/homebrew/var/www
```
## 配置
### 配置文件 nginx.conf
```bash
# 查看进程
ps -ef | grep nginx
# 查看nginx配置
cat -n nginx.conf
```
nginx.conf 结构图可以这样概括：
```bash
main        # 全局配置，对全局生效
├── events  # 配置影响 Nginx 服务器或与用户的网络连接
├── http    # 配置代理，缓存，日志定义等绝大多数功能和第三方模块的配置
│   ├── upstream # 配置后端服务器具体地址，负载均衡配置不可或缺的部分
│   ├── server   # 配置虚拟主机的相关参数，一个 http 块中可以有多个 server 块
│   ├── server
│   │   ├── location  # server 块可以包含多个 location 块，location 指令用于匹配 uri
│   │   ├── location
│   │   └── ...
│   └── ...
└── ...

* 配置文件由指令与指令块构成；
* 每条指令以 ; 分号结尾，指令与参数间以空格符号分隔；
* 指令块以 {} 大括号将多条指令组织在一起；
* include 语句允许组合多个配置文件以提升可维护性；
* 使用 # 符号添加注释，提高可读性；
* 使用 $ 符号使用变量；
* 部分指令的参数支持正则表达式；
```
### 常用全局变量
```bash
$args #这个变量等于请求行中的参数。 
$contentlength #请求头中的Content-length字段。
$contenttype #请求头中的Content-Type字段。
$documentroot #当前请求在root指令中指定的值。 
$host #请求主机头字段，否则为服务器名称。 
$httpuseragent #客户端agent信息 
$httpcookie #客户端cookie信息 
$limitrate #这个变量可以限制连接速率。 
$requestbodyfile #客户端请求主体信息的临时文件名。 
$requestmethod #客户端请求的动作，通常为GET或POST。 
$remoteaddr #客户端的IP地址。 
$remoteport #客户端的端口。 
$remoteuser #已经经过Auth Basic Module验证的用户名。 
$requestfilename #当前请求的文件路径，由root或alias指令与URI请求生成。 
$querystring #与$args相同。 
$scheme #HTTP方法（如http，https）。 
$serverprotocol #请求使用的协议，通常是HTTP/1.0或HTTP/1.1。 
$serveraddr #服务器地址，在完成一次系统调用后可以确定这个值。 
$servername #服务器名称。 
$serverport #请求到达服务器的端口号。 
$requesturi #包含请求参数的原始URI，不包含主机名，如：”/foo/bar.php?arg=baz”。 $uri #不带请求参数的当前URI，$uri不包含主机名，如”/foo/bar.html”。 
$document_uri #与$uri相同。
```

### 反向代理
[fisrt](https://xuexb.github.io/learn-nginx/example/proxy_pass.html)