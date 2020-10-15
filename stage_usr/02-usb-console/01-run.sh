#!/bin/bash -e

# instead of "systemctl enable getty@ttyGS0.service" on ch_root mode
ln -s /lib/systemd/system/getty@.service "${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/getty@ttyGS0.service"

