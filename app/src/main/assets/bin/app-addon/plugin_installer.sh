echo "- 正在解压"
unzip $file -d $START_DIR/
echo "- 正在安装"
. $START_DIR/install.sh
rm $START_DIR/install.sh
echo "- 已完成"
