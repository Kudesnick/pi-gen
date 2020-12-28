#!/bin/bash -e

sudo dd bs=1M if=/dev/zero of="${ROOTFS_DIR}/piusb.bin" count=2048
sudo mkdosfs "${ROOTFS_DIR}/piusb.bin"

# not working, see https://stackoverflow.com/questions/63540052/raspberry-pi-zero-as-read-write-mass-storage/65470397#65470397
# echo "options g_acm_ms file=/piusb.bin removable=y ro=0 stall=0" | sudo tee -a "${ROOTFS_DIR}/etc/modprobe.d/g_acm_ms.conf"
echo "blacklist g_acm_ms" | sudo tee -a "${ROOTFS_DIR}/etc/modprobe.d/blacklist-g_acm_ms.conf"

echo "/piusb.bin /media/piusb auto defaults,noatime,sync,user,nofail,rw,umask=0000 0 0" | sudo tee -a "${ROOTFS_DIR}/etc/fstab"

on_chroot << EOF

EOF
