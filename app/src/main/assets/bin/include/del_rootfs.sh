# dogeland cli module
#
# license: gpl-v3
del_rootfs() {
if [ -d "$rootfs/usr/" ];then
  check_rootfs_status
  echo "- Removing the rootfs"
  rm -rf $rootfs/*
  echo "- done"
  else
  echo "- faild"
fi
}
