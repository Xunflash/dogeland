# app to container
filetran_send(){
echo "- 正在上传文件到/dogeland/filetran_r"
cp -R $file $rootfs/dogeland/filetran_r/
chmod -R 0770 $rootfs/dogeland/filetran_r/
echo "!上传完成"
}
# container to app
filetran_receive(){
echo "- 正在接收文件到$savedir"
cp -R $rootfs/dogeland/.filetran_s/* $savedir
rm -rf $rootfs/dogeland/.filetran_s/*
echo "!接收完成"
}
filetran_sender(){
echo "- 正在上传 $2"
cp -R $2 /dogeland/.filetran_s/
echo "!上传完成"
}