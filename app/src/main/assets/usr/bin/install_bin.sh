#
# dogeland AppEnv Init
#

if [ ! $TOOLKIT ];then
    echo "!致命失败"
    exit 2
else
    echo  "">/dev/null
fi
if [[ "$platform" != "unknown" ]]
then
echo "">/dev/null
else
if [ ! -f "$DATA2_DIR/bin/busybox" ]; then
 echo "! $platform ,你的设备缺少命令或者不受支持"
 exit 5
 else
 echo "检测到预加载busybox"
 cp $DATA2_DIR/bin/busybox $TMPDIR/busybox
 chmod 0770 $TMPDIR/busybox
 unset platform
 export platform=$(sh $TOOLKIT/cli.sh platform)
fi
fi
$PREFIX/preload/bin/busybox_$platform chmod -R 0777 $PREFIX
function busybox_install() {
    for applet in `./busybox --list`; do
        case "$applet" in
        "swapon"|"swapoff"|"mkswap"|"unshare")
            echo 'Skip' > /dev/null
        ;;
        *)
            ./busybox ln -sf busybox "$applet";
        ;;
        esac
    done
}
$PREFIX/preload/bin/busybox_$platform cp $PREFIX/preload/bin/busybox_$platform $TOOLKIT/busybox
chmod 0770 $TOOLKIT/busybox
cd "$TOOLKIT"
busybox_install
export PATH=$PATH:$TOOLKIT
mkdir $PREFIX/lib
mkdir $PREFIX/libexec
cp $PREFIX/preload/lib/$platform/* $PREFIX/lib/
cp $PREFIX/preload/libexec/$platform/* $PREFIX/libexec/
cp $PREFIX/preload/bin/proot_$platform $TOOLKIT/proot
cp $PREFIX/preload/bin/unshare_$platform $TOOLKIT/unshare
if [ -d "$DATA2_DIR" ];then
  echo "">/dev/null
  else
  mkdir -p $DATA2_DIR
  if [ -d "$DATA2_DIR" ];then
  mkdir $CONFIG_DIR
  touch >$CONFIG_DIR/rootfs.conf
  touch >$CONFIG_DIR/cmd.conf
  mkdir $DATA2_DIR/filetran
  else
  echo "!数据初始化失败"
  echo "----------"
  echo "在重新打开应用程序之前，请在[内部存储/ Android / data /]文件夹中创建一个名为me.flytree.dogeland的新文件夹"
  exit 3
  fi
fi
touch $TOOLKIT/install_bin_done
rm -rf $PREFIX/preload
chmod -R 0770 $PREFIX
mv $TOOLKIT/install_bin.sh $TMPDIR/install_bin.shbak