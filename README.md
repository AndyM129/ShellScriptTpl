# script_tpl.sh

## Introduction

`script_tpl.sh` 是一个Shell 脚本模板

通过预制常用常量、变量、方法定义，及复杂参数解析

实现快速开发的目的

## Features

1. 预定义 文件、版权、版本、更新日志 等的版权信息
2. 预定义 系统版本、时间、路径等运行时信息
3. 预定义 `debug`、`verbose` 模式，以控制输出
4. 预定义 `echoDebug`、`echoInfo`、`echoSuccess`、`echoWarn`、`echoError`、`echoFatal` 等分级信息输出
5. 预定义 "参数解析"、”使用说明“ 等核心处理

## Usage

可通过 `sh script_tpl.sh -h` 来查看使用说明：
```shell
Andys-MacBook-Pro-2018:ShellScriptTpl mengxinxin$ sh script_tpl.sh -h
脚本名称: script_tpl.sh
功能简介: Shell 脚本模板，已预制常用常量、变量、方法定义，及复杂参数解析，以便快速开始核心编程。
当前版本: 1.1.0
最近更新: 2021/04/01
作    者: MengXinxin <andy_m129@163.com>
说明文档: https://github.com/AndyM129

=============================================================

Usage:

	$ sh script_tpl.sh <command> [params...] [--Option [value] [-sub_option [value]]...]...

Commands:
	command1:	命令1
	command2:	命令2

Options:
	--opt1:		选项1
	--opt2:		选项2
	--updatelog:	脚本的更新日志
	--version:	当前脚本版本
	--help:		查看使用说明

SubOptions:
	-sub_opt1:	子选项1
	-sub_opt2:	子选项2
Andys-MacBook-Pro-2018:ShellScriptTpl mengxinxin$ 
```

![image-20210402174222623](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183643.png)

### Example 1：类似 `find` 的系统风格


```sh
# 套用如下示例
find ./ -maxdepth 1  -type d  ! -name "hhh"
find ./test -path "test/test4" -prune -o -print

# 当前脚本的执行方式&效果如下
sh script_tpl.sh ./ -maxdepth 1  -type d  ! -name "hhh"
sh script_tpl.sh ./test -path "test/test4" -prune -o -print
```

|   命令1   |   命令2   |
| ---- | ---- |
|   ![image-20210402175255800](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183940.png)   |  ![image-20210402175618227](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183948.png)   |

### Example 2：类似`xcodebuild` 的分离可选参数风格

```shell
# 套用如下示例
xcodebuild -workspace Example.xcworkspace -scheme Example -sdk iphoneos -configuration Release clean archive -archivePath "~/Desktop/Archive"

# 当前脚本的执行方式&效果如下
sh script_tpl.sh -workspace Example.xcworkspace -scheme Example -sdk iphoneos -configuration Release clean archive -archivePath "~/Desktop/Archive"
```

![image-20210402181246083](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183713.png)

### Example 3：类似 `git` 的命令风格

```shell
# 套用如下示例
git commt -m "commit something"
git push origin master

# 当前脚本的执行方式&效果如下
sh script_tpl.sh commt -m "commit something"
sh script_tpl.sh push origin master
```

| 命令1                                                        | 命令2                                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image-20210402180429547](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183853.png)|![image-20210402180553912](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183902.png) |

### Example 4：全能的混合风格

```shell
sh script_tpl.sh -v command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"# sh template_2.sh -v command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"
```

![image-20210402181514897](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20210402183724.png)

### Example ∞：其他

```shell
sh script_tpl.sh command p1 p2 p3 --option1 -subOption1 aaa -subOption2 bbb --option2 -subOption1 ccc -subOption2 ddd

sh script_tpl.sh command p1 p2 p3 "p4,p5,p6" --option1 -subOption1 aaa -subOption2 bbb --option2 -subOption1 ccc -subOption2 ddd

sh script_tpl.sh command p1 p2 p3 p4,p5,p6 --option1 -subOption1 aaa -subOption2 bbb --option2 -subOption1 ccc -subOption2 ddd

sh script_tpl.sh command p1 p2 p3 p4,p5,p6 --option1 -subOption1 aaa -subOption2 bbb --option2 22 -subOption1 ccc -subOption2 ddd eee

sh script_tpl.sh command p1 p2 p3 p4,p5,p6 --option1 -subOption1 "a a a" -subOption2 bbb --option2 22 -subOption1 ccc -subOption2 ddd eee

sh script_tpl.sh -dv command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"

sh script_tpl.sh -v command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"

sh script_tpl.sh -d command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"

```



## Install （⭐️ Recommended）

> 注：以下内容为针对 MacOS 进行的配置&说明。

以上，是脚本的基础用法，但是更推荐直接安装到本地，即可 像执行系统命令一样的进行备份，具体方法如下。

1. 打开`~/.bashrc`文件，并追加如下代码

  ```shell
  ##############################【Backup】#################################
  alias sst.install='install_path="/Users/$USER/.bash_files/ShellScriptTpl"; git_url="https://github.com/AndyM129/ShellScriptTpl.git"; rm -rf "$install_path"; git clone $git_url $install_path; echo "script_tpl.sh install success: $install_path"; open $install_path;'
  alias sst.opendir='open /Users/$USER/Documents/ShellScriptTpl'
  ```
  
2. 执行如下命令，以便让修改生效

	```shell
	source ~/.bashrc # 可在任意目录下执行
	```

3. 安装

	```shell
	sst.install # 可在任意目录下执行
	```

4. 完成

	

## UpdateLog

### 2021/03/31: v1.0.0 
* 立项，参考 `xcodebuild` 命令，实现基于参数键值对方式的参数处理，如：

	```shell
	sh template.sh --command1 -option11 aaa -option12 bbb --command2 -option21 ccc -option22 ddd eee fff ggg
	```

### 2021/04/01: v1.1.0
* 参考 `pod` 命令，扩展实现 支持命令、选项、参数，或同时输入的参数处理，如：

	```shell
	sh template_2.sh -d command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"
	```

	

## Author

AndyMeng, andy_m129@163.com

If you have any question with using it, you can email to me. 

## Collaboration

Feel free to collaborate with ideas, issues and/or pull requests.

## License

AMKCategories is available under the MIT license. See the LICENSE file for more info.




