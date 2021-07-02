#
# dogeland AppEnv Init
#

if [ ! $TOOLKIT ];then
    exit 2
else
    echo  "">/dev/null
fi
$TOOLKIT/preload_res/bin/busybox_$platform chmod -R 0777 $TOOLKIT
function busybox_install() {
    for applet in `./busybox --list`; do
        case "$applet" in
        "swapon"|"swapoff"|"mkswap")
            echo 'Skip' > /dev/null
        ;;
        *)
            ./busybox ln -sf busybox "$applet";
        ;;
        esac
    done
}
$TOOLKIT/preload_res/bin/busybox_$platform cp $TOOLKIT/preload_res/bin/busybox_$platform $TOOLKIT/bin/busybox
chmod 0770 $TOOLKIT/bin/busybox
cd "$TOOLKIT/bin"
busybox_install
mkdir $TOOLKIT/lib
mkdir $TOOLKIT/tmp
mkdir $TOOLKIT/libexec
cp $TOOLKIT/preload_res/lib/$platform/* $TOOLKIT/lib/
cp $TOOLKIT/preload_res/libexec/$platform/* $TOOLKIT/libexec/
cp $TOOLKIT/preload_res/bin/proot_$platform $TOOLKIT/bin/proot
mkdir -p $APP_FILES_DIR
if [ -d "$APP_FILES_DIR" ];then
  mkdir $CONFIG_DIR
  touch $CONFIG_DIR/rootfs.config
  touch $CONFIG_DIR/cmdline.config
  touch $CONFIG_DIR/patch_proot-seccomp.config
  touch $APP_FILES_DIR/filetran
 else
  echo "!Data initialization failed"
  echo "----------"
  echo "Before reopening the application, please create a new folder named me.flytree.dogeland in the [internal storage/Android/data/] folder."
  exit 3
fi
touch $TOOLKIT/install_bin_done
rm -rf $TOOLKIT/preload_res
chmod -R 0770 $TOOLKIT
rm $TOOLKIT/bin/install_bin.sh