## How to install Rootfs correctly for users without ROOT?
Without ROOT, rootfs can only be stored in the data directory of the application, so users without ROOT please pay attention to the following points when installing Rootfs  
1.Check the "Install to app data directory" option  
2.Fill in the container alias you like in the installation path (not the full path)  
For example, I check "Install to app data directory" and fill in ‘test’ in the installation path, which will redirect to /data/data/me.flytree.dogeland/files/test  
3.Continue to install normally  
## What container engine is "fullns"?
The full name of fullns is Full-Namespace, which is the complete Linux namespace. With it, you can start a complete Linux system and use your favorite init program (for example: systemd, openrc, etc.), but this requires kernel support😊  
CONFIG_NAMESPACES=y  
CONFIG_UTS_NS=y  
CONFIG_IPC_NS=y  
# CONFIG_USER_NS is not set  
CONFIG_PID_NS=y  
CONFIG_NET_NS=y  
Turn on the kernel functions listed above, then recompile the kernel and flash into your device to use the fullns container.  
## How to find Rootfs?  
Can be found from Release.  
## Does dogeland charge?  Will it be open source?  
NO,YES  
## Why set the Chinese version as the master branch?  
This is necessary for maintenance and updates. Other languages ​​will release a stable version. This version is very stable and will not affect functional errors, so don’t worry.  