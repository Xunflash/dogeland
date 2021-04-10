# dogeland cli module
#
# license: gpl-v3
sshd_start()
{
echo "- openssh-sshd::start..."
if [ $(ls "/etc/ssh/" | grep -c key) -eq 0 ]; then
   ssh-keygen -A >/dev/null
fi
rm -rf /run/sshd
rm -rf /var/run/sshd
mkdir /run/sshd /var/run/sshd
ssh-keygen -A
chmod 555 /run/sshd
echo "- SSH Port: 3022"
/usr/sbin/sshd -p 3022 &
}
sshd_stop()
{
echo "- openssh-sshd::stop..."
kill -9 /run/sshd.pid /var/run/sshd.pid
pkill sshd
}