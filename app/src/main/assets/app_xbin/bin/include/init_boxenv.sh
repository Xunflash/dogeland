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
cp -R $rootfs $TMPDIR/boxenv
unset rootfs
export rootfs="$TMPDIR/boxenv"
fi
}