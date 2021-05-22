# dogeland cli module
#
# license: gpl-v3
dropbear_start(){
echo "- dropbear_start..."

# configure keys
if [ -f "/etc/dropbear/dropbear_dss_host_key" ];then
echo "">/dev/null
else
dropbearkey -t dss -s 1024 -f /etc/dropbear/dropbear_dss_host_key
fi
if [ -f "/etc/dropbear/dropbear_rsa_host_key" ];then
echo "">/dev/null
else
dropbearkey -t rsa -s 2048 -f /etc/dropbear/dropbear_rsa_host_key
fi
if [ -f "/etc/dropbear/dropbear_ecdsa_host_key" ];then
echo "">/dev/null
else
dropbearkey -t ecdsa -s 521 -f /etc/dropbear/dropbear_ecdsa_host_key
fi
if [ -f "/etc/dropbear/dropbear_ed25519_host_key" ];then
echo "">/dev/null
else
dropbearkey -t ed25519 -s 256 -f /etc/dropbear/dropbear_ed25519_host_key
fi
# START
echo "- SSH Port: 4422"
dropbear -E -p 4422 &
}
dropbear_stop()
{
echo "- dropbear_stop..."
pkill dropbear
}