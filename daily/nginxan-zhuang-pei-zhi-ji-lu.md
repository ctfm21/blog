# Nginx配置记录

---

安装

yum install nginx

systemctl enable nginx.service

systemctl status nginx.service

systemctl restart nginx.service

/etc/nginx/nginx.conf

配置

纯粹的文件访问

```
server{

    listen 80;

    server\_name webfiles.zeekstar.cn;

    root /www/webfiles;

    location /{

        root /www/webfiles;

    }

}
```

HTTPSser

server {

```
server\_name YOUR\_DOMAINNAME\_HERE;

listen 443;

ssl on;

ssl\_certificate /usr/local/nginx/conf/server.crt;

ssl\_certificate\_key /usr/local/nginx/conf/server.key;
```

}

另外还可以加入如下代码实现80端口重定向到443IT人乐园

server {

```
listen 80;

server\_name ww.centos.bz;

rewrite ^\(.\*\) https://$server\_name$1 permanent;
```

}

\# Settings for a TLS enabled server.

\#

\#    server {

\#        listen       443 ssl http2 default\_server;

\#        listen       \[::\]:443 ssl http2 default\_server;

\#        server\_name  \_;

\#        root         /usr/share/nginx/html;

\#

\#        ssl\_certificate "/etc/pki/nginx/server.crt";

\#        ssl\_certificate\_key "/etc/pki/nginx/private/server.key";

\#        ssl\_session\_cache shared:SSL:1m;

\#        ssl\_session\_timeout  10m;

\#        ssl\_ciphers HIGH:!aNULL:!MD5;

\#        ssl\_prefer\_server\_ciphers on;

\#

\#        \# Load configuration files for the default server block.

\#        include /etc/nginx/default.d/\*.conf;

\#

\#        location / {

\#        }

\#

\#        error\_page 404 /404.html;

\#            location = /40x.html {

\#        }

\#

\#        error\_page 500 502 503 504 /50x.html;

\#            location = /50x.html {

\#        }

\#    }

}

反向代理

\#负责压缩数据流

gzip              on;

gzip\_min\_length   1000;

gzip\_types        text/plain text/css application/x-javascript;

\#设定负载均衡的服务器列表

\#weigth参数表示权值，权值越高被分配到的几率越大

upstream hello{

```
server 192.168.68.43:8080 weight=1;

server 192.168.68.45:8080 weight=1;            
```

}

server {

```
\#侦听的80端口:

listen       80;

server\_name  localhost;

\#设定查看Nginx状态的地址

location /nginxstatus{

     stub\_status on;

     access\_log on;

     auth\_basic "nginxstatus";

     auth\_basic\_user\_file htpasswd;

}

\#匹配以jsp结尾的，tomcat的网页文件是以jsp结尾

location / {

    index index.jsp;

    proxy\_pass   http://hello;    \#在这里设置一个代理，和upstream的名字一样

    \#以下是一些反向代理的配置可删除

    proxy\_redirect             off; 

    \#后端的Web服务器可以通过X-Forwarded-For获取用户真实IP

    proxy\_set\_header           Host $host; 

    proxy\_set\_header           X-Real-IP $remote\_addr; 

    proxy\_set\_header           X-Forwarded-For $proxy\_add\_x\_forwarded\_for; 

    client\_max\_body\_size       10m; \#允许客户端请求的最大单文件字节数

    client\_body\_buffer\_size    128k; \#缓冲区代理缓冲用户端请求的最大字节数

    proxy\_connect\_timeout      300; \#nginx跟后端服务器连接超时时间\(代理连接超时\)

    proxy\_send\_timeout         300; \#后端服务器数据回传时间\(代理发送超时\)

    proxy\_read\_timeout         300; \#连接成功后，后端服务器响应时间\(代理接收超时\)

    proxy\_buffer\_size          4k; \#设置代理服务器（nginx）保存用户头信息的缓冲区大小

    proxy\_buffers              4 32k; \#proxy\_buffers缓冲区，网页平均在32k以下的话，这样设置

    proxy\_busy\_buffers\_size    64k; \#高负荷下缓冲大小（proxy\_buffers\*2）

    proxy\_temp\_file\_write\_size 64k; \#设定缓存文件夹大小，大于这个值，将从upstream服务器传

}
```

}

server{

```
listen 80;

server\_name ~^webmanager\.zeekstar\.\(cn\|com\)$;

index index.html;

root /www/webmanager;

location /{

    root /www/webmanager;

}

location /webmanager{

    proxy\_pass http://local\_tomcat/webmanager;

    proxy\_redirect             off; 

    proxy\_set\_header           Host $host; 

        proxy\_set\_header           X-Real-IP $remote\_addr; 

        proxy\_set\_header           X-Forwarded-For $proxy\_add\_x\_forwarded\_for; 

}
```

}

upstream local\_tomcat{

```
server localhost:8080 weight=1;
```

}

server{

```
listen 80;

server\_name ~^\(webserver\|webtest\)\.zeekstar\.\(cn\|com\)$;



location /{

    proxy\_pass http://local\_tomcat;

    proxy\_redirect             off; 

    proxy\_set\_header           Host $host; 

        proxy\_set\_header           X-Real-IP $remote\_addr; 

        proxy\_set\_header           X-Forwarded-For $proxy\_add\_x\_forwarded\_for; 

}
```

}

使用Web登录验证

```
server{

    listen 80;

    server\_name 127.0.0.1;

    index index.html;

    root D:/www/;

    location /{

        root D:/www/;

        auth\_basic "liuyixintest";

        auth\_basic\_user\_file D:/www/pwd.db; 

    }

}
```



