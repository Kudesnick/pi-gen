#!/bin/bash -e

git clone https://github.com/kudesnick/pi-tank.git

cd pi-tank/dto
dtc -I dts -O dtb -o /boot/overlays/lcd_hat_keyboard.dtbo lcd_hat_keyboard-overlay.dts -W no-unit_address_vs_reg

cd ..
gcc -o pi-tank pi-tank.c
