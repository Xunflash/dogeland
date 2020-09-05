# dogeland cli module
#
# license: gpl-v3
version()
{
cat <<ABOUT

dogeland CLI $VERSION 

license: GPL-v3.0

ABOUT
}

enable_proot_fakekernel(){
if [ -e "$CONFIG_DIR/fake_kernel" ];then
rm $CONFIG_DIR/fake_kernel
rm $rootfs/proc/.version
else
echo "$kernel" > $CONFIG_DIR/fake_kernel
cat <<- EOF > "$rootfs/proc/.version"
Linux version $kernel (dogeland@fakehost) (gcc version 4.9.x 20150123 (prerelease) (GCC) ) #1 SMP PREEMPT Fri Jul 10 00:00:00 UTC 2020
EOF
fi
}

edit_passwd(){
export cmd2=chpasswd
echo "$username:$password"|exec_auto
unset cmd2
}
