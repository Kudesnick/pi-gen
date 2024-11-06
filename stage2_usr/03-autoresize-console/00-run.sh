#!/bin/bash -e

cat "files/.bashrc" >> "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc"
