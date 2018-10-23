# Nginx 双向认证 失败 报错400

---

配置参见：

[https://www.cnblogs.com/UnGeek/p/6049004.html](https://www.cnblogs.com/UnGeek/p/6049004.html)

[https://blog.csdn.net/witmind/article/details/78456660](https://blog.csdn.net/witmind/article/details/78456660)



使用命令

`curl --insecure --key ./client.key --cert ./client.crt "https://api.test.com" -v`

报错

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



