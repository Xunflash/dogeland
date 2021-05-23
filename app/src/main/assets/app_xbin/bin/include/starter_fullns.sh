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
set_env
echo "Run">$rootfs/boot/dogeland/status
exec $TOOLKIT/bin/unshare $addcmd --mount --uts --ipc --net --pid --cgroup --mount-proc -R $rootfs $cmd
fi
}