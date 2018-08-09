## TeamCIty+MySQL SVN中文日志乱码

---



将MySQL升级后，SVN提交的中文日志在TeamCity 上显示乱码，但是TeamCity其它信息正常。



解决方式是指定MySQL的编码格式 ，编辑my.ini，填写以下内容

```
[mysqld]
character-set-server=utf8 
[client]
default-character-set=utf8 
[mysql]
default-character-set=utf8
```



