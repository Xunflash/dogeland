start_fullns(){
echo "progress:[1/1]"
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/boot/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start Process
echo "Starting"
init_boxenv
set_env
echo "Run">$rootfs/boot/dogeland/status
exec $TOOLKIT/bin/unshare $addcmd -f --mount --uts --ipc --pid --mount-proc chroot $rootfs $cmd
fi
}