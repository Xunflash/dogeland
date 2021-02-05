# dogeland cli module
#
# license: gpl-v3
exec_proot(){
check_rootfs 
set_env
# Enable Fake ProcStat
if [ -e "$rootfs/proc/.stat" ];then
export addcmd="$addcmd -b $rootfs/proc/.stat:/proc/stat"
else
echo "">/dev/null
fi 
# Enable DebugMessage
if [ -e "$CONFIG_DIR/.debug" ];then
export addcmd="$addcmd -v $(cat $CONFIG_DIR/.debug)"
else
echo "">/dev/null
fi 
# Enable FakeKernel
if [ -f "$CONFIG_DIR/fake_kernel" ];then
export fake_kernel=$(cat $CONFIG_DIR/fake_kernel)
export addcmd="$addcmd -k $fake_kernel -b $rootfs/proc/.version:/proc/version"
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
# Exec Command
startcmd="$addcmd --kill-on-exit "
startcmd+="--link2symlink -0 --sysvipc -r $rootfs -b /dev  -b $rootfs/home:/dev/shm "
startcmd+="-b /proc -b /sys -b /proc/self/fd:/dev/fd -b /dev/null:/dev/tty0 "
startcmd+="-b /dev/urandom:/dev/random "
#startcmd+="-b /proc/self/fd/0:/dev/stdin -b /proc/self/fd/1:/dev/stdout -b /proc/self/fd/2:/dev/stderr "
startcmd+="-w /root $cmd2"
$TOOLKIT/proot $startcmd
unset startcmd
}
