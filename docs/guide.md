## 如何为没有ROOT的用户正确安装Rootfs？
 如果没有ROOT，则rootfs只能存储在应用程序的数据目录中，因此，没有ROOT的用户在安装Rootfs时请注意以下几点
 1.选中“安装到应用程序数据目录”选项
 2.在安装路径填写你喜欢的容器别名（不是完整路径）
 例如，我勾选“安装到应用程序数据目录”并在安装路径中填写“test”，它将重定向到/data/data/me.flytree.dogeland/files/test
 3.继续正常安装
 ## “fullns”是什么容器引擎？
 fullns的全称是Full-Namespace，是完整的Linux命名空间。 有了它，你就可以启动一个完整的Linux系统，使用你喜欢的init程序（例如：systemd、openrc等），但这需要内核支持😊
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 打开上面列出的内核函数，然后重新编译内核并刷入您的设备以使用 fullns 容器。
 ## 如何找到Rootfs？
 可以从Release中找到。
 ## dogeland 收费吗？ 它会是开源的吗？
 不，是
 ## 为什么要设置中文版为master分支？
 这是维护和更新所必需的。 其他语言将发布稳定版本。 这个版本很稳定，不会影响功能性错误，不用担心。