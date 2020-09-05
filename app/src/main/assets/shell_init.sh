#
# dogeland-shell
#
run="$1"
#
# BasicEnv
#
export START_DIR=$({START_DIR})
export SDCARD_PATH=$({SDCARD_PATH})
export PACKAGE_NAME=$({PACKAGE_NAME})
export TOOLKIT=$START_DIR/bin
export TMPDIR=$START_DIR/cache
#
# RunEnv
#
export PREFIX=$START_DIR
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/lib/"
export PATH="$PATH:$TOOLKIT:$PREFIX/lib"
#
# DATA
#
export DATA2_DIR="$SDCARD_PATH/Android/data/$PACKAGE_NAME/"
export CONFIG_DIR="$DATA2_DIR/config/"
export platform=$(sh $TOOLKIT/cli.sh platform)
#
# PRoot
#
export PROOT_TMP_DIR="$TMPDIR"
export PROOT_LOADER="$PREFIX/lib/lib_loader.so"
# Enable PRoot 64-bit compatible 32-bit support
if [[ "$platform" != "x86_64" ]] && [[ "$platform" != "arm64" ]]
then
echo "">/dev/null
else
export PROOT_LOADER_32="$PREFIX/lib/lib_loader32.so"
fi
#
# LoadConfig
#
export cmd=$(cat $CONFIG_DIR/cmd.conf)
export rootfs=$(cat $CONFIG_DIR/rootfs.conf)
export PATH2=$(cat $CONFIG_DIR/path.conf)
#
# Other or RunCmd
#
if [[ -f "$TOOLKIT/install_bin.sh" ]]; then
  sh $TOOLKIT/install_bin.sh
fi
if [[ -f "$run" ]]; then
    cd $START_DIR
    #chmod 755 "$run"
    sh "$run"
else
    echo "command not found!"
fi