edit_passwd(){
export cmd2=chpasswd
echo "$username:$password"|exec_auto
unset cmd2
}
