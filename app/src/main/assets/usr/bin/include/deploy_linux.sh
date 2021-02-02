# dogeland cli module
#
# license: gpl-v3
deploy_linux(){
deploy_linux_step1
echo "- 正在安装 Rootfs"
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
echo "- 正在安装Rootfs"
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
echo "- 正在下载 LXC Image"
rm -rf $rootfs2
mkdir -p $rootfs2/
$TOOLKIT/wget $image_url -O $TMPDIR/image_tmp.tar.xz

if [ -e "$TMPDIR/image_tmp.tar.xz" ];then
echo "">/dev/null
else
echo "! 下载失败"
exit 1
fi
echo "- 正在安装 LXC Image"
# Enbale Link2SymLink for NonRoot
if [ `id -u` -eq 0 ];then
    tar="$TOOLKIT/busybox tar -xJf $TMPDIR/image_tmp.tar.xz -C $rootfs2"
else
    tar="$TOOLKIT/proot --link2symlink -0 $TOOLKIT/busybox tar --no-same-owner -xJf $TMPDIR/image_tmp.tar.xz -C $rootfs2"
fi
$tar >/dev/null
echo "- 正在清除 LXC Image 缓存"
rm $TMPDIR/image_tmp.tar.xz
# Modded for dogeland
mkdir -p $rootfs2/dogeland/
touch $rootfs2/dogeland/cmd.conf
touch $rootfs2/dogeland/patch.sh
# Repair NetworkResolv
echo "nameserver 8.8.8.8">$rootfs2/etc/resolv.conf
deploy_linux_step2
}

# Post Installed Before
deploy_linux_step1(){
if [ ! -n "$rootfs2" ]; then
    echo "!选择的路径不可用"
    exit 1
    else
    echo "">/dev/null
fi
if [ ! -n "$file" ]; then
    if [ ! -n "$file2" ]; then
    echo "!选择的源文件不可用"
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
  echo "!解压过程出现异常"
  exit 255
fi
echo "- 正在执行附加操作"
if [ -d "$rootfs2/dogeland/" ];then
 # Setup from RootfsPackageData
  cat $rootfs2/dogeland/cmd.conf >$CONFIG_DIR/cmd.conf
  . $rootfs2/dogeland/patch.sh
  rm -rf  $rootfs2/dogeland/*
  echo "$rootfs2" >$CONFIG_DIR/rootfs.conf
  else
  mkdir $rootfs2/dogeland/
  # Use Empty ConfigData
  echo "$type">$CONFIG_DIR/cmd.conf
  echo "$rootfs2" >$CONFIG_DIR/rootfs.conf
fi

# make empty status 
echo "Stop">$rootfs2/dogeland/status
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
mkdir $rootfs2/dogeland/filetran_r/
mkdir $rootfs2/dogeland/.filetran_s/
cp -R $TOOLKIT/include/* $rootfs2/dogeland/include/
# Run Other Setup
. $TOOLKIT/include/extra_linuxconfigure.sh configure
echo "! 全部完成"
}