#!/bin/bash -e

git clone https://github.com/Kudesnick/hid-sony.git
cd hid-sony
KRNL_DIR=$(find /usr/lib/modules/*/kernel/ | head -1 | sed -e s:/kernel/::) # uname not work in chroot: https://unix.stackexchange.com/questions/302869/practical-use-of-uname-in-chroot)
make KERNELDIR=${KRNL_DIR} && make KERNELDIR=${KRNL_DIR} install && make KERNELDIR=${KRNL_DIR} clean
cd ..
rm -fr hid-sony
