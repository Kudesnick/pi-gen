#!/bin/bash -e

on_chroot << EOF

systemctl enable bluetooth.service
usermod -G bluetooth -a pi

EOF

install -m 755 files/ps3pair.sh "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"

