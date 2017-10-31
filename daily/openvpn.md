# OpenVPN安装步骤

15年记录的，有些久！ 其中一些下载链接也无法使用了，仅仅做个记录。

---

## 安装

ubuntu

> apt-get install openvpn

centos

> yum install openvpn

**easy-rsa**



[http://swupdate.openvpn.org/community/releases/easy-rsa-2.2.0\_master.tar.gz](http://swupdate.openvpn.org/community/releases/easy-rsa-2.2.0_master.tar.gz)

将easy-rsa解压，将其中2.0目录下的文件拷贝到 /etc/openvpn下。

* 配置PKI

```
# cd /etc/openvpn/
# vim vars
```

找到“export KEY\_SIZE=”这行，根据情况把1024改成2048或者4096

再定位到最后面，会看到类似下面这样的

export KEY\_COUNTRY=”US”

export KEY\_PROVINCE=”CA”

export KEY\_CITY=”SanFrancisco”

export KEY\_ORG=”Fort-Funston”

export KEY\_EMAIL=”

[me@myhost.mydomain](mailto:me%40myhost.mydomain)

“

这个自己根据情况改一下，不改也可以运行。其实不改vars这个文件，vpn也可以跑起来。

例如：

export KEY\_COUNTRY=”CN”

export KEY\_PROVINCE=”CD”

export KEY\_CITY=”Chengdu”

export KEY\_ORG=”witaction.com”

export KEY\_EMAIL=”test@witaction.com“

注：在后面生成服务端ca证书时，这里的配置会作为缺省配置

做SSL配置文件软链：

```
# ln -s openssl-1.0.0.cnf openssl.cnf
```

修改vars文件可执行并调用

```
# chmod +x vars
```

* ## 生成证书 {#id-搭建OpenVPN-生成证书}

#### 3.1、产生CA证书 {#id-搭建OpenVPN-3.1、产生CA证书}

```
# source ./vars
```

NOTE: If you run ./clean-all, I will be doing a rm -rf on /etc/openvpn/keys

注：也就是如果执行./clean-all，就会清空/etc/openvpn/keys下所有文件

开始配置证书：

* 清空原有证书

```
# ./clean-all
```

注：下面这个命令在第一次安装时可以运行，以后在添加完客户端后慎用，因为这个命令会清除所有已经生成的证书密钥，和上面的提示对应

* 生成服务器端ca证书

```
# ./build-ca
```

注：由于之前做过缺省配置，这里一路回车即可

#### 3.2、产生服务器证书 {#id-搭建OpenVPN-3.2、产生服务器证书}

```
# ./build-key-server openvpn.example.com
```

生成服务器端密钥证书, 后面这个[openvpn.example.com](http://openvpn.example.com/)就是服务器名，也可以自定义，可以随便起，但要记住，后面要用到。

#### 3.3、生成DH验证文件 {#id-搭建OpenVPN-3.3、生成DH验证文件}

```
# ./build-dh
```

生成diffie hellman参数，用于增强openvpn安全性（生成需要漫长等待），让服务器飞一会。

#### 3.4、生成客户端证书 {#id-搭建OpenVPN-3.4、生成客户端证书}

```
# ./build-key client1
# ./build-key client2
```

（名字任意，建议写成你要发给的人的姓名，方便管理）

注：这里与生成服务端证书配置类似，中间一步提示输入服务端密码，其他按照缺省提示一路回车即可。

#### 3.5、生成ta.key文件 {#id-搭建OpenVPN-3.5、生成ta.key文件}

```
# openvpn --genkey --secret /etc/openvpn/keys/ta.key
```

  


#### 3.6、编辑服务配置文件 {#id-搭建OpenVPN-3.6、编辑服务配置文件}

```
# vim /etc/openvpn/server.conf
```

```
# 设置用TCP还是UDP协议？
;proto tcp
proto tcp
```



```
# 这里是重点，必须指定SSL/TLS root certificate (ca),
# certificate(cert), and private key (key)
# ca文件是服务端和客户端都必须使用的，但不需要ca.key
# 服务端和客户端指定各自的.crt和.key
# 请注意路径,可以使用以配置文件开始为根的相对路径,
# 也可以使用绝对路径
# 请小心存放.key密钥文件
ca keys/ca.crt
cert keys/openvpn.example.com.crt
key keys/openvpn.example.com.key # This file should be kept secret
```



```
# 指定Diffie hellman parameters.
dh keys/dh1024.pem
```





定位到tls-auth行，设置如下：

```
tls-auth keys/ta.key 0 # This file is secret，客户諯一会设置成 1 (
tls-auth ta.key 1
)
```



```
# 配置VPN使用的网段，OpenVPN会自动提供基于该网段的DHCP服务，但不能和任何一方的局域网段重复，保证唯一
server 10.8.0.0 255.255.255.0
```



加入以下脚本（这样设置后，就可以连内外网互联了）

push "route 10.8.0.0 255.255.255.0"  
push "redirect-gateway def1 bypass-dhcp bypass-dns"  
push "dhcp-option DNS 8.8.8.8"  
push "dhcp-option DNS 8.8.4.4"



```
# 日志文件
log         /var/log/openvpn/openvpn.log
log-append  /var/log/openvpn/openvpn.log
```

PS：目录不存在时mkdir

#### 3.7 启动服务 {#id-搭建OpenVPN-3.7启动服务}

```
# service openvpn start
```



```
# vim /etc/sysctl.conf
```

找到net.ipv4.ip\_forward = 0

把0改成1

```
# sysctl -p
```



设置iptables（这一条至关重要，通过配置nat将vpn网段IP转发到server内网）

```
# iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j MASQUERADE
```



