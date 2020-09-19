exec_unshare(){
check_rootfs
mount_part_proclink
set_env
echo "$cmd2">$rootfs/dogeland/runcmd.sh
chmod 0777 $rootfs/dogeland/runcmd.sh
export unshare="$TOOLKIT/unshare $addcmd -R $rootfs --mount-proc "
if [ -f "$rootfs/bin/su" ];then
$unshare /bin/su -c /dogeland/runcmd.sh
else
if [ -f "$rootfs/bin/sh" ];then
$unshare /bin/sh /dogeland/runcmd.sh
pkill sh
else
if [ -f "$rootfs/bin/ash" ];then
$unshare /bin/ash /dogeland/runcmd.sh
pkill ash
else

if [ -f "$rootfs/bin/bash" ];then
$unshare /bin/bash /dogeland/runcmd.sh
pkill bash
else

if [ -f "$rootfs/bin/zsh" ];then
$unshare /bin/zsh /dogeland/runcmd.sh
pkill zsh
else
echo "?无法启动到Shell入口"
$unshare "$rootfs" $(cat /dogeland/runcmd.sh)
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
rm $rootfs/dogeland/runcmd.sh
}