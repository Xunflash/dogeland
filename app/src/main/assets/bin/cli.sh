#
# dogeland CLI
# v2.2.5
# 
# license: GPL-v3.0
#
VERSION=2.2.5_DEBUG

#
# Setup Running Env
#

if [ -d "/dogeland/" ];then
  TOOLKIT=/dogeland/
  else
  echo "">/dev/null
fi
# 
if [ ! -n "$START_DIR" ]; then
#  Set for Terminal
TOOLKIT=./
export START_DIR=./
export PREFIX=$PREFIX:./
export TOOLKIT=./
export DATA2_DIR="./data/"
export CONFIG_DIR="$DATA2_DIR/config/"
else
  echo "">/dev/null
fi

#
# LoadModule
#

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
#
# Starter
#
. $TOOLKIT/include/starter_chroot.sh
. $TOOLKIT/include/starter_proot.sh
. $TOOLKIT/include/starter_auto.sh
#
# Exec
#
. $TOOLKIT/include/exec_chroot.sh
. $TOOLKIT/include/exec_proot.sh
. $TOOLKIT/include/exec_auto.sh
. $TOOLKIT/include/exec_local-shell.sh
#
# extensions
#
. $TOOLKIT/include/extra_dropbear.sh
. $TOOLKIT/include/extra_sshd.sh
. $TOOLKIT/include/extra_vncserver.sh
. $TOOLKIT/include/extra_patcher.sh
# RunHelp
if [ ! -n "${1}" ]; then
  version
fi
# Set Permission
umask 000
# RunCmd
${1}