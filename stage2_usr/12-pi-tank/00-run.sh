#!/bin/bash -e

install -m 555 files/lcd_hat_keyboard-overlay.dts ${ROOTFS_DIR}
on_chroot <<- EOF
    dtc -I dts -O dtb -o "/boot/overlays/lcd_hat_keyboard.dtbo" "lcd_hat_keyboard-overlay.dts" -W no-unit_address_vs_reg
EOF
rm ${ROOTFS_DIR}/lcd_hat_keyboard-overlay.dts
