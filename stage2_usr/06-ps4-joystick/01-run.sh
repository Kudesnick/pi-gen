#!/bin/bash -e

install -m 755 files/ps3pair.sh     "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
install -m 755 files/show_charge.sh "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
