# CentOS7搭建OpenVPN遇到的一些问题

---

曾经在CentOS 6上搭过OpenVPN，感觉还挺好；最近要在阿里ECS上部署个OpenVPN以便可以访问一些内网资源，ECS为CentOS7 ，遇到一些问题，记录一下。

[安装教程](/daily/openvpn.md)  网上一搜一大堆，这是很久以前自己记录的。

着重记录一下之前相比之前遇到的一些新问题:

* 取代之前的iptables

centos 6使用iptables配置转发，网上很多仍然在centos7中装iptables。 但是这里不推荐，CentOS 7中如下：

> firewall-cmd --permanent --add-service openvpn
>
> firewall-cmd --permanent --zone=trusted --add-interface=tun0
>
> firewall-cmd --permanent --zone=trusted --add-masquerade
>
> DEV=$\(ip route get 8.8.8.8 \| awk 'NR==1 {print $\(NF-2\)}'\)
>
> firewall-cmd --permanent --direct --passthrough ipv4 -t nat -A POSTROUTING -s  10.8.0.0/24 -o $DEV -j MASQUERADE
>
> firewall-cmd --reload

参考 ：[https://panovski.me/install-and-configure-openvpn-on-a-centos-7/](https://panovski.me/install-and-configure-openvpn-on-a-centos-7/)

* 服务

> systemctl start openvpn@server  
>   //服务启动 一开始使用systemctl start openvpn报错了
>
> systemctl status openvpn@server  
>   //若服务启动失败，可以查看失败信息

* 使用udp客户端连接使用

真心不知道为何（其实偷懒了），换成tcp协议就行了。 直接将"proto udp"改成"proto tcp"后启动报错

> \[root@iZ23nzm9qhoZ openvpn\]\# systemctl status openvpn@server
>
> ● openvpn@server.service - OpenVPN Robust And Highly Flexible Tunneling Application On server
>
> Loaded: loaded \(/usr/lib/systemd/system/openvpn@.service; enabled; vendor preset: disabled\)
>
> Active: failed \(Result: exit-code\) since Tue 2017-10-31 21:55:00 CST; 2min 29s ago
>
> Process: 15682 ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/ --config %i.conf \(code=exited, status=1/FAILURE\)
>
> Main PID: 15682 \(code=exited, status=1/FAILURE\)
>
> Oct 31 21:55:00 iZ23nzm9qhoZ systemd\[1\]: Starting OpenVPN Robust And Highly Flexible Tunneling Applicat...r...
>
> Oct 31 21:55:00 iZ23nzm9qhoZ systemd\[1\]: openvpn@server.service: main process exited, code=exited, stat...LURE
>
> Oct 31 21:55:00 iZ23nzm9qhoZ systemd\[1\]: Failed to start OpenVPN Robust And Highly Flexible Tunneling A...ver.
>
> Oct 31 21:55:00 iZ23nzm9qhoZ systemd\[1\]: Unit openvpn@server.service entered failed state.
>
> Oct 31 21:55:00 iZ23nzm9qhoZ systemd\[1\]: openvpn@server.service failed.
>
> Hint: Some lines were ellipsized, use -l to show in full.

解决方法：将server.conf中的"explicit-exit-notify 1"注释。查看了下官方的说法，不推荐使用tcp方式，所以有个开关。

* **Win10问题**

公司机器上部署也连接成功。

ping 10.8.0.1 成功，但是无法访问内网资源。 使用 route print 发现是路由没有 push过来，纠结了很久没有解决（网上说以管理员方式运行，我有哪么傻？  肯定不行啊）。  晚上回到家后，用家里的win8和win10测试，竟然一路OK，路由也push过来了！！！ 明天回公司再看下吧

# 附 server.conf

> port 8089
>
> proto tcp
>
> dev tun
>
> ca keys/ca.crt
>
> cert keys/openvpn.xxx.com.crt
>
> key keys/openvpn.xxx.com.key  \# This file should be kept secret
>
> dh keys/dh2048.pem
>
> server 10.8.0.0 255.255.255.0
>
> ifconfig-pool-persist ipp.txt
>
> push "route 10.8.0.0 255.255.0.0"
>
> push "route 100.114.25.139 255.255.255.255"
>
> push "dhcp-option DNS 8.8.8.8"
>
> \#explicit-exit-notify 1



# IOS使用





