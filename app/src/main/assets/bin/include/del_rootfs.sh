# dogeland cli module
#
# license: gpl-v3
del_rootfs() {
if [ -d "$rootfs/usr/" ];then
  check_rootfs_status
  echo "- 正在移除容器"
  rm -rf $rootfs/*
  echo "- 已完成"
  else
  echo "- 移除失败"
fi
}
