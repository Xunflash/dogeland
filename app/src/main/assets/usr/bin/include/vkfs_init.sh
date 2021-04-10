vkfs_unshare_init(){
if [ ! -n "$rootfs/dev/dotest;" ]; then
echo "creating devfs ..."
rm -rf $rootfs/dev
mkdir $rootfs/dev
mount -o bind /dev/console $rootfs/dev/console
mount -o bind /dev/full $rootfs/dev/full
mount -o bind /dev/null $rootfs/dev/null
mount -o bind /dev/pts $rootfs/dev/pts
mount -o bind /dev/shm $rootfs/dev/shm
mount -o bind /dev/stdin $rootfs/dev/stdin
mount -o bind /dev/tty $rootfs/dev/tty
mount -o bind /dev/zero $rootfs/dev/zero
mount -o bind /dev/fd $rootfs/dev/fd
mount -o bind /dev/ptmx $rootfs/dev/ptmx
mount -o bind /dev/random $rootfs/dev/random
mount -o bind /dev/stderr $rootfs/dev/stderr
mount -o bind /dev/stdout $rootfs/dev/stdout
mount -o bind /dev/urandom $rootfs/dev/urandom
mount -o bind /dev/null $rootfs/dev/tty
mount -o bind /dev/fuse $rootfs/dev/fuse
mount -o bind /dev/binder $rootfs/dev/binder
# Create a demo device
mount -o bind $TOOLKIT/virtual/dotest $rootfs/dev/dotest
# Enable FileTran
mount -o bind $DATA2_DIR/filetran $rootfs/dev/filetran
echo "creating sysfs ..."
mount -t sysfs sys $rootfs/sys
mount -o bind $TOOLKIT/virtual/fs/sys/firmware $rootfs/sys/firmware
mount -o bind $TOOLKIT/virtual/socket $rootfs/sys/virtual
echo "creating proc ..."
mount -t proc proc $rootfs/proc
else
echo "created"
fi
}
vkfs_proot_init(){
echo "creating devfs ..."
export addcmd=" $addcmd -b /dev/console -b /dev/full -b /dev/null -b /dev/pts -b $rootfs/root:/dev/shm -b /proc/self/fd:/dev/fd -b /proc/self/fd/0:/dev/stdin -b /dev/tty -b /dev/zero -b /dev/fd -b /dev/ptmx -b /dev/random -b /proc/self/fd/2:/dev/stderr -b /proc/self/fd/1:/dev/stdout -b /dev/urandom -b /dev/binder -b /dev/fuse -b $TOOLKIT/virtual/dotest:/dev/mmcblk0 -b $TOOLKIT/virtual/dotest:/dev/mmcblk0p1  -b $TOOLKIT/virtual/dotest:/dev/mmcblk0p2 -b $TOOLKIT/virtual/dotest:/dev/dotest -b $DATA2_DIR/filetran:/dev/filetran "
echo "creating sysfs ..."
export addcmd=" $addcmd -b /sys -b $TOOLKIT/virtual/fs/sys/firmware:/sys/firmware -b $TOOLKIT/virtual/socket:/sys/virtual "
echo "creating proc ..."
export addcmd=" $addcmd -b /proc "
if [ ! -r "/proc/uptime" ]; then
    echo "fixing proc ..."
    export addcmd=" $addcmd \
    -b $TOOLKIT/virtual/fs/proc/buddyinfo:/proc/buddyinfo  \
    -b $TOOLKIT/virtual/fs/proc/kallsyms:/proc/kallsyms  \
    -b $TOOLKIT/virtual/fs/proc/partitions:/proc/partitions  \
    -b $TOOLKIT/virtual/fs/proc/bus:/proc/bus  \
    -b $TOOLKIT/virtual/fs/proc/key-users:/proc/key-users  \
    -b $TOOLKIT/virtual/fs/proc/cgroups:/proc/cgroups  \
    -b $TOOLKIT/virtual/fs/proc/keys:/proc/keys  \
    -b $TOOLKIT/virtual/fs/proc/schedstat:/proc/schedstat  \
    -b $TOOLKIT/virtual/fs/proc/cmdline:/proc/cmdline  \
    -b $TOOLKIT/virtual/fs/proc/kmsg:/proc/kmsg  \
    -b $TOOLKIT/virtual/fs/proc/kpageflags:/proc/kpageflags  \
    -b $TOOLKIT/virtual/fs/proc/swaps:/proc/swaps  \
    -b $TOOLKIT/virtual/fs/proc/devices:/proc/devices  \
    -b $TOOLKIT/virtual/fs/proc/latency_stats:/proc/latency_stats  \
    -b $TOOLKIT/virtual/fs/proc/sysrq-trigger:/proc/sysrq-trigger  \
    -b $TOOLKIT/virtual/fs/proc/zoneinfo:/proc/zoneinfo  \
    -b $TOOLKIT/virtual/fs/proc/mounts:/proc/mounts  \
    -b $TOOLKIT/virtual/fs/proc/diskstats:/proc/diskstats  \
    -b $TOOLKIT/virtual/fs/proc/loadavg:/proc/loadavg  \
    -b $TOOLKIT/virtual/fs/proc/vmstat:/proc/vmstat  \
    -b $TOOLKIT/virtual/fs/proc/vmallocinfo:/proc/vmallocinfo  \
    -b $TOOLKIT/virtual/fs/proc/timer_list:/proc/timer_list  \
    -b $TOOLKIT/virtual/fs/proc/execdomains:/proc/execdomains  \
    -b $TOOLKIT/virtual/fs/proc/locks:/proc/locks  \
    -b $TOOLKIT/virtual/fs/proc/uptime:/proc/uptime  \
    -b $TOOLKIT/virtual/fs/proc/fb:/proc/fb  \
    -b $TOOLKIT/virtual/fs/proc/version:/proc/version  \
    -b $TOOLKIT/virtual/fs/proc/pagetypeinfo:/proc/pagetypeinfo  \
    -b $TOOLKIT/virtual/fs/proc/modules:/proc/modules  \
    -b $TOOLKIT/virtual/fs/proc/filesystems:/proc/filesystems  \
    -b $TOOLKIT/virtual/fs/proc/misc:/proc/misc  \
    -b $TOOLKIT/virtual/fs/proc/interrupts:/proc/interrupts  \
    -b $TOOLKIT/virtual/fs/proc/iomem:/proc/iomem  \
    -b $TOOLKIT/virtual/fs/proc/ioports:/proc/ioports"
    else
    echo "">/dev/null
fi
}