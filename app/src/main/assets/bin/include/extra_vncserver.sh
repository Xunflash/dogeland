# dogeland cli module
#
# license: gpl-v3
vncserver_start(){
echo "- vncserver::start..."
echo "- Port: 22221"
/bin/sh vncserver :22221 &
}