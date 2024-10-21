#!/bin/bash -e

source ../config-func.sh

param_om pwm-2chan,pin=12,func=4,pin2=19,func2=2
param_om gpio-shutdown,gpio_pin=16

on_chroot usermod -G gpio -a ${FIRST_USER_NAME}
