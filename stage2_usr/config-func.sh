#!/bin/bash -e

CONF_PATH="${ROOTFS_DIR}/boot/config.txt"

KRNL_DIR=$(find /usr/lib/modules/*/kernel/ | head -1 | sed -e s:/kernel/::) # uname not work in chroot: https://unix.stackexchange.com/questions/302869/practical-use-of-uname-in-chroot)

function param_on {
    grep -q "$1" "${CONF_PATH}" || sed -i "$ a $1" "${CONF_PATH}"
	sed -i "s/#*$1/$1/" "${CONF_PATH}"
}

function param_off {
	sed -i "s/^$1/#$1/" "${CONF_PATH}"
}
