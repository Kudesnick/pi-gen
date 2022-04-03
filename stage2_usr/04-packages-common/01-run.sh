#!/bin/bash -e

if [ $GIT_NAME ] && [ $GIT_MAIL ]; then
    on_chroot << EOF
    git config --global user.name "${GIT_NAME}"
    git config --global user.email "${GIT_MAIL}"
    git config --global color.ui auto
EOF
fi
