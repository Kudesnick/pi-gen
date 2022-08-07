#!/bin/bash -e

systemctl enable bluetooth.service
usermod -G bluetooth -a ${FIRST_USER_NAME}
