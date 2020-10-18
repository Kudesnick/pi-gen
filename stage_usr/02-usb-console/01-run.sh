#!/bin/bash -e

# instead of "systemctl enable getty@ttyGS0.service" on ch_root mode
SIM_LINK="${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/getty@ttyGS0.service"
if [ ! -L ${SIM_LINK} ] ; then
	ln -s /lib/systemd/system/getty@.service ${SIM_LINK}
fi
