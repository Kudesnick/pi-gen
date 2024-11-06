#!/bin/bash -e



# Original instruction: https://www.waveshare.com/wiki/1.44inch_LCD_HAT
# Original code: https://www.waveshare.com/w/upload/f/fa/1.44inch-LCD-HAT-Code.7z

git clone https://github.com/kudesnick/1.44inch-LCD-HAT-Code.git

cd 1.44inch-LCD-HAT-Code/dto
dtc -I dts -O dtb -o /boot/overlays/lcd_hat_keyboard.dtbo lcd_hat_keyboard-overlay.dts -W no-unit_address_vs_reg

cd ../st7735r
cp adafruit-st7735r.dtbo /boot/overlays/
KRNL_DIR=$(find /usr/lib/modules/*/kernel/ | head -1 | sed -e s:/kernel/::) # uname not work in chroot: https://unix.stackexchange.com/questions/302869/practical-use-of-uname-in-chroot)
KRNL_VERS=$(grep -oP '[0-9]+\.[0-9]+' <<< "${KRNL_DIR}" | head -1)
SRC="https://github.com/raspberrypi/linux/raw/rpi-${KRNL_VERS}.y/drivers/gpu/drm/tiny/st7735r.c"
make SOURCE="${SRC}" KERNELDIR="${KRNL_DIR}" && make KERNELDIR="${KRNL_DIR}" install && make KERNELDIR="${KRNL_DIR}" clean

cd ../..
rm -fr 1.44inch-LCD-HAT-Code
