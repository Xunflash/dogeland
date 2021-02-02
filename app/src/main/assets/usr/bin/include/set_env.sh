# dogeland cli module
#
# license: gpl-v3
set_env(){
if [[ -f "$DATA2_DIR/custom_path.conf" ]]; then
  export PATH2=$(cat $DATA2_DIR/custom_path.conf)
fi
unset TMP TEMP TMPDIR LD_PRELOAD LD_DEBUG
PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games:/usr/local/sbin:/sbin:$PATH2
}