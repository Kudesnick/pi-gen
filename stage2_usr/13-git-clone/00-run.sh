#!/bin/bash -e

for GIT_URL in ${GIT_LIST}; do
	on_chroot <<- EOF
		SUDO_USER="${FIRST_USER_NAME}" git clone ${GIT_URL} /home/${FIRST_USER_NAME}/$(basename ${GIT_URL})
	EOF
done
