#
# DogeLand Core Files Installer
#
quit(){
echo "">/dev/null
exit
}
if [ ! $TOOLKIT ];then
    echo "!Environment error"
    exit 9
else
    echo  "">/dev/null
fi

if [ -f "$TOOLKIT/install_bin_done" ];then
quit
else


if [[ "$platform" != "unknown" ]]
then
echo "">/dev/null
else
echo "! $platform ,Your device may not be supported or system commands are missing"
exit 5
fi

busybox_$platform chmod -R 0777 $TOOLKIT/
# libs
if [ -d "$PREFIX/lib/" ];then
  echo "">/dev/null
  else
  busybox_$platform ln -s $TOOLKIT/libs/$platform $PREFIX/lib
fi

# Busybox
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
if [[ ! "$TOOLKIT" = "" ]]; then
    cd "$TOOLKIT"
    if [[ ! -f arch ]]; then
    export platform=$(sh $TOOLKIT/cli.sh platform)
    busybox_$platform rm -rf $TOOLKIT/busybox
    busybox_$platform mv $TOOLKIT/busybox_$platform $TOOLKIT/busybox
    busybox_install
    rm -rf $TOOLKIT/busybox_*
    fi
fi
# Proot
if [[ ! -f $TOOLKIT/proot ]]; then
ln -s $PREFIX/lib/lib_proot.so $TOOLKIT/proot
fi
# Unshare
if [[ ! -f $TOOLKIT/unshare ]]; then
ln -s  $PREFIX/lib/lib_unshare.so $TOOLKIT/unshare
fi

# DATA2_DIR
if [ -d "$DATA2_DIR" ];then
  echo "">/dev/null
  else
  mkdir -p $DATA2_DIR
  if [ -d "$DATA2_DIR" ];then
  echo "">/dev/null
  else
  echo "!Data initialization failed"
  echo "----------"
  echo "Please create a new folder named me.flytree.dogeland in the [internal storage/Android/data/] folder before reopening the application."
  exit 2
  fi
fi

# configure init
if [ -d "$CONFIG_DIR/" ];then
  echo "">/dev/null
  else
  mkdir $CONFIG_DIR
  echo "" >$CONFIG_DIR/rootfs.conf
  echo "" >$CONFIG_DIR/cmd.conf
  echo "" >$CONFIG_DIR/path.conf
fi

# Kill
echo -n "!done🍉"
echo "" >$TOOLKIT/install_bin_done
mv $TOOLKIT/install_bin.sh $TMPDIR/install_bin.shbak
fi