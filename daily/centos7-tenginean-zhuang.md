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



