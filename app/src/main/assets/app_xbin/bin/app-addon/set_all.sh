#
set_path(){
echo $Input:"$PATH">$rootfs/etc/profile
}
set_rootfsdir(){
    if [ ! -n "$Input" ]; then
    echo "- No input is detected, cancel the change."
    else
    rm -rf $CONFIG_DIR/rootfs.config
    echo "$Input">$CONFIG_DIR/rootfs.config
    fi
}
set_initcmd(){
if [ ! -n "$Input" ]; then
 echo "- No input is detected, cancel the change."
else
 rm -rf $CONFIG_DIR/cmd.config
 echo "$Input">$CONFIG_DIR/cmd.config
fi
}
set_emulator_qemu(){
if [[ "$qemu" != "0" ]]
then
rm -rf $CONFIG_DIR/emulator_qemu.config
echo "$qemu">$CONFIG_DIR/emulator_qemu.config
else
rm -rf $CONFIG_DIR/emulator_qemu.config
fi
}
$1