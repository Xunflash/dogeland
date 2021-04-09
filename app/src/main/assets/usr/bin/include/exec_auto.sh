# dogeland cli module
#
# license: gpl-v3
exec_auto(){
check_rootfs 
if [ "$(id -u)" = "0" ]; then
	exec_unshare
	else
	exec_proot
fi
}