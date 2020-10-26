# dogeland cli module
#
# license: gpl-v3
start_chroot(){
# Check RunStatus
if [[ "$(cat $rootfs/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start

check_rootfs 
mount_part
set_env
# Change Status and Start
echo "Run">$rootfs/dogeland/status
$TOOLKIT/busybox chroot $addcmd $rootfs $cmd
fi
}
