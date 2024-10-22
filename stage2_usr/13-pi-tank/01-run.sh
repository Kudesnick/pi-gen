#!/bin/bash -e

install -m 555 files/lcd_hat_keyboard.dts ${ROOTFS_DIR}
on_chroot dtc -I dts -O dtb -o /boot/overlays/lcd_hat_keyboard.dtbo lcd_hat_keyboard-overlay.dts -W no-unit_address_vs_reg
rm ${ROOTFS_DIR}/lcd_hat_keyboard.dts
