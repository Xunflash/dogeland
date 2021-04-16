stop_rootfs(){
if [[ "$(cat $rootfs/boot/dogeland/status)" != "Run" ]]
then
echo "">/dev/null
else
pkill sshd
# kill -s 1 `pgrep -f sh`
pkill dropbear
echo "Stop">$rootfs/boot/dogeland/status
pkill proot
$TOOLKIT/proot -r $TOOLKIT -b /system -b /proc -b /sys -b /dev -b /vendor -b /apex /busybox pkill $PACKAGE_NAME
pkill $PACKAGE_NAME
pkill sh # for chroot
fi
}