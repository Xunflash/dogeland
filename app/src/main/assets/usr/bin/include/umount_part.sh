# dogeland cli module
#
# license: gpl-v3
umount_part(){
# Check NoRoot ,then ignore.
if [ `id -u` -eq 0 ];then
umount $rootfs/proc
umount $rootfs/sys
umount $rootfs/dev/pts
umount $rootfs/dev/shm
umount $rootfs/dev
else
 echo "!Running in NonRoot mode , ignoring."
fi
}