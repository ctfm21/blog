当进行用户管理，系统配置功能时， 需要进行管理员认证。



但是填写用户名和密码后，直接定向到“secure/admin/WebSudoAuthenticate.jspa”页面。



---

解决方案：

Jira安装目录conf/server.xml中，

&lt;Context path="/" docBase="${catalina.home}/atlassian-jira" reloadable="false" useHttpOnly="true"&gt;

改为

&lt;Context_** path="" **_docBase="${catalina.home}/atlassian-jira" reloadable="false" useHttpOnly="true"&gt;

path由/改为空字符串

