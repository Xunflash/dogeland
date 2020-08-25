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
cmd2=chown 0 /etc/sudoers
exec_auto && unset cmd2
cmd2=chown -R 0 /etc/sudoers.d
exec_auto && unset cmd2
cmd2=chown -R 0 /usr/lib/sudo/
exec_auto && unset cmd2
}