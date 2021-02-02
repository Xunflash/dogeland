# dogeland cli module
#
# license: gpl-v3
start_auto(){
if [ "$(id -u)" = "0" ]; then
	start_chroot
	else
	start_proot
fi
}
