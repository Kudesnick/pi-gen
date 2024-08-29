#!/bin/bash -e

git clone https://github.com/Kudesnick/hid-sony.git
cd hid-sony
source ../config-func.sh
make KERNELDIR=${KRNL_DIR} && make KERNELDIR=${KRNL_DIR} install && make KERNELDIR=${KRNL_DIR} clean
cd ..
rm -fr hid-sony
