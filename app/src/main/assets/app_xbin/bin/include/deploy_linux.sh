# dogeland cli module
#
# license: gpl-v3
deploy_linux_tgz(){
deploy_linux_step1
echo "- Installing Rootfs"
rm -rf $cache_rootfs
mkdir -p $cache_rootfs/
# Enbale Link2SymLink for No Root
if [ `id -u` -eq 0 ];then
    tar="$TOOLKIT/bin/busybox tar -xzvf $file -C $cache_rootfs"
else
    tar="$TOOLKIT/bin/proot --link2symlink -0 $TOOLKIT/bin/busybox tar --no-same-owner -xzvf $file -C $cache_rootfs"
fi
$tar >/dev/null
deploy_linux_step2
}

deploy_linux_txz(){
deploy_linux_step1
echo "- Installing Rootfs"
rm -rf $cache_rootfs
mkdir -p $cache_rootfs/
# Enbale Link2SymLink for No Root
if [ `id -u` -eq 0 ];then
    tar="$TOOLKIT/bin/busybox tar -xJf $file -C $cache_rootfs"
else
    tar="$TOOLKIT/bin/proot --link2symlink -0 $TOOLKIT/bin/busybox tar --no-same-owner -xJf $file -C $cache_rootfs"
fi
$tar >/dev/null
deploy_linux_step2
}

# Check Configs
deploy_linux_step1(){
export PROOT_TMP_DIR="$TMPDIR"
export PROOT_LOADER="$TOOLKIT/libexec/libloader.so"
if [[ "$platform" != "x86_64" ]] && [[ "$platform" != "arm64" ]]
then
echo "">/dev/null
else
export PROOT_LOADER_32="$TOOLKIT/libexec/libloader32.so"
fi
echo "progress:[1/10]"
if [ ! -n "$cache_rootfs" ]; then
    echo "!The selected path is not available"
    exit 1
    else
    echo "">/dev/null
fi
if [ ! -n "$file" ]; then
    if [ ! -n "$file2" ]; then
    echo "!The selected source file is not available"
    exit 2
    else
    echo "">/dev/null
    fi
    else
    echo "">/dev/null
fi
if [[ "$datas" != "1" ]]
then
echo "">/dev/null
else
export cache_rootfs="$START_DIR/$cache_rootfs/"
fi
echo "progress:[3/10]"
}

deploy_linux_step2(){
echo "progress:[5/10]"
if [ -d "$cache_rootfs/bin/" ];then
  echo "">/dev/null
  else
  echo "!An exception occurred during the decompression process"
  exit 255
fi
echo "progress:[6/10]"
echo "- Performing additional operation"

if [ -d "$cache_rootfs/pkg_configs/" ];then
 # Get Default PkgConfigs
  cp $cache_rootfs/pkg_configs/cmdline.conf $CONFIG_DIR/cmdline.config
  echo "$cache_rootfs" >$CONFIG_DIR/rootfs.config
  rm -rf $cache_rootfs/pkg_configs
  else
  mkdir -p $cache_rootfs/boot/dogeland/
  echo "$cache_rootfs" >$CONFIG_DIR/rootfs.config
fi

mkdir -p $cache_rootfs/sys $cache_rootfs/dev $cache_rootfs/dev/pts $cache_rootfs/proc $cache_rootfs/boot/dogeland
echo "Stop">$cache_rootfs/boot/dogeland/status
chmod 770 $cache_rootfs/proc
mkdir -p $cache_rootfs/dev/net
# Install dogeland addon
mkdir -p $cache_rootfs/boot/dogeland/include/
cp $TOOLKIT/bin/cli.sh $cache_rootfs/boot/dogeland/
cp -R $TOOLKIT/bin/include/* $cache_rootfs/boot/dogeland/include/
# Run Other Setup
. $TOOLKIT/bin/include/extra_linuxconfigure.sh configure
echo "! All Done"
}