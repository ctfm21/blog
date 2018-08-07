## TeamCity构建建卡住，不能被停止

---

需求是这样的，构建时采用了"SSH Upload"插件，而Upload时服务器可能连接不上， 这样导致整个构建被卡住。

Cancel Build不行，甚至重启TeamCity Server和Agent也不行，日志如下：



> Status:	 Canceled \(Step 3/3\)	Agent:	Win192.168.0.58
>
> Progress:	
>
> 49m:14s
>
> 49m:14s
>
>   	Triggered by:	you on 07 Aug 18 19:03
>
> Thread dump:	View thread dump
>
> Running step:	Step 3/3: Starting upload via SCP to \[product/zeek/OnlineHealthCard\] on host \[192.168.0.5:22\]





## 解决方案



1：停止Agent 服务

2：登录Agent，删除构建目录 "C:\TeamCity\buildAgent\work\54a179beff4162b4"



