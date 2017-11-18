# adb-standalone
==========

没错，就是 Android 开发中，我们经常用到的那个 adb 工具。

在 Android 开发中，我们借助于 adb，让我们的开发电脑可以和 Android 设备进行通信，从设备中拉文件出来，向设备中推文件进去等等，各种各样的开发调试工作都离不开 adb 的帮助。

然而，adb 工具具有一些固定的弱点，让我们在很多时候想要对它进行增强与扩展。举两个例子，一是 adb 的 `-a` 参数。adb server 在开发电脑上启动之后，会监听一个端口，等待设备通过这个端口与它建立连接，默认情况下 adb 监听 localhost 的端口，而不是电脑上所有 IP 地址上的端口。但有些时候，我们需要 adb 可以监听在主机上所有的 IP 地址上，`-a` 参数就是用于这种目的的。然而 adb 的实现存在 bug，这个参数实际上无法正常工作，因而需要对它做一些扩展。

adb 的另一个问题是，它同时只能最多支持 16 个模拟器，这在某些场景下也是极大的问题。因而也需要对 adb 做扩展。

adb 工具的源码通常位于 android 源码树的 `system/core/adb` 下。在编译整个 Android 源码树时，可以编译出用于本机的 adb 工具。

然后为了编译一个 adb 而下载编译整个 android 源码树，代价就有点太大了。

本项目提供一个脚本，也就是 adb-download-make.sh，下载 adb 及与其有关的项目的源码，并自动完成编译过程，生成 adb 可执行文件。

本项目与其它众多独立编译 adb 工具的项目相比，最大的优势在于，采用了但前比较新的版本 `android-8.0.0_r34` 的代码。

工具的用法非常简单：
```
$ git clone https://github.com/hanpfei/adb-standalone.git
$ cd adb-standalone
$ ./adb-download-make.sh
```

最终生成的 adb 工具将位于 `adb-standalone` 目录下。
