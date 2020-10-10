# dogeland cli module
#
# license: gpl-v3
backup_rootfs(){
check_rootfs_status
echo "- Exporting rootfs "
cd $rootfs/
if [[ "$(pwd)" != "/" ]]
then

if [ `id -u` -eq 0 ];then
    $TOOLKIT/busybox tar czvf "$dir/backup.tgz" --exclude='./dev' --exclude='./sys' --exclude='./proc' --exclude='./mnt' --exclude='./dogeland' ./ >/dev/null
else
    $TOOLKIT/proot --link2symlink -0 $TOOLKIT/busybox tar czvf "$dir/backup.tgz" --exclude='./dev' --exclude='./sys' --exclude='./proc' --exclude='./mnt'  --exclude='./dogeland' ./ >/dev/null
fi

echo "Saved to $dir/backup.tgz"
else
echo "!An error occurred while exporting"
exit 1
fi
echo "- 完成"

}