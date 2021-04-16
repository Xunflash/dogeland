#
# dogeland CLI LinuxConfigure
# 
#

# Set your rootfs path.
export rootfs="$rootfs2"
#
configure()
{
    echo "progress:[7/10]"
    echo "- Setting up mtab ..."
    rm -rf $rootfs/etc/mtab && cp /proc/mounts $rootfs/etc/mtab

    echo "- Setting up hostname ... "
    echo 'localhost' > "$rootfs/etc/hostname"

    echo "- Setting up hosts ... "
		cat <<- EOF > "$rootfs/etc/hosts"
		# IPv4.
		127.0.0.1   localhost.localdomain localhost

		# IPv6.
		::1         localhost.localdomain localhost ipv6-localhost ipv6-loopback
		fe00::0     ipv6-localnet
		ff00::0     ipv6-mcastprefix
		ff02::1     ipv6-allnodes
		ff02::2     ipv6-allrouters
		ff02::3     ipv6-allhosts
		EOF
    echo "progress:[8/10]"
    echo "- Setting up locale ... "
    LOCALE="C"
    if $(echo ${LOCALE} | grep -q '$rootfs\.'); then
        local inputfile=$(echo ${LOCALE} | awk -F. '{print $1}')
        local charmapfile=$(echo ${LOCALE} | awk -F. '{print $2}')
        export cmd2="localedef -i ${inputfile} -c -f ${charmapfile} ${LOCALE}"
        exec_auto
        unset cmd2
    fi
    
    echo "- Setting up su ... "
    local item pam_su
    for item in $rootfs/etc/pam.d/su $rootfs/etc/pam.d/su-l
    do
        pam_su="$rootfs/${item}"
        if [ -e "${pam_su}" ]; then
            if ! $(grep -q '^auth.*sufficient.*pam_succeed_if.so uid = 0 use_uid quiet$' "${pam_su}"); then
                sed -i '1,/^auth/s/^\(auth.*\)$/auth\tsufficient\tpam_succeed_if.so uid = 0 use_uid quiet\n\1/' "${pam_su}"
            fi
        fi
    done
    chmod a+s $rootfs/bin/su
    echo "- Setting up timezone ... "
    # for android
    if [ -n "$(which getprop)" ]; then
        timezone=$(getprop persist.sys.timezone)
    elif [ -e "/etc/timezone" ]; then
        timezone=$(cat /etc/timezone)
    fi
    # set up
    rm -f "$rootfs/etc/localtime"
    cp "$rootfs/usr/share/zoneinfo/$timezone" "$rootfs/etc/localtime"
    echo $timezone > "$rootfs/etc/timezone"
    echo "progress:[9/10]"
    echo "- Setting up profile ... "
   [ -n "$USER_NAME" ] || USER_NAME="root"
   [ -n "$USER_PASSWORD" ] || USER_PASSWORD="root"
    # user profile
    if [ "$USER_NAME" != "root" ]; then
    cmd2="useradd $USER_NAME"
    exec_auto && unset cmd2
    else
    echo "">/dev/null
    fi
    # Password
    cmd2="chpasswd"
    echo $USER_NAME:$USER_PASSWORD|exec_auto && unset cmd2
    # env
    echo "PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games:/usr/local/sbin:/sbin">>$rootfs/etc/profile
    
    echo "- Setting up sudo ... "
    sudo_str="$USER_NAME ALL=(ALL:ALL) NOPASSWD:ALL"
    if ! grep -q "$sudo_str" "$rootfs/etc/sudoers"; then
        chmod 640 "$rootfs/etc/sudoers"
        echo $sudo_str >> "$rootfs/etc/sudoers"
        chmod 440 "$rootfs/etc/sudoers"
    fi
    if [ -e "$rootfs/etc/profile.d" ]; then
        echo '[ -n "$PS1" -a "$(whoami)" = "'$USER_NAME'" ] || return 0' > "$rootfs/etc/profile.d/sudo.sh"
        echo 'alias su="sudo su"' >> "$rootfs/etc/profile.d/sudo.sh"
    fi
    echo "- Setting up group ... "
    # set min uid and gid
    login_defs="$rootfs/etc/login.defs"
    if [ ! -e "$login_defs" ]; then
        touch "$login_defs"
    fi
    if ! $(grep -q '^ *UID_MIN' "$login_defs"); then
        echo "UID_MIN 5000" >>"$login_defs"
        sed -i 's|^[#]\?UID_MIN.*|UID_MIN 5000|' "$login_defs"
    fi
    if ! $(grep -q '^ *GID_MIN' "$login_defs"); then
        echo "GID_MIN 5000" >>"$login_defs"
        sed -i 's|^[#]\?GID_MIN.*|GID_MIN 5000|' "$login_defs"
    fi
   # Add Android-specific group
    echo "aid_$(id -un):x:$(id -u):$(id -g):Android user:/:/usr/sbin/nologin" >> "$rootfs/etc/passwd"
    echo "aid_$(id -un):*:18446:0:99999:7:::" >> "$rootfs/etc/shadow"
    local aid
        for aid in $(cat "$TOOLKIT/include/android_groups")
        do
            local xname=$(echo ${aid} | awk -F: '{print $1}')
            local xid=$(echo ${aid} | awk -F: '{print $2}')
            sed -i "s|^${xname}:.*|${xname}:x:${xid}:|" "$rootfs/etc/group"
            if ! $(grep -q "^${xname}:" "$rootfs/etc/group"); then
                echo "${xname}:x:${xid}:" >> "$rootfs/etc/group"
            fi
            if ! $(grep -q "^${xname}:" "$rootfs/etc/passwd"); then
                echo "${xname}:x:${xid}:${xid}::/:/bin/false" >> "$rootfs/etc/passwd"
            fi
        done
        echo "progress:[10/10]"
}
$@