#!/bin/bash -e

if [ $USR_UART_CONSOLE ]; then
	sed -i "$ a # Enable hardware UART console" "${ROOTFS_DIR}/boot/config.txt"
	sed -i "$ a enable_uart=1" "${ROOTFS_DIR}/boot/config.txt"
fi

function param_on {
	sed -i "s/#*$1/$1/" "${ROOTFS_DIR}/boot/config.txt"
}

function param_off {
	sed -i "s/^$1/#$1/" "${ROOTFS_DIR}/boot/config.txt"
}

param_off "dtparam=audio=on"
param_off "camera_auto_detect=1"
param_off "display_auto_detect=1"
param_off "dtoverlay=vc4-kms-v3d"
param_off "max_framebuffers=2"
param_off "disable_overscan=1"

param_on "dtparam=i2c_arm=on"
#param_on "dtparam=i2s=on"
param_on "dtparam=spi=on"
#param_on "dtoverlay=gpio-ir,gpio_pin=17"
#param_on "dtoverlay=gpio-ir-tx,gpio_pin=18"
