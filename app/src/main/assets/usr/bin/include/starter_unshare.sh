start_unshare(){
echo "progress:[1/1]"
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start Process
echo "Starting"
fsbind_unshare_init
set_env
echo "Run">$rootfs/dogeland/status
exec $TOOLKIT/unshare $addcmd -R $rootfs $cmd # --mount-proc
fi
}