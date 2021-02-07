# dogeland cli module
#
# license: gpl-v3
check_rootfs(){
if [ -d "$rootfs" ];then
  echo "">/dev/null
  else
  echo "- / ...fail "
  exit 3
fi
}
check_rootfs_status(){
if [[ "$(cat $rootfs/dogeland/status)" != "Run" ]]
then
echo "">/dev/null
else
# if Run,then tip to stop
echo "!The container is running, the current operation cannot be performed, please stop the container first"
exit 6
fi
}