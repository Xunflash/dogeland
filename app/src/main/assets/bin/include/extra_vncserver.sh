# dogeland cli module
#
# license: gpl-v3
vncserver_start(){
echo "- vncserver::start..."
echo "- Port: 22221"
/bin/bash vncserver :22221 &
}