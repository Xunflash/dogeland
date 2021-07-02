exec_fullns(){
echo "progress:[1/1]"
check_rootfs
set_env
init_boxenv
export unshare="exec $TOOLKIT/bin/unshare $addcmd -f --mount --uts --ipc --pid --mount-proc chroot $rootfs"
if [ -f "$rootfs/bin/su" ];then
$unshare /bin/su -c $cmd2
else
if [ -f "$rootfs/bin/sh" ];then
$unshare /bin/sh $cmd2
else
if [ -f "$rootfs/bin/ash" ];then
$unshare /bin/ash $cmd2
else
if [ -f "$rootfs/bin/bash" ];then
$unshare /bin/bash $cmd2
else
if [ -f "$rootfs/bin/fish" ];then
$unshare /bin/fish $cmd2
else
$unshare $cmd2
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
}