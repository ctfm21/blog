# CentOS7 安装Tengine

---

[http://tengine.taobao.org](http://tengine.taobao.org/download/tengine-2.2.2.tar.gz)

* 下载

```
wget http://tengine.taobao.org/download/tengine-2.2.2.tar.gz
```

* 安装

```
yum install gcc gcc-c++ autoconf automake
yum install pcre pcre-devel
yum install -y openssl openssl-devel

make & make install
```

安装后在: /usr/local/nginx中

```
ln -s /usr/local/nginx/sbin/nginx /usr/bin
```

* 注册为系统服务 通过systemctl管理

`vi /usr/lib/systemd/system/nginx.service`

```
[Unit]
Description=The nginx HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

```
systemctl enable nginx
```

* 多节点配置

> upstream appserver{
>
> 	server  ip1:8080;
>
> 	server ip2:8080;
>
> 	check interval=3000 rise=2 fall=5 timeout=1000 type=http;
>
> }



