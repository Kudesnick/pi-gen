#!/bin/bash -e

# instead of "systemctl enable serial-getty@ttyAMA0.service" on ch_root mode
ln -s /lib/systemd/system/serial-getty@.service "${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/serial-getty@ttyAMA0.service"

# replace user name after patches with variable value from config
sed "s/--autologin pi/--autologin ${FIRST_USER_NAME}" ${ROOTFS_DIR}/lib/systemd/system/getty@.service
sed "s/--autologin pi/--autologin ${FIRST_USER_NAME}" ${ROOTFS_DIR}/lib/systemd/system/serial-getty@.service

