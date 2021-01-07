#!/bin/bash -e

# replace user name after patches with variable value from config
sed -i "s/--autologin pi/--autologin ${FIRST_USER_NAME}/" "${ROOTFS_DIR}/lib/systemd/system/getty@.service"
sed -i "s/--autologin pi/--autologin ${FIRST_USER_NAME}/" "${ROOTFS_DIR}/lib/systemd/system/serial-getty@.service"
