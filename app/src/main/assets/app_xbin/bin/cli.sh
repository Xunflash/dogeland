#
# dogeland CLI
# v3.0.1
# 
# license: GPL-v3.0
#
VERSION=3.0.1_DEBUG
CLI_RES=$TOOLKIT/bin/include
# Container Mode
if [ -d "/boot/dogeland/" ];then
  CLI_RES=/boot/dogeland/
  else
  echo "">/dev/null
fi
# Test Mode
#if [ ! -n "$START_DIR" ]; then
#  CLI_RES=./include
# else
#  echo "">/dev/null
#fi
. $CLI_RES/others.sh
. $CLI_RES/stop_rootfs.sh
. $CLI_RES/del_rootfs.sh
. $CLI_RES/platform.sh
. $CLI_RES/set_env.sh
. $CLI_RES/check_rootfs.sh
. $CLI_RES/del_rootfs.sh
. $CLI_RES/backup_rootfs.sh
. $CLI_RES/deploy_linux.sh
. $CLI_RES/bind_main.sh
. $CLI_RES/starter_proot.sh
. $CLI_RES/starter_unshare.sh
. $CLI_RES/starter_auto.sh
. $CLI_RES/exec_unshare.sh
. $CLI_RES/exec_auto.sh
. $CLI_RES/exec_local-shell.sh
. $CLI_RES/extra_dropbear.sh
. $CLI_RES/extra_sshd.sh
. $CLI_RES/extra_patcher.sh
. $CLI_RES/exec_proot.sh
if [ ! -n "${1}" ]; then
  echo "success!"
fi
umask 000
${1}