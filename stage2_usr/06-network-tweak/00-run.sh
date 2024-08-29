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
	FILE_NAME="/etc/NetworkManager/system-connections/${ESSID}.nmconnection"

	# nmcli dev wifi connect ${ESSID} password ${PASSWORD}
	# nmcli connection modify ${ESSID} connection.autoconnect yes
	# nmcli connection modify ${ESSID} connection.autoconnect-priority ${PRIORITY}

	install -m 600 files/wifi.connection ${ROOTFS_DIR}${FILE_NAME}
	sed -i "s/id=/id=${ESSID}/"
	sed -i "s/uuid=/uuid=$(uuidgen)/"
	sed -i "s/autoconnect-priority=/autoconnect-priority=${PRIORITY}/"
	sed -i "s/ssid=/ssid=${ESSID}/"
	sed -i "s:psk=:psk=$(wpa_passphrase ${ESSID} ${PASSWORD} | grep -E '[^#]psk=' | sed 's/.*psk=//'):"
done # WPA
