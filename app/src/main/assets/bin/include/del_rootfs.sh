# dogeland cli module
#
# license: gpl-v3
del_rootfs() {
if [ -d "$rootfs/usr/" ];then
  echo "- 正在关闭容器"
  stop_rootfs
  umount_part
  echo "- 正在移除容器"
  rm -rf $rootfs/*
  echo "- 已完成"
  else
  echo "- 移除失败"
fi
}
