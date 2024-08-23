#!/bin/bash -e

# Original instruction: https://www.waveshare.com/wiki/1.44inch_LCD_HAT
# Original code: https://www.waveshare.com/w/upload/f/fa/1.44inch-LCD-HAT-Code.7z

git clone https://github.com/kudesnick/1.44inch-LCD-HAT-Code.git

cd 1.44inch-LCD-HAT-Code/dto
dtc -I dts -O dtb -o /boot/firmware/overlays/lcd_hat_keyboard.dtbo lcd_hat_keyboard-overlay.dts -W no-unit_address_vs_reg

cd ../st7735r
cp adafruit-st7735r.dtbo /boot/firmware/overlays/
KERNEL_VER=$(ls -1 /usr/lib/modules/ | head -1)
KERNELDIR=/usr/lib/modules/${KERNEL_VER}
make KERNELDIR=${KERNELDIR} && make KERNELDIR=${KERNELDIR} install && make KERNELDIR=${KERNELDIR} clean

cd ../..
rm -fr 1.44inch-LCD-HAT-Code
