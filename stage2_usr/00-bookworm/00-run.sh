#!/bin/bash -e

if [ "${RELEASE}" == "bookworm" ]; then
    rm -fr ${ROOTFS_DIR}/boot/config.txt ${ROOTFS_DIR}/boot/cmdline.txt ${ROOTFS_DIR}/boot/overlays
    ln -fs firmware/config.txt ${ROOTFS_DIR}/boot/config.txt
    ln -fs firmware/cmdline.txt ${ROOTFS_DIR}/boot/cmdline.txt
    ln -fs firmware/overlays ${ROOTFS_DIR}/boot/overlays
elif [ "${RELEASE}" != "bullseye" ]; then
    echo "RELEASE must be bullseye or bookworm only"
    exit 1
fi
