## TeamCity构建建卡住，不能被停止

---

需求是这样的，构建时采用了"SSH Upload"插件，而Upload时服务器可能连接不上， 这样导致整个构建被卡住。

Cancel Build不行，甚至重启TeamCity Server和Agent也不行，日志如下：

> Status:     Canceled \(Step 3/3\)    Agent:    Win192.168.0.58
>
> Progress:
>
> 49m:14s
>
> 49m:14s
>
> ```
>   Triggered by:    you on 07 Aug 18 19:03
> ```
>
> Thread dump:    View thread dump
>
> Running step:    Step 3/3: Starting upload via SCP to \[product/zeek/OnlineHealthCard\] on host \[192.168.0.5:22\]

## 解决方案

1：停止TeamCity Server

2：删除TeamCity数据库中running下的构建记录

3：重启服务

[https://youtrack.jetbrains.net/issue/TW-3154](https://youtrack.jetbrains.net/issue/TW-3154)

The solution for us is to

*  Stop Team City server service
*  Manually edit database table dbo.running
*  Start Team City server service



