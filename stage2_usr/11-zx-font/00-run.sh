#!/bin/bash -e

install -m 555 files/console-setup "${ROOTFS_DIR}/etc/default/"
wget -q -O - https://github.com/Kudesnick/zx_psf/raw/master/zx.psf | gzip -c > "${ROOTFS_DIR}/usr/share/consolefonts/zx-8x8.psf.gz"
