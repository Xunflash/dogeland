# dogeland cli module
#
# license: gpl-v3
deploy_linux(){
deploy_linux_step1
#
# Install
#
echo "- 正在安装 $file"
rm -rf $rootfs2
mkdir -p $rootfs2/
# for tgz
if [ `id -u` -eq 0 ];then
    $TOOLKIT/busybox tar -xzvf $file -C $rootfs2 >/dev/null
else
    proot --link2symlink $TOOLKIT/busybox tar -xzvf $file -C $rootfs2 >/dev/null
fi
deploy_linux_step2
}

deploy_linux1(){
deploy_linux_step1
#
# Install
#
echo "- 正在安装 $file"
rm -rf $rootfs2
mkdir -p $rootfs2/
# for tar.xz
if [ `id -u` -eq 0 ];then
    $TOOLKIT/busybox tar -xJf $file -C $rootfs2
else
    proot --link2symlink $TOOLKIT/busybox tar -xJf $file -C $rootfs2 >/dev/null
fi
deploy_linux_step2
}



deploy_linux_step1(){
echo "- 正在检查"
if [ ! -n "$rootfs2" ]; then
    echo "- Failed 1"
    exit 1
    sleep 1000
    else
    echo "">/dev/null
fi
if [ ! -n "$file" ]; then
    if [ ! -n "$file2" ]; then
    echo "- Failed 2"
    exit 2
    sleep 1000
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
export rootfs2="$START_DIR/$rootfs2/"
fi
}

deploy_linux_step2(){
# Check 
if [ -d "$rootfs2/bin/" ];then
  echo "">/dev/null
  else
  echo "!解压时出现异常"
  exit 255
  sleep 9999
fi
#
# Settings
#
echo "- 正在设置"
# Set CONFIG
if [ -d "$rootfs2/dogeland/" ];then
  echo "">/dev/null
  else
  mkdir $rootfs2/dogeland/
fi
echo "Stop">$rootfs2/dogeland/status
rm -rf $CONFIG_DIR/cmd.conf
echo "$type">$CONFIG_DIR/cmd.conf
rm -rf $CONFIG_DIR/rootfs.conf
echo "$rootfs2" >$CONFIG_DIR/rootfs.conf
# mkdir
mkdir $rootfs2/sys $rootfs2/dev $rootfs2/dev/pts $rootfs2/proc
chmod 770 $rootfs2/proc
mkdir -p $rootfs2/dev/net
# custom for linux

# dropbear key
rm -rf $rootfs2/etc/dropbear
mkdir $rootfs2/etc/dropbear
chmod -R 0777 $rootfs2/etc/dropbear/

# the end

# Install CLI
cp $TOOLKIT/cli.sh $rootfs2/dogeland/
mkdir $rootfs2/dogeland/include/
cp -R $TOOLKIT/include/* $rootfs2/dogeland/include/
# CatRootfsInfo
echo "- 正在解析"
if [ -f "$rootfs2/info.log" ];then
cat $rootfs2/info.log
rm -rf $rootfs2/info.log
else
echo "">/dev/null
fi
. $TOOLKIT/include/extra_linuxconfigure.sh configure
echo "- 完成"
}