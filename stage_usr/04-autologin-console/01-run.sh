#!/bin/bash -e

# instead of "systemctl enable serial-getty@ttyAMA0.service" on ch_root mode
SIM_LINK="${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/serial-getty@ttyAMA0.service"
if [ ! -L ${SIM_LINK} ] ; then
	ln -s /lib/systemd/system/serial-getty@.service ${SIM_LINK}
fi

# replace user name after patches with variable value from config
sed -i "s/--autologin pi/--autologin ${FIRST_USER_NAME}/" "${ROOTFS_DIR}/lib/systemd/system/getty@.service"
sed -i "s/--autologin pi/--autologin ${FIRST_USER_NAME}/" "${ROOTFS_DIR}/lib/systemd/system/serial-getty@.service"

