## Oracle导入导出

---

创建临时表空间（排序啊，或者子查询等）

> CREATE TEMPORARY TABLESPACE tablename\_temp
>
> TEMPFILE 'C:/ORACLE/PRODUCT/10.2.0/ORADATA/ORCL/eams\_temp.dbf'
>
> size 500m
>
> autoextend on
>
> next 50m maxsize unlimited
>
> extent management local;

创建数据表（实际的数据位置）

> CREATE TABLESPACE tablename\_data
>
> LOGGING
>
> DATAFILE 'C:/ORACLE/PRODUCT/10.2.0/ORADATA/ORCL/eams\_data.dbf'
>
> SIZE 500m
>
> autoextend on
>
> next 50M maxsize unlimited
>
> extent management local;.

创建用户，关联临时空间和数据表

> CREATE USER \[username\] IDENTIFIED  BY \[password\]
>
> DEFAULT TABLESPACE tablename\_data
>
> TEMPORARY TABLESPACE tablename\_temp;

用户授权

> GRANT connect,RESOURCE,dba to \[username\];
>
> grant read,write on directory PATH to \[username\];

创建目录

（单引号里面的内容是导入的目录，与前面创建的目录相同）

SQL&gt;

> create or replace directory \_**datadp **\_as 'D:\app\shuhao\oradata\orcl';

查看管理理员目录（同时查看操作系统是否存在，因为Oracle并不关心该目录是否存在，如果不存在，则出错）

> select \* from dba\_directories;

导出对应账户的数据

> expdp \[userName\]/\[password\]@orcl directory=data\_name dumpfile=JEECG\_20180226.DMP logfile=jeecg.log schemas=\[tabespace\]

还原数据

> sqlplus system/orcl@orcl

将文件放在该目录下

`impdp username/password@orcl directory=data_dpdumpfile=JEECG_20180226.DMP`

`logfile=jeecg.log remap_schema =[tablespace]:[tablespace]`

remap\_schema:映射，左右tablespace，估计导的正确的话，不用这样写，像下面一样

3\)导入表空间

> impdp system/manager DIRECTORY=dpdata1 DUMPFILE=tablespace.dmp TABLESPACES=example;

4\)导入数据库

> impdb system/manager DIRECTORY=dump\_dir DUMPFILE=full.dmp FULL=y;



