#!/bin/bash -e

# see
# https://www.dzombak.com/blog/2024/03/Running-a-Raspberry-Pi-with-a-read-only-root-filesystem.html
# https://ktg0210.hashnode.dev/editing-etcsystemdsystemservicedoverrideconf-canceled-temporary-file-is-empty

# nocheck SD-Card, not use swapfile, readonly mode
sed -i --follow-symlinks "$ a fsck.mode=skip noswap ro" "${ROOTFS_DIR}/boot/cmdline.txt"
sed -i --follow-symlinks ':a;N;$!ba;s/\n/ /g' "${ROOTFS_DIR}/boot/cmdline.txt"

# remove unused packages
on_chroot <<- EOF
	apt remove wolfram-engine triggerhappy cron anacron logrotate dphys-swapfile xserver-common lightdm fake-hwclock -y
	apt autoremove --purge -y
EOF

# timesyncd to ro-mode

mkdir -p "${ROOTFS_DIR}/var/lib/systemd/timesync/"
ln -fs "/tmp/systemd-timesync-clock" "${ROOTFS_DIR}/var/lib/systemd/timesync/clock"

# Network manager to ro-mode

sed -i "/[main]/a rc-manager=file" "${ROOTFS_DIR}/etc/NetworkManager/NetworkManager.conf"

# move files to tmpfs
mv "${ROOTFS_DIR}/etc/resolv.conf" "${ROOTFS_DIR}/var/run/resolv.conf"
ln -fs "/var/run/resolv.conf" "${ROOTFS_DIR}/etc/resolv.conf"
rm -rf "${ROOTFS_DIR}/var/lib/dhcp"
ln -fs "/var/run" "${ROOTFS_DIR}/var/lib/dhcp"
rm -rf "${ROOTFS_DIR}/var/lib/NetworkManager"
ln -fs "/var/run" "${ROOTFS_DIR}/var/lib/NetworkManager"

# random-seed

ln -fs "/tmp/systemd-random-seed" "${ROOTFS_DIR}/var/lib/systemd/random-seed"

sed -i '\,[Service],a ExecStartPre=/bin/echo "" >/tmp/systemd-random-seed' "${ROOTFS_DIR}/lib/systemd/system/systemd-random-seed.service"

# disable tasks

on_chroot <<- EOF
	systemctl disable systemd-rfkill.service
	systemctl mask systemd-rfkill.socket
	systemctl mask man-db.timer
	systemctl mask apt-daily.timer
	systemctl mask apt-daily-upgrade.timer
EOF

# disable journald

sed -i "s/#Storage=auto/Storage=none/" "${ROOTFS_DIR}/etc/systemd/journald.conf"

# /etc/fstab

sed -i "s/vfat    defaults,flush/vfat    defaults,ro/" "${ROOTFS_DIR}/etc/fstab"
sed -i "s/ext4    defaults,noatime/ext4    defaults,noatime,ro/" "${ROOTFS_DIR}/etc/fstab"

cat "files/fstab" >> "${ROOTFS_DIR}/etc/fstab"

cat "files/.bashrc" >> "${ROOTFS_DIR}/etc/bash.bashrc"

install -m 555 "files/bash.bash_logout" "${ROOTFS_DIR}/etc/bash.bash_logout"
