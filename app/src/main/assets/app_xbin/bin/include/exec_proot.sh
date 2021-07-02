# dogeland cli module
#
# license: gpl-v3
exec_proot(){
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
set_env
fsbind_proot_init
startcmd=" $addcmd --kill-on-exit -0 --link2symlink --sysvipc -r $rootfs "
startcmd+="-w /root $cmd2"
exec $TOOLKIT/bin/proot $startcmd
}