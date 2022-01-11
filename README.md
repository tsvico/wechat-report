# 看看样子

  没有对各个屏幕做适配 && 请用手机看(可以用浏览器-开发者工具 模拟)

  https://myth.icu/wechat-report/

# 教程

IOS 转 原作者仓库 https://github.com/myth984/wechat-report

MIUI 或其他能导出备份文件的 Android 系统继续往下看
## 导出微信聊天记录
原作者提供方法不适用于Android系统



> 其他手机通用做法
>
> 1. 其他手机（华为、vivo、oppo）如果可以导出微信备份，可以用解压缩工具尝试打开备份文件。
>
> 2. 如果有root可以去`/data/data/com.tencent.mm/MicroMsg`下面找这三个文件，但是很多人是不会去root的，所以介绍第三种方法。
>
> 3. 首先电脑上安装一款安卓模拟器，然后里面下载手机微信并登录，最重要的一步就是**将手机端聊天记录备份到电脑端微信，然后将电脑端聊天记录恢复到安卓虚拟器里的微信**，这个功能是微信自带的，应该没有什么难度。然后对安卓虚拟器进行root，这个也是设置里就有的，最后就能把三个文件都拷贝到电脑上了。



使用备份方法导出`微信(com.tencent.mm).bak`(在`/内部储存设备/MIUI/backup/ALLBackup/`目录下)，使用`7Z`(解压缩工具)直接打开此备份文件

并且将

`apps\com.tencent.mm\r\MicroMsg\systemInfo.cfg`

`apps\com.tencent.mm\r\MicroMsg\CompatibleInfo.cfg`

`apps\com.tencent.mm\r\MicroMsg\xxxx\EnMicroMsg.db`

三个文件解压到电脑上。这里xxxx是一串随机的字母，代表你的微信用户，当登陆过多个微信用户时，会有多个这种文件夹，一般`EnMicroMsg.db`最大的那个是你最常用的账号。

`IMEI.class`是我编译好的，可以直接运行 `java IMEI systemInfo.cfg CompatibleInfo.cfg` 导出密码，The key 就是你的数据库密码

<img src="img\image-20220101133136333.png" alt="image-20220101133136333" style="zoom:80%;" />



## 入库

需要自己有一个`MySQL`库 (没有的可以下载个`phpstudy`)

默认具备一定`vue`/`mysql`知识

然后打开`bin\sqlcipher.exe`软件，用它打开`EnMicroMsg.db`数据库，输入得到的密码

这里我是用先导出csv再导入mysql的方法，具体操作是

1. `sqlcipher.exe`软件，点击菜单栏的`File-Export-Table as CSV file`，选择`message`表，导出

2. (可选)新建一个excel表格，点击`数据-来自文本`，然后导入这个`.csv`文件(详细步骤参见([微信聊天记录导出为电脑txt文件教程-知乎](https://zhuanlan.zhihu.com/p/77418711?utm_source=qq))

3. 打开`navicat`，新建数据库，或利用现有数据库

   <img src="img\image-20220101134150226.png" alt="image-20220101134150226" style="zoom:67%;" />

4. 右键表，点击导入向导，导入第二步的Excel或第一步的csv，选择`新建表`，需要注意的是，`content`和`reserved`需要将类型改为text或将长度调整到足够长，避免出错

   <img src="img\image-20220101134353285.png" alt="image-20220101134353285" style="zoom:67%;" />

   

   <img src="img\image-20220101134927619.png" alt="image-20220101134927619" style="zoom:67%;" />

## 数据整理

参见`bin\analysis.sql`，注释写的很详细，只需要在navicat软件或控制台里执行对应的SQL



纯文字聊天记录的导出需要在mysql配置文件中添加`secure_file_priv=''`，并执行如下命令(OUTFILE后需要改为具体路径)

```sql
-- 词导出
SELECT content  INTO OUTFILE '\home\user\ci.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM message where type = 1;
```



## 分词 & 生成词云

使用 [微词云](https://www.weiciyun.com/fenci/)(免费版够用)，将导出的`ci.txt`上传，一步步生成词云

放入`/src/asset/images/cy.jpg`

## 写入结果

将结果手动写入`/src/data.json`

## 生成html

`npm i`

`npm run build`

## 如果上面说的你都不会

你可以用你的法子, 总之把`/src/data.json` 填入就行



## 导出聊天记录参考

- https://github.com/Heyxk/notes/issues/1

- https://zhuanlan.zhihu.com/p/77418711?utm_source=qq

- https://github.com/myth984/wechat-report/blob/main/bin/analysis.py
