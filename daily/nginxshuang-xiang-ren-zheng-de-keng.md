# Nginx 双向认证 失败 报错400

---

## 生成证书摘自：

[https://www.cnblogs.com/UnGeek/p/6049004.html](https://www.cnblogs.com/UnGeek/p/6049004.html)

[https://blog.csdn.net/witmind/article/details/78456660](https://blog.csdn.net/witmind/article/details/78456660)

## 安装过程

### CA 与自签名

CA 是权威机构才能做的，并且如果该机构达不到安全标准就会被浏览器厂商“封杀”，前不久的沃通、StartSSL 就被 Mozilla、Chrome 封杀了。不过这并不影响我们进行双向认证配置，因为我们是自建 CA 的..

为了方便，我们就在 NGINX 的目录下进行证书相关制作：

> `cd /etc/nginx`
>
> `mkdir ssl`
>
> `cd ssl`

制作 CA 私钥

> `openssl genrsa -out ca.key 2048`

制作 CA 根证书（公钥）

> `openssl req -new -x509 -days 3650 -key ca.key -out ca.crt`

注意：

Common Name 可以随意填写  
；其他需要填写的信息为了避免有误，都填写 . 吧

**服务器端证书          
**

制作服务端私钥

> openssl genrsa -out server.pem 1024
>
> openssl rsa -in server.pem -out server.key

生成签发请求

> openssl req -new -key server.pem -out server.csr

注意：

* ~~Common Name 得填写为访问服务时的域名，这里我们用 usb.dev 下面 NGINX 配置会用到~~

* **测试过程发现，直接写域名会报错。Common Name要写带 https的路径，应写：“**[https://api.test.com”，而不是“api.test.com”](https://api.test.com”，而不是“api.test.com”)

**另 外client和server的Common Name需要一样**

* 其他需要填写的信息为了避免有误，都填写 . 吧（为了和 CA 根证书匹配）

用 CA 签发

> `openssl x509 -req -sha256 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -days 3650 -out server.crt`

### 客户端证书

> `openssl genrsa -out client.pem 1024`
>
> `openssl rsa -in client.pem -out client.key`
>
> `openssl req -new -key client.pem -out client.csr`
>
> `openssl x509 -req -sha256 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -days 3650 -out client.crt`

### ------------------------各种格式转换---------------------------------

> a. crt+key转pfx【pfx是证书安装包，方便在电脑上直接双击按向导安装证书】
>
> ```
> openssl pkcs12 -export -in client.crt -inkey client.key -out client.pfx
> ```
>
> b. pfx转化为pem【curl需要pem格式文件】
>
> ```
> openssl pkcs12 -in client.pfx -nodes -out client.pem
> ```
>
> c. crt+key转p12【apache的cxf客户端支持jks和p12证书】
>
> ```
> openssl pkcs12 -export -clcerts -in client.crt -inkey client.key -out client.p12
> ```
>
> d. crt转jks【jks支持存放信任证书，而pkcs12不支持，所以tomcat环境下配置ca只能使用jks才能保证ca密钥不泄露】
>
> ```
> keytool -import -v -trustcacerts -storepass defaultpwd -keypass defaultpwd -file ca.crt -keystore ca_only.jks
> ```

openssl pkcs12 -export -clcerts -in client.crt -inkey client.key  -out client.p12

openssl x509 -in ca.crt  -noout -purpose

## Tengine2.2.2报错

使用命令见以下报错，解决方法是：_**Common Name写全要带"https"的，而且client和server的Common Name要一样，**_

`curl --insecure --key ./client.key --cert ./client.crt "https://api.test.com" -v`

```
* About to connect() to api.test.com port 443 (#0)
*   Trying 47.88.227.162...
* Connected to api.test.com (47.88.227.162) port 443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
* skipping SSL peer certificate verification
* NSS: client certificate from file
*     subject: E=jz,CN=api.test.com,OU=jz,O=jz,L=jz,ST=jz,C=jz
*     start date: Oct 22 16:42:27 2018 GMT
*     expire date: Oct 19 16:42:27 2028 GMT
*     common name: api.test.com
*     issuer: E=jz,CN=api.test.com,OU=jz,O=jz,L=jz,ST=jz,C=jz
* SSL connection using TLS_RSA_WITH_AES_256_CBC_SHA
* Server certificate:
*     subject: E=jz,CN=api.test.com,OU=jz,O=jz,L=jz,ST=jz,C=jz
*     start date: Oct 22 16:41:54 2018 GMT
*     expire date: Oct 19 16:41:54 2028 GMT
*     common name: api.test.com
*     issuer: E=jz,CN=api.test.com,OU=jz,O=jz,L=jz,ST=jz,C=jz
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: api.test.com
> Accept: */*
> 
< HTTP/1.1 400 Bad Request
< Server: Tengine/2.2.2
< Date: Tue, 23 Oct 2018 12:17:54 GMT
< Content-Type: text/html
< Content-Length: 589
< Connection: close
< 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html>
<head><title>400 The SSL certificate error</title></head>
<body bgcolor="white">
<h1>400 Bad Request</h1>
<p>The SSL certificate error. Sorry for the inconvenience.<br/>
Please report this message and include the following information to us.<br/>
Thank you very much!</p>
<table>
<tr>
<td>URL:</td>
<td>https://api.test.com/</td>
</tr>
<tr>
<td>Server:</td>
<td>izt4n8pyh52ipvk1373tyfz</td>
</tr>
<tr>
<td>Date:</td>
<td>2018/10/23 20:17:54</td>
</tr>
</table>
<hr/>Powered by Tengine/2.2.2</body>
</html>
* Closing connection 0
```



