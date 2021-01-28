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
echo "!容器正在运行，无法执行当前操作，请先停止容器"
exit 6
fi
}