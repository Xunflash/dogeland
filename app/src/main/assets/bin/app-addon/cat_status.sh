if [[ "$(cat $rootfs/dogeland/status)" != "Run" ]]
then
echo -n "已关闭"
else
echo -n "正在运行"
fi