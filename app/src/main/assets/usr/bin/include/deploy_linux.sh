# dogeland cli module
#
# license: gpl-v3
deploy_linux(){
deploy_linux_step1
echo "- Installing Rootfs"
rm -rf $rootfs2
mkdir -p $rootfs2/
# Enbale Link2SymLink for NonRoot
if [ `id -u` -eq 0 ];then
    tar="$TOOLKIT/busybox tar -xzvf $file -C $rootfs2"
else
    tar="$TOOLKIT/proot --link2symlink -0 $TOOLKIT/busybox tar --no-same-owner -xzvf $file -C $rootfs2"
fi
$tar >/dev/null
deploy_linux_step2
}

deploy_linux1(){
deploy_linux_step1
echo "- Installing Rootfs"
rm -rf $rootfs2
mkdir -p $rootfs2/
# Enbale Link2SymLink for NonRoot
if [ `id -u` -eq 0 ];then
    tar="$TOOLKIT/busybox tar -xJf $file -C $rootfs2"
else
    tar="$TOOLKIT/proot --link2symlink -0 $TOOLKIT/busybox tar --no-same-owner -xJf $file -C $rootfs2"
fi
$tar >/dev/null
deploy_linux_step2
}


deploy_from_lxcimage(){
if [[ "$datas" != "1" ]]
then
echo "">/dev/null
else
export rootfs2="$START_DIR/$rootfs2/"
fi
echo "- Downloading LXC Image"
rm -rf $rootfs2
mkdir -p $rootfs2/
$TOOLKIT/wget $image_url -O $TMPDIR/image_tmp.tar.xz

if [ -e "$TMPDIR/image_tmp.tar.xz" ];then
echo "">/dev/null
else
echo "! Download Failed"
exit 1
fi
echo "- Installing LXC Image"
# Enbale Link2SymLink for NonRoot
if [ `id -u` -eq 0 ];then
    tar="$TOOLKIT/busybox tar -xJf $TMPDIR/image_tmp.tar.xz -C $rootfs2"
else
    tar="$TOOLKIT/proot --link2symlink -0 $TOOLKIT/busybox tar --no-same-owner -xJf $TMPDIR/image_tmp.tar.xz -C $rootfs2"
fi
$tar >/dev/null
echo "- Cleaning LXC Image Cache"
rm $TMPDIR/image_tmp.tar.xz
# Modded for dogeland
mkdir -p $rootfs2/dogeland/
touch $rootfs2/dogeland/cmd.conf
touch $rootfs2/dogeland/patch.sh
# Repair NetworkResolv
echo "nameserver 8.8.8.8">$rootfs2/etc/resolv.conf
echo "- Installing dropbear"
    # for pacman
    if [ ! -n "$rootfs2/usr/bin/pacman" ]; then
    rm -rf $rootfs2/*
    echo "!This release is not currently supported"
    exit 2
    else
    cmd2="pacman -S --confirm dropbear sudo tzdata"
    exec_auto && unset cmd2
    rm -rf $rootfs2/etc/dropbear/*
    fi
    # for Apt
    if [ ! -n "$rootfs2/usr/bin/apt" ]; then
    rm -rf $rootfs2/*
    echo "!This release is not currently supported"
    exit 2
    else
    cmd2="apt install dropbear sudo tzdata -y"
    exec_auto && unset cmd2
    rm -rf $rootfs2/etc/dropbear/*
    fi
    # for Alpine
    if [ ! -n "$rootfs2/usr/bin/apk" ]; then
    rm -rf $rootfs2/*
    echo "!This release is not currently supported"
    exit 2
    else
    cmd2="apk add dropbear sudo tzdata"
    exec_auto && unset cmd2
    rm -rf $rootfs2/etc/dropbear/*
    fi
deploy_linux_step2
}

# Post Installed Before
deploy_linux_step1(){
if [ ! -n "$rootfs2" ]; then
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
export rootfs2="$START_DIR/$rootfs2/"
fi
}

# Post Installed Later
deploy_linux_step2(){
if [ -d "$rootfs2/bin/" ];then
  echo "">/dev/null
  else
  echo "!An exception occurred during the decompression process"
  exit 255
fi
echo "- Performing additional operation"
if [ -d "$rootfs2/dogeland/" ];then
 # Setup from RootfsPackageData
  cat $rootfs2/dogeland/cmd.conf >$CONFIG_DIR/cmd.config
  . $rootfs2/dogeland/patch.sh
  rm -rf  $rootfs2/dogeland/*
  echo "$rootfs2" >$CONFIG_DIR/rootfs.config
  else
  mkdir $rootfs2/dogeland/
  # Use Empty ConfigData
  echo "$type">$CONFIG_DIR/cmd.config
  echo "$rootfs2" >$CONFIG_DIR/rootfs.config
fi

# make empty status 
echo "Stop">$rootfs2/dogeland/status
mkdir $rootfs2/sys $rootfs2/dev $rootfs2/dev/pts $rootfs2/proc
chmod 770 $rootfs2/proc
mkdir -p $rootfs2/dev/net

# Install dogeland addon
cp $TOOLKIT/cli.sh $rootfs2/dogeland/
mkdir $rootfs2/dogeland/include/
mkdir $rootfs2/dogeland/filetran_r/
mkdir $rootfs2/dogeland/.filetran_s/
cp -R $TOOLKIT/include/* $rootfs2/dogeland/include/
# Run Other Setup
. $TOOLKIT/include/extra_linuxconfigure.sh configure
echo "! All Done"
}