#!/bin/bash -e

git clone https://github.com/Kudesnick/hid-sony.git
cd hid-sony
KERNEL_VER=$(ls -1 /usr/lib/modules/ | head -1)
KERNELDIR=/usr/lib/modules/${KERNEL_VER}
make KERNELDIR=${KERNELDIR} && make KERNELDIR=${KERNELDIR} install && make KERNELDIR=${KERNELDIR} clean
cd ..
rm -fr hid-sony
