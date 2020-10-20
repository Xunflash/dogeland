start_unshare(){
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
mount_part
set_env
# Change Status and Start
echo "Run">$rootfs/dogeland/status
$TOOLKIT/unshare $addcmd -R $rootfs --mount-proc $cmd
fi
}