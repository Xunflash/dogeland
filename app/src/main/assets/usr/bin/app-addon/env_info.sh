#
    android_version=$(getprop ro.build.version.release)
    if [ -n "$android_version" ]; then
        echo -n "Android: "
        echo " $android_version"
    fi

    echo -n "Container installed system:"
    if [ -f "$rootfs/etc/issue" ];then
    export linux_version=$(cat $rootfs/etc/issue)
    else
    export linux_version="  Not installed or not recognized"
    fi
    echo "$linux_version"

    echo -n "Architecture: "
    echo "$(uname -m)"

    echo -n "Kernel: "
    echo "$(uname -r)"

    echo -n "RAM: "
    mem_status=$(sed -n '1,p' /proc/meminfo)
    echo "$mem_status"

    echo -n "SELinux: "
    selinux_inactive(){
    if [ -e "/sys/fs/selinux/enforce" ]; then
        return $(cat /sys/fs/selinux/enforce)
    else
        return 0
    fi
    }
    selinux_inactive && echo "Disable" || echo "Enable"

    echo "File system support:"
    supported_fs=$(cat /proc/filesystems)
    echo "$supported_fs"
    
    echo 'busybox:'
    $TOOLKIT/busybox | grep BusyBox
    
    echo "Running path:"
    pwd