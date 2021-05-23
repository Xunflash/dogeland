echo "- Unpacking"
mkdir -p $TMPDIR/cache_pkg
unzip $file -d $TMPDIR/cache_pkg
chmod -R 0770 $TMPDIR/cache_pkg
echo "- Installing"
. $TMPDIR/cache_pkg/info.config.sh
cp $FILE $TOOLKIT/bin/
chmod 0770 $TOOLKIT/bin/
rm -rf $TMPDIR/cache_pkg
echo "- All done"
