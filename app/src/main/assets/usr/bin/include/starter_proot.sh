# dogeland cli module
#
# license: gpl-v3
start_proot(){
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start Process

# Enable DebugOutput
if [ -e "$CONFIG_DIR/.debug" ];then
export addcmd="$addcmd -v $(cat $CONFIG_DIR/.debug)"
else
echo "">/dev/null
fi 
# Enable QEMU Emulator
if [ -f "$CONFIG_DIR/emulator_qemu.config" ];then
export qemu="$TOOLKIT/qemu-user-$(cat $CONFIG_DIR/emulator_qemu.config)"
export addcmd="$addcmd -q $qemu"
else
echo "">/dev/null
fi 
echo "Starting"
echo "Run">$rootfs/dogeland/status
fsbind_proot_init
set_env
startcmd=" $addcmd -0 --link2symlink --sysvipc -r $rootfs "
startcmd+="-w /root $cmd"
exec $TOOLKIT/proot $startcmd
fi
}