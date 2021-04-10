start_unshare(){
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start Process
vkfs_unshare_init
set_env
echo "Starting"
echo "Run">$rootfs/dogeland/status
$TOOLKIT/unshare $addcmd -R $rootfs $cmd # --mount-proc
fi
}