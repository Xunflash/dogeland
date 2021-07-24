start_unshare(){
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
fsbind_unshare_init
set_env
echo "Run">$rootfs/boot/dogeland/status
exec $TOOLKIT/bin/unshare $addcmd  $TOOLKIT/bin/chroot $rootfs $cmd
fi
}