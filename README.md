# 尝试通过GitBook+GitHub搭自己的博客

刚毕业的时候，尝试自己搭过一些博客。回顾一下：

博客的平台尝试了两个

* B3log

尝试这个的原因是因为它开源，并且由 java实现，哪时由.NET转java想着多学一些。然后就开发玩了起来，太早，影响不是太深！ 影响中存储图片时不太方便，还需要使用百度BCE插件。 写了一些博文，后面了解到了WordPress，就转WordPress了

* WordPress

WordPress使用的时间最长，差不多两年多。比较主流的博客平台 ，插件、皮肤等都非常 多，贡献者也比较多。还可以倒腾下PHP~~

部署方式就比较多了

1. 首先尝试了SAE。 最开始免费，不需要备案就能绑定域名，， 随着收费和备案问题就转了
2. 然后是BAE。 哪时BAE和SAE差不多。
3. RedHat Cloud。 这个很不错，但是国内访问的速度比较慢，也就慢慢放弃了。 这个平台还有个好玩的，可以其它RedHat提供的SSH连接搭一个免费的翻墙工具。
4. GAE。谷歌的，很不错，，  但是后来被限制的很严重，GoAgent等很好的应用都没法再使用了。
5. 后面稳定了一段时间。 在阿里购买了最低配置的服务器，通过该服务器把域名备了案。 在上面部署了MySQL+WordPress。 后来换了工作，很忙！！！ 有两个月没维护，没有给服务器续费，然后就没了~~~~

总的来说自己维护服务器是一件很麻烦的事儿，当然出了学习目的去倒腾一下是很好的，扩大自己的知识面。但是有几个缺点：

1. 收费。 免费的就别想了，功能不稳定，，三天两头就改政策。
2. 维护。要给服务器续费，给域名续费。 忘记续费的，博客的文件都没了。

少操心最好！！！

最近公司的产品要搭一个在线的帮助文件，了解到了**GitBook **这个产品。  了解了下真心不错！

1. 博客原始的文件可以存储在GitHub上，个人博客本来就是出于分享目的的。 放在GitHub上至少不用担心数据丢失了。 还有一个，程序员对GitHub都抱有天然的好感~~~
2. GitBook，可以输入Web Site、PDF、epub等格式。 后期的扩展型也好。
3. 编辑方式可以使用，GitHub、GitBookEditor、GitBookOnline。

做一个尝试吧~~~



# GitBook结构

![](/assets/github结构.png)

按我的理解分成的4部分。

1： 存储。 我们程序的一个项目\(Project\) 有一堆的源代码和其它文件 ，我们需要把这些文件给存储起来。 如果是开源的知识，或可以共享的，我们推荐使用GitHub存储（不用自己去造轮子，总是一件很好的事儿）；如果是公司内部，可以考虑使用SVN或GIT。

2：编辑器。 我们需要对GitBook的项目文件进行编辑。 如我们新建一篇文章，给文章输入一个标题，插入一些文字和图片。这些操作最好由可视化的编辑器来完成。 如果是本地，可以使用GitBook Editor来编辑；在线可以使用登录到GitBook.com在线操作。

3：构建工具。使用构建工具将GItBook Project输出成我们想要的格式。如一个Web站点，或者是PDF等。![](/assets/gitbookeditor.png)

# 相关参考

* 官网 [https://www.gitbook.com/](https://www.gitbook.com/)
* 【Gitbook】实用配置及插件介绍 [http://blog.csdn.net/zhangjk1993/article/details/50380403](http://blog.csdn.net/zhangjk1993/article/details/50380403)
* GitBookEditor 7.X百度网盘

链接：[http://pan.baidu.com/s/1qXJE7Re](http://pan.baidu.com/s/1qXJE7Re) 密码：9xlx

* [通过 GitBook 开源框架和 GitHub 私有化部署 Wiki 文档 ](http://zitiao.org/deploy/)



