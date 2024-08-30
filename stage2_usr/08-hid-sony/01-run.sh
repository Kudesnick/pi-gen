#!/bin/bash -e

install -m 755 files/ps3pair.sh     "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
install -m 755 files/ps4pair.sh     "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
install -m 755 files/show_charge.sh "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"

#see https://wiki.archlinux.org/title/Gamepad#PlayStation_3_controller
sed -i "s/#ClassicBondedOnly=true/ClassicBondedOnly=false/" "${ROOTFS_DIR}/etc/bluetooth/input.conf"
sed -i "s/#UserspaceHID=true/UserspaceHID=false/" "${ROOTFS_DIR}/etc/bluetooth/input.conf"
