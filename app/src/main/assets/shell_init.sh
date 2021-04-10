#
# dogeland shell init
#
export START_DIR=$({START_DIR})
export SDCARD_PATH=$({SDCARD_PATH})
export PACKAGE_NAME=$({PACKAGE_NAME})
export TMPDIR="$START_DIR/cache"
export PREFIX="$START_DIR/usr"
export TOOLKIT="$PREFIX/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/lib"
export PATH="/system/bin:/sbin:$TOOLKIT"
export DATA2_DIR="$SDCARD_PATH/Android/data/$PACKAGE_NAME/files"
export CONFIG_DIR="$DATA2_DIR/config"

export PROOT_TMP_DIR="$TMPDIR"
export PROOT_LOADER="$PREFIX/libexec/libloader.so"
if [[ "$platform" != "x86_64" ]] && [[ "$platform" != "arm64" ]]
then
echo "">/dev/null
else
export PROOT_LOADER_32="$PREFIX/libexec/libloader32.so"
fi
export platform=$(sh $TOOLKIT/cli.sh platform)
export cmd=$(cat $CONFIG_DIR/cmdline.config)
export rootfs=$(cat $CONFIG_DIR/rootfs.config)
if [[ -f "$TOOLKIT/install_bin_done" ]]; then
  echo "">/dev/null
  else
  sh $TOOLKIT/install_bin.sh
fi
if [[ -f "$1" ]]; then
    cd $PREFIX
    . "$1"
else
    echo "No Command"
    exit
fi