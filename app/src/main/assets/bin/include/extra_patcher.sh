# dogeland cli module
#
# license: gpl-v3
shmem_patch(){
check_rootfs
cp $PREFIX/lib/libandroid-shmem.so $rootfs/usr/local/lib/
}


xstartup_add(){
check_rootfs
 sed "$a\$desktop &" $rootfs/root/.vnc/xstartup
}

debiangroup_add(){
check_rootfs
sed -i "$ a\aid_$(id -un):x:$bug:" $rootfs/etc/group
}

sh_patcher(){
check_rootfs
rm -rf $rootfs/bin/sh
ln -s $rootfs/bin/bash $rootfs/bin/sh
}
enable_proot_seccomp(){
sed -i '29i\PROOT_NO_SECCOMP=1' $START_DIR/exec_start.sh
}
fix_sudo(){
rm -rf $rootfs/bin/sudo $rootfs/sbin/sudo $rootfs/usr/bin/sudo $rootfs/usr/sbin/sudo
echo "su -c $@">$rootfs/bin/sudo
chmod 0777 $rootfs/bin/sudo
}