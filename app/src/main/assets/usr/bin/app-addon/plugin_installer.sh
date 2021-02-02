echo "- Unpacking"
unzip $file -d $START_DIR/
echo "- Installing"
. $START_DIR/install.sh
rm $START_DIR/install.sh
echo "- All done"
