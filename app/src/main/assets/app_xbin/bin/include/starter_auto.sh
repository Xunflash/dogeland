start_auto(){
if [ "$(id -u)" = "0" ]; then
	start_unshare
	else
	start_proot
fi
}
