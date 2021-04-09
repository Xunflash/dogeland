exec_unshare(){
check_rootfs
vkfs_unshare_init
set_env
export unshare="$TOOLKIT/unshare $addcmd -R $rootfs "
if [ -f "$rootfs/bin/su" ];then
$unshare /bin/su -c $cmd2
else
if [ -f "$rootfs/bin/sh" ];then
$unshare /bin/sh $cmd2
pkill sh
else
if [ -f "$rootfs/bin/ash" ];then
$unshare /bin/ash $cmd2
pkill ash
else

if [ -f "$rootfs/bin/bash" ];then
$unshare /bin/bash $cmd2
pkill bash
else

if [ -f "$rootfs/bin/zsh" ];then
$unshare /bin/zsh $cmd2
pkill zsh
else
$unshare "$rootfs" $cmd2
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
unset unshare
unset cmd2
}