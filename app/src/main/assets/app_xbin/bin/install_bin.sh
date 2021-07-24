#
# dogeland AppEnv Init
#

if [ ! $TOOLKIT ];then
    exit 2
else
    echo  "">/dev/null
fi
$TOOLKIT/preload_res/bin/busybox_$platform chmod -R +x $TOOLKIT
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
# Install Tools
$TOOLKIT/preload_res/bin/busybox_$platform cp $TOOLKIT/preload_res/bin/busybox_$platform $TOOLKIT/bin/busybox
chmod +x $TOOLKIT/bin/busybox
cd "$TOOLKIT/bin"
busybox_install
mkdir $TOOLKIT/lib
mkdir $TOOLKIT/tmp
mkdir $TOOLKIT/libexec
cp $TOOLKIT/preload_res/lib/$platform/* $TOOLKIT/lib/
cp $TOOLKIT/preload_res/libexec/$platform/* $TOOLKIT/libexec/
cp $TOOLKIT/preload_res/bin/proot_$platform $TOOLKIT/bin/proot
# Create Data Dir
mkdir -p $APP_FILES_DIR
if [ -d "$APP_FILES_DIR" ];then
  mkdir $CONFIG_DIR
  touch $CONFIG_DIR/rootfs.config
  touch $CONFIG_DIR/cmdline.config
  touch $CONFIG_DIR/patch_proot-seccomp.config
  touch $APP_FILES_DIR/filetran
 else
  echo "!Data initialization failed"
  echo "Before reopening the application, please create a new folder named me.flytree.dogeland in the [internal storage/Android/data/] folder."
  exit 3
fi
# Unlock Full Toolkit
rm $TOOLKIT/bin/toolkit.sh
mv $TOOLKIT/bin/toolkit.shl $TOOLKIT/bin/toolkit.sh
mv $TOOLKIT/app-addon/extra_linuxconfigure.shl $TOOLKIT/app-addon/extra_linuxconfigure.sh
mv $TOOLKIT/app-addon/plugin_installer.shl $TOOLKIT/app-addon/plugin_installer.sh
mv $TOOLKIT/app-addon/set_all.shl $TOOLKIT/app-addon/set_all.sh
chmod -R a+x $TOOLKIT
# Write Tag
touch $TOOLKIT/install_bin_done
# Clean Up
rm -rf $TOOLKIT/preload_res
rm $TOOLKIT/bin/install_bin.sh