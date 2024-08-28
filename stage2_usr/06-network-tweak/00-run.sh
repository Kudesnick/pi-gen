#!/bin/bash -e

# see https://github.com/raspberrypi/bookworm-feedback/issues/72#issuecomment-1848778447

if [ $WPA_ESSID ] && [ $WPA_PASSWORD ]; then
    WPA_LIST=("${WPA_ESSID}:${WPA_PASSWORD}")
fi

PRIORITY=0

for WPA in "${WPA_LIST[@]}" ; do

ESSID="${WPA%%:*}"
PASSWORD="${WPA##*:}"
((PRIORITY++))

# nmcli dev wifi connect ${ESSID} password ${PASSWORD}
# nmcli connection modify ${ESSID} connection.autoconnect yes
cat >${ROOTFS_DIR}/etc/NetworkManager/system-connections/${ESSID}.nmconnection <<EOF
[connection]
id=${ESSID}
uuid=$(uuidgen)
type=wifi
interface-name=wlan0
autoconnect=true
autoconnect-priority=${PRIORITY}

[wifi]
mode=infrastructure
ssid=${ESSID}

[wifi-security]
auth-alg=open
key-mgmt=wpa-psk
psk=$(wpa_passphrase ${ESSID} ${PASSWORD} | grep -E '[^#]psk=' | sed 's/.*psk=//')

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]
EOF
on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}"
    chmod 600 /etc/NetworkManager/system-connections/${ESSID}.nmconnection
EOF

done # WPA
