#!/bin/bash -e

if [ $USR_AUTOLOGIN ]; then
    sed -i --follow-symlinks "s/-o '-p -- \\\*\\\u'/--autologin ${FIRST_USER_NAME}/" "${ROOTFS_DIR}/usr/lib/systemd/system/getty@.service"
    sed -i --follow-symlinks "s/-o '-p -- \\\*\\\u'/--autologin ${FIRST_USER_NAME}/" "${ROOTFS_DIR}/usr/lib/systemd/system/serial-getty@.service"
fi
