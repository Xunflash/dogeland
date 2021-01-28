#
# dogeland CLI
# v2.2.6
# 
# license: GPL-v3.0
#
VERSION=2.2.6_DEBUG
if [ -d "/dogeland/" ];then
  TOOLKIT=/dogeland/
  else
  echo "">/dev/null
fi
if [ ! -n "$START_DIR" ]; then
TOOLKIT=./
else
  echo "">/dev/null
fi
. $TOOLKIT/include/filetran.sh
. $TOOLKIT/include/others.sh
. $TOOLKIT/include/stop_rootfs.sh
. $TOOLKIT/include/del_rootfs.sh
. $TOOLKIT/include/platform.sh
. $TOOLKIT/include/mount_part.sh
. $TOOLKIT/include/umount_part.sh
. $TOOLKIT/include/set_env.sh
. $TOOLKIT/include/check_rootfs.sh
. $TOOLKIT/include/del_rootfs.sh
. $TOOLKIT/include/backup_rootfs.sh
. $TOOLKIT/include/deploy_linux.sh
. $TOOLKIT/include/starter_chroot.sh
. $TOOLKIT/include/starter_proot.sh
. $TOOLKIT/include/starter_unshare.sh
. $TOOLKIT/include/starter_auto.sh
. $TOOLKIT/include/exec_chroot.sh
. $TOOLKIT/include/exec_proot.sh
. $TOOLKIT/include/exec_unshare.sh
. $TOOLKIT/include/exec_auto.sh
. $TOOLKIT/include/exec_local-shell.sh
. $TOOLKIT/include/extra_dropbear.sh
. $TOOLKIT/include/extra_sshd.sh
. $TOOLKIT/include/extra_vncserver.sh
. $TOOLKIT/include/extra_patcher.sh
if [ ! -n "${1}" ]; then
  version
fi
umask 000
${1}