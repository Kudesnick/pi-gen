#!/bin/bash -e

CONF_PATH="${ROOTFS_DIR}/boot/firmware/config.txt"

function param_on {
    grep -q "$1" "${CONF_PATH}" || sed -i "$ a $1" "${CONF_PATH}"
	sed -i "s/#*$1/$1/" "${CONF_PATH}"
}

function param_off {
	sed -i "s/^$1/#$1/" "${CONF_PATH}"
}
