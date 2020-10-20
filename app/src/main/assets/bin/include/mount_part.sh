# dogeland cli module
#
# license: gpl-v3
mount_part(){
if [ -e "$rootfs/proc/self/" ];then
 echo "">/dev/null
  else
 echo "- /proc ..."
   mount -t proc proc $rootfs/proc
fi

if [ -d "$rootfs/sys/kernel/" ];then
 echo "">/dev/null
  else
 echo "- /sys ..."
  mount -t sysfs sysfs $rootfs/sys
fi

if [ -d "$rootfs/dev/tty/" ];then
  echo "">/dev/null
  else
  echo "- /dev ..."
  mount -o bind /dev/ $rootfs/dev
fi

if [ -e "$rootfs/dev/pts/0" ];then
  echo "">/dev/null
  else
  echo "- /dev/pts ..."
  mount -t devpts devpts $rootfs/dev/pts
fi

if [ -d "/dev/shm" ];then
 echo "">/dev/null
  else
 echo "- /dev/shm ..."
  mkdir -p /dev/shm
fi

if [ ! -e "/dev/tty0" ]; then
  echo "">/dev/null
  else
  echo "- /dev/tty ... "
  ln -s /dev/null /dev/tty0
fi
if [ ! -e "/dev/fd" -o ! -e "/dev/stdin" -o ! -e "/dev/stdout" -o ! -e "/dev/stderr" ]; then
    echo "/dev/fd ... "
    [ -e "/dev/stdin" ] || ln -s /proc/self/fd/0 /dev/stdin
    [ -e "/dev/stdout" ] || ln -s /proc/self/fd/1 /dev/stdout
    [ -e "/dev/stderr" ] || ln -s /proc/self/fd/2 /dev/stderr
fi
        
if [ -d "$rootfs/mnt/host-rootfs/" ];then
  echo "">/dev/null
  else
  echo "- /mnt/host-rootfs ..."
  ln -s /proc/self/cwd $rootfs/mnt/host-rootfs
fi
}

