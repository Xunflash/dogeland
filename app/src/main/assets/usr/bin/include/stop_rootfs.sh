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
$TOOLKIT/proot -r $PREFIX -b /system -b /proc -b /sys /bin/pkill $PACKAGE_NAME
pkill $PACKAGE_NAME
fi
}