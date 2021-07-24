init_boxenv(){
if [[ ! -d "$TMPDIR/boxenv" ]]; then
echo "">/dev/null
else
rm -rf $TMPDIR/boxenv
fi
if [[ "$boxenv" != "1" ]]
then
echo "">/dev/null
else
echo "- Starting Sandbox mode"
mkdir $TMPDIR/boxenv
if [ `id -u` -eq 0 ];then
    cp -R $rootfs/* $TMPDIR/boxenv
else
    proot --link2symlink -0 cp -R $rootfs/* $TMPDIR/boxenv
fi
echo "Stop">$TMPDIR/boxenv/boot/dogeland/status
unset rootfs
export rootfs="$TMPDIR/boxenv"
fi
}