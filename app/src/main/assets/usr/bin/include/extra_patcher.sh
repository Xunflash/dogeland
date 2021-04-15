# dogeland cli module
#
# license: gpl-v3
shmem_patch(){
check_rootfs
cp $PREFIX/lib/libandroid-shmem.so $rootfs/usr/local/lib/
chmod 0770 $rootfs/usr/local/lib/libandroid-shmem.so
}
debiangroup_add(){
check_rootfs
sed -i "$ a\aid_$(id -un):x:$bug:" $rootfs/etc/group
}
disable_proot_seccomp(){
sed -i '14i\PROOT_NO_SECCOMP=1' $START_DIR/shell_init.sh
}
fix_sudo(){
check_rootfs
cmd2="chown 0 /etc/sudoers"
exec_auto && unset cmd2
cmd2="chown -R 0 /etc/sudoers.d"
exec_auto && unset cmd2
cmd2="chown -R 0 /usr/lib/sudo/"
exec_auto && unset cmd2
}