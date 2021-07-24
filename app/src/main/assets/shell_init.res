export START_DIR=$({START_DIR})
export SDCARD_PATH=$({SDCARD_PATH})
export PACKAGE_NAME=$({PACKAGE_NAME})
export TOOLKIT="$START_DIR/app_xbin"
export APP_FILES_DIR="$SDCARD_PATH/Android/data/$PACKAGE_NAME/files/"
export PATH="/system/bin:/sbin:$TOOLKIT/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$TOOLKIT/lib"
export TMPDIR="$TOOLKIT/tmp"
export CONFIG_DIR="$APP_FILES_DIR/config"
export platform=$(sh $TOOLKIT/bin/toolkit.sh platform_check)
export cmd=$(cat $CONFIG_DIR/cmdline.config)
export rootfs=$(cat $CONFIG_DIR/rootfs.config)
if [[ -f "$TOOLKIT/install_bin_done" ]]; then
  echo "">/dev/null
  else
  sh $TOOLKIT/bin/install_bin.sh
fi
cd $START_DIR
. "$1"