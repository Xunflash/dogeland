# app to container
filetran_send(){
echo "- Uploading to /dogeland/filetran_r"
cp -R $file $rootfs/dogeland/filetran_r/
chmod -R 0770 $rootfs/dogeland/filetran_r/
echo "!done"
}
# container to app
filetran_receive(){
echo "- Receiving File to$savedir"
cp -R $rootfs/dogeland/.filetran_s/* $savedir
rm -rf $rootfs/dogeland/.filetran_s/*
echo "!done"
}
filetran_sender(){
echo "- Sending $target"
cp -R $target /dogeland/.filetran_s/
echo "!done"
}