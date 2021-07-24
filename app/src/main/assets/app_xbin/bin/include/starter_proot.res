# dogeland cli module
#
# license: gpl-v3
start_proot(){
echo "progress:[1/1]"
export PROOT_TMP_DIR="$TMPDIR"
export PROOT_LOADER="$TOOLKIT/libexec/libloader.so"
if [[ "$platform" != "x86_64" ]] && [[ "$platform" != "arm64" ]]
then
echo "">/dev/null
else
export PROOT_LOADER_32="$TOOLKIT/libexec/libloader32.so"
fi
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/boot/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start Process
init_boxenv
# Enable DebugOutput
if [ -e "$CONFIG_DIR/.debug" ];then
export addcmd="$addcmd -v $(cat $CONFIG_DIR/.debug)"
else
echo "">/dev/null
fi 
# Enable QEMU Emulator
if [ -f "$CONFIG_DIR/emulator_qemu.config" ];then
export qemu="$TOOLKIT/bin/qemu-user-$(cat $CONFIG_DIR/emulator_qemu.config)"
export addcmd="$addcmd -q $qemu"
else
echo "">/dev/null
fi 
echo "Starting"
echo "Run">$rootfs/boot/dogeland/status
fsbind_proot_init
set_env
startcmd=" $addcmd -0 --link2symlink --sysvipc -r $rootfs "
startcmd+="-w /root $cmd"
exec $TOOLKIT/bin/proot $startcmd
fi
}