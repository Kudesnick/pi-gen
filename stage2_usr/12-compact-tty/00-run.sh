#!/bin/bash -e

patch --no-backup-if-mismatch -f "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc" < "files/.bashrc.diff" || true
rm -f "${ROOTFS_DIR}/etc/motd"
sed -i "s/#PrintLastLog yes/PrintLastLog no/" "${ROOTFS_DIR}/etc/ssh/sshd_config"
