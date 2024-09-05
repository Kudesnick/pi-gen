#!/bin/bash -e

if [ "${RELEASE}" -eq "bookworm" ]; then
    rm -fr ${ROOTFS_DIR}/boot/config.txt ${ROOTFS_DIR}/boot/cmdline.txt ${ROOTFS_DIR}/boot/overlays
    ln -s firmware/config.txt ${ROOTFS_DIR}/boot/config.txt
    ln -s firmware/cmdline.txt ${ROOTFS_DIR}/boot/cmdline.txt
    ln -s firmware/overlays ${ROOTFS_DIR}/boot/overlays
elif [ "${RELEASE}" -ne "bullseye" ]; then
    echo "RELEASE must be bullseye or bookworm only"
    exit 1
fi
