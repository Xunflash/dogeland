# dogeland cli module
#
# license: gpl-v3
exec_chroot(){

check_rootfs
mount_part
set_env

echo "$cmd2">$rootfs/dogeland/runcmd.sh
chmod 755 $rootfs/dogeland/runcmd.sh
# Search Login Shell
if [ -f "$rootfs/bin/su" ];then
$chroot "$rootfs" /bin/su -c /dogeland/runcmd.sh
else
if [ -f "$rootfs/bin/sh" ];then
$chroot "$rootfs" /bin/sh /dogeland/runcmd.sh
pkill sh
else
if [ -f "$rootfs/bin/ash" ];then
$chroot "$rootfs" /bin/ash /dogeland/runcmd.sh
pkill ash
else

if [ -f "$rootfs/bin/bash" ];then
$chroot "$rootfs" /bin/bash /dogeland/runcmd.sh
pkill bash
else

if [ -f "$rootfs/bin/zsh" ];then
$chroot "$rootfs" /bin/zsh /dogeland/runcmd.sh
pkill zsh
else
echo "? Can't found the shell to run command"
$chroot "$rootfs" $(cat /dogeland/runcmd.sh)
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
echo "">/dev/null
fi
# Clean Cache
rm $rootfs/dogeland/runcmd.sh
}
