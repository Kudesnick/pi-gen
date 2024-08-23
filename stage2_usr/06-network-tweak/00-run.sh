#!/bin/bash -e

# see https://github.com/raspberrypi/bookworm-feedback/issues/72#issuecomment-1848778447

if [ $WPA_ESSID ] && [ $WPA_PASSWORD ]; then
# nmcli dev wifi connect ${WPA_ESSID} password ${WPA_PASSWORD}
# nmcli connection modify ${WPA_ESSID} connection.autoconnect yes
cat >${ROOTFS_DIR}/etc/NetworkManager/system-connections/${WPA_ESSID}.nmconnection <<EOF
[connection]
id=${WPA_ESSID}
uuid=$(uuidgen)
type=wifi
interface-name=wlan0
autoconnect=true

[wifi]
mode=infrastructure
ssid=${WPA_ESSID}

[wifi-security]
auth-alg=open
key-mgmt=wpa-psk
psk=$(wpa_passphrase ${WPA_ESSID} ${WPA_PASSWORD} | grep -E '[^#]psk=' | sed 's/.*psk=//')

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]
EOF
on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}"
    chmod 600 /etc/NetworkManager/system-connections/${WPA_ESSID}.nmconnection
EOF
fi
