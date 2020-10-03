# dogeland cli module
#
# license: gpl-v3
backup_rootfs(){
check_rootfs_status
echo "- 正在备份"
cd $rootfs/
if [[ "$(pwd)" != "/" ]]
then

if [ `id -u` -eq 0 ];then
    $TOOLKIT/busybox tar czvf "$dir/backup.tgz" --exclude='./dev' --exclude='./sys' --exclude='./proc' --exclude='./mnt'  --exclude='./sdcard'  --exclude='./dogeland' ./ >/dev/null
else
    $TOOLKIT/proot --link2symlink $TOOLKIT/busybox tar czvf "$dir/backup.tgz" --exclude='./dev' --exclude='./sys' --exclude='./proc' --exclude='./mnt'  --exclude='./sdcard'  --exclude='./dogeland' ./ >/dev/null
fi

echo "已保存到 $dir/backup.tgz"
else
echo "!打包时出现错误"
exit 1
fi
echo "- 完成"

}