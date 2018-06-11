参考：http://www.ttlsa.com/nginx/nginx-google-ngx\_http\_google\_filter\_module/





NGINX源码：[http://nginx.org/download/](http://nginx.org/download/)

[http://nginx.org/download/nginx-1.13.10.tar.gz](http://nginx.org/download/nginx-1.13.10.tar.gz)

git clone [https://github.com/cuber/ngx\_http\_google\_filter\_module](https://github.com/cuber/ngx_http_google_filter_module)

git clone [https://github.com/yaoweibin/ngx\_http\_substitutions\_filter\_module](https://github.com/yaoweibin/ngx_http_substitutions_filter_module)

wget [http://mirrors.linuxeye.com/oneinstack/src/pcre-8.39.tar.gz](http://mirrors.linuxeye.com/oneinstack/src/pcre-8.39.tar.gz)

wget [http://mirrors.linuxeye.com/oneinstack/src/openssl-1.0.2j.tar.gz](http://mirrors.linuxeye.com/oneinstack/src/openssl-1.0.2j.tar.gz)

\#

\# 下载最新版 zlib

\# zlib 官网:

\# [http://www.zlib.net/](http://www.zlib.net/)

\#

wget [http://zlib.net/fossils/zlib-1.2.11.tar.gz](http://zlib.net/fossils/zlib-1.2.11.tar.gz)

--prefix=/opt/nginx\

--with-pcre=../pcre-8.39 \

--with-openssl=../openssl-1.0.2j \

--with-zlib=../zlib-1.2.11 \

--with-http\_ssl\_module \

--add-module=../ngx\_http\_google\_filter\_module \

--add-module=../ngx\_http\_substitutions\_filter\_module

make

make install

yum -y install gcc-c++

