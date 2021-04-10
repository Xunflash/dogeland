#
# dogeland AppEnv Init
#

if [ ! $TOOLKIT ];then
    echo "!Fatal failure"
    exit 2
else
    echo  "">/dev/null
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
mkdir $PREFIX/tmp
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
  touch $CONFIG_DIR/rootfs.config
  touch $CONFIG_DIR/cmdline.config
  touch $CONFIG_DIR/patch_proot-secomp.config
  touch $DATA2_DIR/filetran
  else
  echo "!Data initialization failed"
  echo "----------"
  echo "Before reopening the application, please create a new folder named me.flytree.dogeland in the [internal storage/Android/data/] folder."
  exit 3
  fi
fi
touch $TOOLKIT/install_bin_done
rm -rf $PREFIX/preload
chmod -R 0770 $PREFIX
sed -i ‘26d’ $START_DIR/shell_init.sh
sed -i ‘27d’ $START_DIR/shell_init.sh
sed -i ‘28d’ $START_DIR/shell_init.sh
sed -i ‘29d’ $START_DIR/shell_init.sh
sed -i ‘30d’ $START_DIR/shell_init.sh
mv $TOOLKIT/install_bin.sh $TMPDIR/install_bin.shbak