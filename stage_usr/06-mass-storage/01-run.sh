#!/bin/bash -e

sudo dd bs=1M if=/dev/zero of="${ROOTFS_DIR}/piusb.bin" count=2048
sudo mkdosfs "${ROOTFS_DIR}/piusb.bin"
echo "options g_acm_ms file=/piusb.bin removable=y ro=0 stall=0" | sudo tee -a "${ROOTFS_DIR}/etc/modprobe.d/g_acm_ms.conf"

on_chroot << EOF

EOF
