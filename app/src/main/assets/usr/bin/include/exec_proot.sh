# dogeland cli module
#
# license: gpl-v3
exec_proot(){
check_rootfs
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
fsbind_proot_init
startcmd=" $addcmd --kill-on-exit -0 --link2symlink --sysvipc -r $rootfs "
startcmd+="-w /root $cmd2"
exec $TOOLKIT/proot $startcmd
}