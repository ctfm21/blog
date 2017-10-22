* 创建 一个GitHub空项目。

这里项目名取为blog；并通过git工具clone到本地。

![](/assets/github_blog.png)

![](/assets/import.png)

## 安装GitBook构建工具

* 安装NodeJS.

GitBook基于NodeJS构建。 [https://nodejs.org/en/download/](https://nodejs.org/en/download/) 下载并安装之

配置淘宝镜像（主要是国内服务器会快些）

> npm config set registry [https://registry.npm.taobao.org](https://registry.npm.taobao.org) --global
>
> npm config set disturl [https://npm.taobao.org/dist](https://npm.taobao.org/dist) --global

* 安装GitBook

> npm install gitbook-cli
>
> gitbook -V   //安装成功，执行该命令会显示gitbook版本

## 构建

* 进入本地的githup项目目录，执行以下命令初使化GitBook项目。

> gitbook init

* 在该目录下新建book.json文件。  该文件是一个配置文件。 可以配置插件、主题等。

具体的可以参照：[http://blog.csdn.net/twh\_east/article/details/54097903](http://blog.csdn.net/twh_east/article/details/54097903)

> {
>
> ```
> "language" : "zh-hans",
>
> "description" : "blog of liuyixin",
>
> "plugins": [
>
>     "-search",
>
>     "-lunr",
>
>     "disqus",
>
>     "search-pro",
>
>     "github" 
>
> \],
>
> "links" : {
>
>     "sidebar" : {
>
>         "Home" : "http://www.liuyx.net"
>
>     }
>
> },
>
> "pluginsConfig": {
>
>     "disqus": {
>
>         "shortName": "gitbookuse"
>
>     },
>
>     "search-pro": {
>
>         "cutWordLib": "nodejieba",
>
>         "defineWord" : \["Gitbook Use"\]
>
>     },
>
>     "github": {
>
>         "url": "https://github.com/yjjqrqqq/blog"
>
>     }
>
> }
> ```
>
> }

* 每次编辑完plugins后，需要执行

> gitbook install

* 执行“gitbook serve”，浏览器中 [http://localhost:4000](http://localhost:4000) 预览

> gitbook serve

## 使用GitBook Editor编辑

使用GitBookEditor可以可视化地编辑文章。

* 下载安装

官网下载：[http://downloads.editor.gitbook.com/download/windows](http://downloads.editor.gitbook.com/download/windows?user=yjjqrqqq)

百度网盘：



