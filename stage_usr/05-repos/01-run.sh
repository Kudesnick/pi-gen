#!/bin/bash -e

mkdir "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/git"

git clone https://github.com/kudesnick/joystick.git "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/git/joystick" --branch feature/minimal_project

git clone https://github.com/kudesnick/sthub.git "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/git/sthub" --branch feature/add_high_logic
# see https://www.raspberrypi.org/forums/viewtopic.php?t=284134
on_chroot << EOF
pip3 install libscrc
pip3 install spidev==3.4
EOF
