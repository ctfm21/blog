# CentOS 7 安装 Oracle 11G R2

---

参考 ： [https://wiki.centos.org/HowTos/Oracle12onCentos7](https://wiki.centos.org/HowTos/Oracle12onCentos7)



## 图形化方式安装

yum grouplist

yum groupinstall "X Window System"  
yum groupinstall Desktop

yum install xterm

yum install xclock

```
Checking monitor: must be configured to display at least 256 colors
    >>> Could not execute auto check for display colors using command /usr/bin/xdpyinfo. Check if the DISPLAY variable is set.    Failed <<<<

Some requirement checks failed. You must fulfill these requirements before
```

xstart中使用oracle用户登录,使用"runInstaller"

