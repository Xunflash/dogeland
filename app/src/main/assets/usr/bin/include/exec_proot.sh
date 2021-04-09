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
set_env
echo "Run">$rootfs/dogeland/status
vkfs_proot_init
startcmd=" $addcmd --kill-on-exit -0 --link2symlink --sysvipc "
startcmd+="-w /root $cmd2"
$TOOLKIT/proot $startcmd
unset startcmd
fi
}