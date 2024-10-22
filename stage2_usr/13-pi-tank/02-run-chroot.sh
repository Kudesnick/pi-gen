#!/bin/bash -e

git clone https://github.com/kudesnick/pi-tank.git

cd pi-tank
make install
cd ..
rm pi-tank
