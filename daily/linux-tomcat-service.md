## Tomcat 注册为Linux服务

---

## 1，service tomcat start\|stop

mv catalina.sh /etc/init.d/tomcat

修改tomcat文件，加入以下代码

```
#chkconfig: 2345 10 90
#description:Tomcat service
CATALINA_HOME=/apache-tomcat-8.5.32
#JAVA_HOME=/usr/share/java/jdk #通过 rpm 安装，存在 java不用设置
```

```
chmod 755 /etc/init.d/tomcat
chkconfig --add tomcat
chkconfig --list
```

## 2，systemctl start\|stop\|status tomcat.service

vi bin/setenv.sh \#设置进程ID

```
CATALINA_PID="$CATALINA_BASE/tomcat.pid"
```

cd /usr/lib/systemd/system

vi tomcat.service

```
[Unit]
Description=Tomcat Service
After=syslog.target network.target

[Service]
Type=forking
PIDFile=/apache-tomcat-8.5.32/tomcat.pid
ExecStart=/apache-tomcat-8.5.32/startup.sh 
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
#User=tomcat
#Group=tomcat 

[Install]
WantedBy=multi-user.target
```

sysetemctl enable tomcat



