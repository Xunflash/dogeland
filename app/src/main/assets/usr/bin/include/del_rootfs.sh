# dogeland cli module
#
# license: gpl-v3
del_rootfs() {
if [ -d "$rootfs/usr/" ];then
  check_rootfs_status
  echo "- 正在移除"
  rm -rf $rootfs/*
  echo "- 完成"
  else
  echo "- 失败"
fi
}
