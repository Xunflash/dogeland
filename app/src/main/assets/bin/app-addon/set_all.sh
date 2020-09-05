#
set_path(){
echo $Input:"$PATH">$rootfs/etc/profile
}
set_tempdir(){
    if [ ! -n "$Input" ]; then
    echo "- 检测到没有输入内容,取消更改."
    else
    rm -rf $CONFIG_DIR/tmpdir.conf
    echo "$Input">$CONFIG_DIR/tmpdir.conf
fi
}
set_rootfsdir(){
if [ ! -n "$Input" ]; then
echo "- 检测到没有输入内容,取消更改."
    else
    rm -rf $CONFIG_DIR/rootfs.conf
    echo "$Input">$CONFIG_DIR/rootfs.conf
    fi
}
set_initcmd(){
if [ ! -n "$Input" ]; then
 echo "- 检测到没有输入内容,取消更改."
else
 rm -rf $CONFIG_DIR/cmd.conf
 echo "$Input">$CONFIG_DIR/cmd.conf
fi
}
set_emulator_qemu(){
if [[ "$qemu" != "0" ]]
then
rm -rf $CONFIG_DIR/emulator_qemu
echo "$qemu">$CONFIG_DIR/emulator_qemu
else
rm -rf $CONFIG_DIR/emulator_qemu
fi
}
$1