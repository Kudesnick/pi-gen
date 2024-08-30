#!/bin/bash -e

if [ $GIT_LIST ]; then
	for GIT_URL in "${GIT_LIST[@]}" ; do
		git clone ${GIT_URL} ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/$(basename ${GIT_URL})
	done
fi
