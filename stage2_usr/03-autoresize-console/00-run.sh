#!/bin/bash -e

tee -a "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc" < "files/.bashrc"
