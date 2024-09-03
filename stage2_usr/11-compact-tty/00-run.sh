#!/bin/bash -e

patch --no-backup-if-mismatch -f "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc" < "files/.bashrc.diff"
