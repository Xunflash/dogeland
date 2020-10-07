# dogeland cli module
#
# license: gpl-v3
deploy_linux(){
deploy_linux_step1
#
# Install
#
echo "- Installing $file"
rm -rf $rootfs2
mkdir -p $rootfs2/
# for tgz
if [ `id -u` -eq 0 ];then
    $TOOLKIT/busybox tar -xzvf $file -C $rootfs2 >/dev/null
else
    $TOOLKIT/proot --link2symlink $TOOLKIT/busybox tar --no-same-owner -xzvf $file -C $rootfs2 >/dev/null
fi
deploy_linux_step2
}

deploy_linux1(){
deploy_linux_step1
#
# Install
#
echo "- Installing $file"
rm -rf $rootfs2
mkdir -p $rootfs2/
# for tar.xz
if [ `id -u` -eq 0 ];then
    $TOOLKIT/busybox tar -xJf $file -C $rootfs2
else
    proot --link2symlink $TOOLKIT/busybox tar --no-same-owner -xJf $file -C $rootfs2 >/dev/null
fi
deploy_linux_step2
}



deploy_linux_step1(){
if [ ! -n "$rootfs2" ]; then
    echo "!The selected directory is not available"
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

deploy_linux_step2(){
# Check 
if [ -d "$rootfs2/bin/" ];then
  echo "">/dev/null
  else
  echo "!An exception occurred during decompression"
  exit 255
fi
#
# Settings
#
echo "- Performing additional operation"
# Setting up configure
if [ -d "$rootfs2/dogeland/" ];then
  echo "">/dev/null
  else
  mkdir $rootfs2/dogeland/
fi
# Initial config
echo "Stop">$rootfs2/dogeland/status
rm -rf $CONFIG_DIR/cmd.conf
echo "$type">$CONFIG_DIR/cmd.conf
rm -rf $CONFIG_DIR/rootfs.conf
echo "$rootfs2" >$CONFIG_DIR/rootfs.conf
# Create Basic Folder
mkdir $rootfs2/sys $rootfs2/dev $rootfs2/dev/pts $rootfs2/proc
chmod 770 $rootfs2/proc
mkdir -p $rootfs2/dev/net

# FakeProcStat for proot
cat <<- EOF > "$rootfs2/proc/.stat"
cpu  1396710 169620 589073 5054777 28480 82 13508 0 0 0
cpu0 20602 4330 7296 40147 983 0 131 0 0 0
cpu1 15348 4581 6880 37687 554 0 101 0 0 0
cpu2 17764 4617 7116 44316 729 0 97 0 0 0
cpu3 16620 4736 6976 39593 449 0 69 0 0 0
cpu4 416879 34181 199780 1048443 9300 42 4748 0 0 0
cpu5 364569 43062 168908 1132328 6552 23 4019 0 0 0
cpu6 299977 39261 108045 1213796 5693 11 2655 0 0 0
cpu7 244947 34847 84068 1498462 4215 3 1684 0 0 0
intr 39474867 0 0 0 0 0 0 0 0 0 0 0 0 0 270673 0 0 0 0 0 0 10994346 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1714739 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 16162 197 5 0 1939 0 0 0 2126792 0 0 0 0 0 0 0 0 0 0 398 0 0 0 0 1087 5394 41 4 0 0 1311 0 5062 0 25 0 0 0 0 0 0 0 0 0 0 0 0 614903 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3284 261634 0 485428 1078314 32096 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 907399 0 9230 0 0 0 0 0 0 0 0 0 0 0 0 1233 0 0 0 36998 5 0 720433 388821 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1079002 0 0 14157 0 0 0 0 0 0 0 0 0 0 0 120428 0 0 0 0 0 0 1520 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 272107 0 0 0 0 0 0 0 0 0 0 0 0 1422 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 46 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 226 4 599 0 10 0 0 0 23 22 0 0 0 0 0 0 0 0 0 0 0 0 0 592 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 794 598 0 38 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 91302539
btime 1599731981
processes 94321
procs_running 3
procs_blocked 0
softirq 21789749 8160 7915061 16681 457270 8160 8160 580778 6955475 12121 5827883
EOF

# Install dogeland addon
cp $TOOLKIT/cli.sh $rootfs2/dogeland/
mkdir $rootfs2/dogeland/include/
cp -R $TOOLKIT/include/* $rootfs2/dogeland/include/

# EchoRootfsInfo
if [ -f "$rootfs2/info.log" ];then
cat $rootfs2/info.log
rm -rf $rootfs2/info.log
else
echo "">/dev/null
fi

# clean dropbear old key
rm -rf $rootfs2/etc/dropbear
mkdir $rootfs2/etc/dropbear
chmod -R 0777 $rootfs2/etc/dropbear/

. $TOOLKIT/include/extra_linuxconfigure.sh configure
echo "! all done"
}