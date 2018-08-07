## Sonar /buildAgent/work/b3d287c9f71b20db

---

最初Sonar用Inner DB方式，运行良好，但是迁移到MySQL上后，报上述错误



解决方案是修改mysql "max\_allowed\_packet"参数

修改mysql my.init

\[mysqld\] 下添加 

> max\_allowed\_packet = 100M



