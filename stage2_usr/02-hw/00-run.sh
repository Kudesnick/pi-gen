#!/bin/bash -e

source ../config-func.sh

if [ $USR_UART_CONSOLE ]; then
	param_on "# Enable hardware UART console"
	param_on "enable_uart=1"
fi

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
