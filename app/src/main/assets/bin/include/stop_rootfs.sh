# dogeland cli module
#
# license: gpl-v3
stop_rootfs(){
if [[ "$(cat $rootfs/dogeland/status)" != "Run" ]]
then
echo "">/dev/null
else
# Stop SomeLinuxApp
pkill sshd
pkill dropbear
pkill vncserver
pkill ash
pkill zsh
pkill bash
# Change RunStatus
rm -rf $rootfs/dogeland/status
echo "Stop">$rootfs/dogeland/status
# Stop Core
pkill sh
pkill proot

fi
}