# dogeland cli module
#
# license: gpl-v3
stop_rootfs(){
if [[ "$(cat $rootfs/dogeland/status)" != "Run" ]]
then
echo "">/dev/null
else
# Stop LinuxApps
pkill sshd
pkill dropbear
# Change RunStatus
rm -rf $rootfs/dogeland/status
echo "Stop">$rootfs/dogeland/status
# Stop Core
pkill proot
$TOOLKIT/proot -r $START_DIR -b /system -b /proc -b /sys /usr/bin/busybox pkill $PACKAGE_NAME
pkill $PACKAGE_NAME
pkill sh # for chroot
fi
}