#!/bin/bash -e

# see https://github.com/raspberrypi/bookworm-feedback/issues/72#issuecomment-1848778447

if [ $WPA_ESSID ] && [ $WPA_PASSWORD ]; then
	WPA_LIST=("${WPA_ESSID}:${WPA_PASSWORD}")
fi

PRIORITY=0

for WPA in ${WPA_LIST}; do
	ESSID="${WPA%%:*}"
	PASSWORD="${WPA##*:}"
	PRIORITY=$((PRIORITY + 1))
	FILE_NAME="/etc/NetworkManager/system-connections/${ESSID}.nmconnection"

	# nmcli dev wifi connect ${ESSID} password ${PASSWORD}
	# nmcli connection modify ${ESSID} connection.autoconnect yes
	# nmcli connection modify ${ESSID} connection.autoconnect-priority ${PRIORITY}

	install -m 600 files/wifi.connection ${ROOTFS_DIR}${FILE_NAME}
	sed -i "s/^id=/id=${ESSID}/" ${ROOTFS_DIR}${FILE_NAME}
	sed -i "s/^uuid=/uuid=$(uuidgen)/" ${ROOTFS_DIR}${FILE_NAME}
	sed -i "s/^autoconnect-priority=/autoconnect-priority=${PRIORITY}/" ${ROOTFS_DIR}${FILE_NAME}
	sed -i "s/^ssid=/ssid=${ESSID}/" ${ROOTFS_DIR}${FILE_NAME}
	sed -i "s:psk=:psk=$(wpa_passphrase ${ESSID} ${PASSWORD} | grep -E '[^#]psk=' | sed 's/.*psk=//'):" ${ROOTFS_DIR}${FILE_NAME}
done # WPA
