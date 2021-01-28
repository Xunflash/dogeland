# dogeland cli module
#
# license: gpl-v3
start_proot(){
export PROOT_TMP_DIR="$TMPDIR"
export PROOT_LOADER="$PREFIX/libexec/loader"
if [[ "$platform" != "x86_64" ]] && [[ "$platform" != "arm64" ]]
then
echo "">/dev/null
else
export PROOT_LOADER_32="$PREFIX/libexec/loader32"
fi
check_rootfs
# Check RunStatus
if [[ "$(cat $rootfs/dogeland/status)" != "Stop" ]]
then
# if Run,Then Stop
stop_rootfs
else
# Start

# Enable DebugMessage
if [ -e "$CONFIG_DIR/.debug" ];then
export addcmd="$addcmd -v $(cat $CONFIG_DIR/.debug)"
else
echo "">/dev/null
fi 

# Enable Fake ProcStat
if [ -e "$rootfs/proc/.stat" ];then
export addcmd="$addcmd -b $rootfs/proc/.stat:/proc/stat"
else
echo "">/dev/null
fi 

# Enable FakeKernel
if [ -e "$CONFIG_DIR/fake_kernel" ];then
export fake_kernel=$(cat $CONFIG_DIR/fake_kernel)
export addcmd="$addcmd -k $fake_kernel -b $rootfs/proc/.version:/proc/version"
else
echo "">/dev/null
fi 

# Enable QEMU Emulator
if [ -f "$CONFIG_DIR/emulator_qemu" ];then
export qemu="$TOOLKIT/qemu-$(cat $CONFIG_DIR/emulator_qemu)"
export addcmd="$addcmd -q $qemu"
else
echo "">/dev/null
fi 

set_env
# Change Status and Start
echo "Run">$rootfs/dogeland/status
startcmd="$addcmd -0 --link2symlink "
startcmd+="-r $rootfs -b /dev -b /sys -b /proc -b $rootfs/home:/dev/shm "
startcmd+="-b /proc/self/fd:/dev/fd -b /dev/null:/dev/tty0 "
startcmd+="-b /dev/urandom:/dev/random -b /:/mnt/host-rootfs "
#startcmd+="-b /proc/self/fd/0:/dev/stdin -b /proc/self/fd/1:/dev/stdout -b /proc/self/fd/2:/dev/stderr "
startcmd+="-w /root $cmd"
$TOOLKIT/proot $startcmd
unset startcmd
fi
}