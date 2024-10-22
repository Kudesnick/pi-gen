#!/bin/bash -e

source ../config-func.sh

if [ $LCD_HAT ]; then
	tee -a "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc" < "files/.bashrc"

	param_on "# lcd settings for ${LCD_HAT} CCW rotation"
	param_on "dtparam=spi=on"
	param_on "hdmi_ignore_hotplug=1"
	param_on "enable_tvout=0"
	param_on "dtoverlay=lcd_hat_keyboard,rot${LCD_HAT}"

	declare -A ROTATE
	ROTATE['0']='90'
	ROTATE['90']='0'
	ROTATE['180']='270'
	ROTATE['270']='180'
	param_on "dtoverlay=adafruit-st7735r,128x128,dc_pin=25,reset_pin=27,led_pin=24,rotate=${ROTATE[$LCD_HAT]}"
fi
