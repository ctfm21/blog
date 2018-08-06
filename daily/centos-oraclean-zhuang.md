# CentOS 7 安装 Oracle 11G R2

---

## 安装参考

[https://wiki.centos.org/HowTos/Oracle12onCentos7](https://wiki.centos.org/HowTos/Oracle12onCentos7)

> 注：u01表示程序安装目录,u02表示数据库文件目录

## 图形化方式安装

> yum grouplist
>
> yum groupinstall "X Window System"  
> yum groupinstall Desktop
>
> yum install xterm
>
> yum install xclock

## Xstart报错

```
Checking monitor: must be configured to display at least 256 colors
    >>> Could not execute auto check for display colors using command /usr/bin/xdpyinfo. Check if the DISPLAY variable is set.    Failed <<<<

Some requirement checks failed. You must fulfill these requirements before
```

> xstart中使用oracle用户登录,执行"runInstaller"

![](/assets/随笔/oracle_install.png)

PS：可能是我虚拟机性能太差，也可能是XStart本身很慢，UI响应巨慢！！ 在输入路径时，建议直接从剪切板中复制

![](/assets/随笔/oracle_nmhs)

> 安装Oracle11g报错：  
> Error in invoking target 'agent nmhs' of makefile   
> 解决方法：  
> cd $ORACLE\_HOME/sysman/lib  
> vi ins\_emagent.mk  
> **修改此处如下：**  
> \#===========================
>
> \#  emdctl
>
> \#===========================  
> $\(SYSMANBIN\)emdctl:  
> 　　$\(MK\_EMAGENT\_NMECTL\) -lnnz11
>
> \*\*\*\*\*\*\*VICTORY LOVES PREPARATION\*\*\*\*\*\*\*



