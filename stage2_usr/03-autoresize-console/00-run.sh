#!/bin/bash -e

tee -a "${ROOTFS_DIR}/etc/bash.bashrc" < "files/bash.bashrc"
