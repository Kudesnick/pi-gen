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

if [ $SHTDN ]; then
	param_on "dtoverlay=gpio-shutdown,gpio_pin=${SHTDN}"
fi

if [ $PWROFF ]; then
	param_on "dtoverlay=gpio-poweroff,gpiopin=${PWROFF}"
fi

if [ $PWM ]; then
	case $PWM in
		# dual channel
		"12,13")
			param_on "dtoverlay=pwm-2chan,pin=12,func=4,pin2=13,func2=4";;
		"18,13")
			param_on "dtoverlay=pwm-2chan,pin=18,func=2,pin2=13,func2=4";;
		"12,19")
			param_on "dtoverlay=pwm-2chan,pin=12,func=4,pin2=19,func2=2";;
		"18,19")
			param_on "dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2";;
		# single channel
		"12")
			param_on "dtoverlay=pwm,pin=12,func=4";;
		"18")
			param_on "dtoverlay=pwm,pin=18,func=2";;
		"13")
			param_on "dtoverlay=pwm,pin=13,func=4";;
		"19")
			param_on "dtoverlay=pwm,pin=19,func=2";;
		*)
			echo "Error! Invalid PWM GPIO!"; exit(1);;
	esac
fi

on_chroot usermod -G gpio -a ${FIRST_USER_NAME}
