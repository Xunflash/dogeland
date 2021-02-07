# 如何制作Rootfs  
Rootfs制作方式很简单，使用一些常用的工具就可（例如 debootstrap , pacstrap, 或从各大软件源下载）  
为dogeland制作只需要在原有Rootfs添加一些信息即可  
rootfs/dogeland/cmd.conf * 预设置容器启动命令（如openssh dropbear vnc）  
rootfs/dogeland/patch.sh * 安装时执行的命令 （用于设置一些权限或者修复问题）  
然后使用喜爱的方式打包即可。  
  
# How to make Rootfs  
 Rootfs production method is very simple, use some commonly used tools (such as debootstrap, pacstrap, or download from major software sources)  
 Making for dogeland only needs to add some information to the original Rootfs  
 rootfs/dogeland/cmd.conf * Pre-set container startup commands (such as openssh dropbear vnc)  
 rootfs/dogeland/patch.sh * Command executed during installation (used to set some permissions or fix problems)  
 Then pack it in your favorite way.  
   