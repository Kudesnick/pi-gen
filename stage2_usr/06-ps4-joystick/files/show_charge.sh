#!/bin/bash

MACS=$(find '/sys/class/power_supply/' -name 'sony_controller_battery_*' | sed -r 's/.*(.{17})/\1/')

tput clear
tput cup 0 0

[ -z "${MACS}" ] && echo 'No gamepad'
[ -z "${MACS}" ] && exit 0

for MAC in ${MACS}
do
        ID=$(echo $MAC | sed -e 's/://g')
        CHRG=$(cat "/sys/class/power_supply/sony_controller_battery_${MAC}/capacity")
        echo ID:$ID
        echo charge:$CHRG
done
