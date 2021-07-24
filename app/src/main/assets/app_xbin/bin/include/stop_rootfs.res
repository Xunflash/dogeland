stop_rootfs(){
if [[ "$(cat $rootfs/boot/dogeland/status)" != "Run" ]]
then
echo "">/dev/null
else
pkill sshd
# kill -s 1 `pgrep -f sh`
pkill dropbear
pkill sshd
echo "Stop">$rootfs/boot/dogeland/status
pkill proot
pkill systemd
pkill unshare
if [ -d "/apex" ];then
  $TOOLKIT/bin/proot -r $TOOLKIT -b /system -b /proc -b /sys -b /dev -b /vendor -b /apex /bin/busybox pkill $PACKAGE_NAME
  else
  $TOOLKIT/bin/proot -r $TOOLKIT -b /system -b /proc -b /sys -b /dev -b /vendor /bin/busybox pkill $PACKAGE_NAME
fi
pkill $PACKAGE_NAME
pkill sh # for chroot
fi
}