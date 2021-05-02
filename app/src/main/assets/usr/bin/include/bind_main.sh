fsbind_unshare_init(){
if [ ! -n "$rootfs/dev/dotest" ]; then
mount -o bind /dev $rootfs/dev
# Create a demo device
mount -o bind $TOOLKIT/virtual/dotest $rootfs/dev/dotest
# Enable FileTran
mount -o bind $DATA2_DIR/filetran $rootfs/dev/filetran
mount -t sysfs sys $rootfs/sys
mount -o bind $TOOLKIT/virtual/fs/sys/firmware $rootfs/sys/firmware
mount -o bind $TOOLKIT/virtual/socket $rootfs/sys/virtual
mount -t proc proc $rootfs/proc
else
echo "">/dev/null
fi
}
fsbind_proot_init(){
export addcmd=" $addcmd -b /dev -b $DATA2_DIR/filetran:/dev/filetran "
export addcmd=" $addcmd -b /sys -b $TOOLKIT/virtual/fs/sys/firmware:/sys/firmware -b $TOOLKIT/virtual/socket:/sys/virtual "
export addcmd=" $addcmd -b /proc "
if [ ! -r "/proc/uptime" ]; then
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
    -b $TOOLKIT/virtual/fs/proc/kpagecount:/proc/kpagecount  \
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
    -b $TOOLKIT/virtual/fs/proc/stat:/proc/stat  \
    -b $TOOLKIT/virtual/fs/proc/config.gz:/proc/config.gz  \
    -b $TOOLKIT/virtual/fs/proc/crypto:/proc/crypto  \
    -b $TOOLKIT/virtual/fs/proc/app_info:/proc/app_info  \
    -b $TOOLKIT/virtual/fs/proc/consoles:/proc/consoles  \
    -b $TOOLKIT/virtual/fs/proc/version:/proc/version  \
    -b $TOOLKIT/virtual/fs/proc/pagetypeinfo:/proc/pagetypeinfo  \
    -b $TOOLKIT/virtual/fs/proc/modules:/proc/modules  \
    -b $TOOLKIT/virtual/fs/proc/filesystems:/proc/filesystems  \
    -b $TOOLKIT/virtual/fs/proc/misc:/proc/misc  \
    -b $TOOLKIT/virtual/fs/proc/interrupts:/proc/interrupts  \
    -b $TOOLKIT/virtual/fs/proc/softirqs:/proc/softirqs  \
    -b $TOOLKIT/virtual/fs/proc/iomem:/proc/iomem  \
    -b $TOOLKIT/virtual/fs/proc/ioports:/proc/ioports"
    else
    echo "">/dev/null
fi
}