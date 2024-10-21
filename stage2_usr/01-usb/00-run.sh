#!/bin/bash -e

source ../config-func.sh

if [ $USR_USB_CONSOLE ] && [ $USR_USB_MASS_STORAGE ]; then
	USB_DEV="g_acm_ms"
elif [ $USR_USB_CONSOLE ]; then
	USB_DEV="g_serial"
elif [ $USR_USB_MASS_STORAGE ]; then
	USB_DEV="g_mass_storage"
fi

if [ $USB_DEV ]; then
	sed -i --follow-symlinks "$ a modules-load=dwc2,${USB_DEV}" "${ROOTFS_DIR}/boot/cmdline.txt"
	sed -i --follow-symlinks ':a;N;$!ba;s/\n/ /g' "${ROOTFS_DIR}/boot/cmdline.txt"
	param_off "otg_mode=1"
	sed -i --follow-symlinks "$ a # Enable USB UART console or mass storage emulator or ethernet" "${CONF_PATH}"
	sed -i --follow-symlinks "$ a dtoverlay=dwc2" "${CONF_PATH}"
fi

if [ $USR_USB_CONSOLE ]; then
	# instead of "systemctl enable getty@ttyGS0.service" on ch_root mode
	SIM_LINK="${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/getty@ttyGS0.service"
	if [ ! -L ${SIM_LINK} ] ; then
		ln -s /lib/systemd/system/getty@.service ${SIM_LINK}
	fi
	# patch https://github.com/raspberrypi/linux/issues/1929
	# poweroff timeout fixed
	sed -i --follow-symlinks "s/TTYVTDisallocate=yes/TTYVTDisallocate=no/" "${ROOTFS_DIR}/usr/lib/systemd/system/getty@.service"
fi

if [ $USR_USB_MASS_STORAGE ]; then
	STORAGE_IMG='piusb.bin'

	dd bs=1M if=/dev/zero of="${ROOTFS_DIR}/${STORAGE_IMG}" count=$USR_USB_MASS_STORAGE
	mkdosfs "${ROOTFS_DIR}/${STORAGE_IMG}"

	# not working, see https://stackoverflow.com/questions/63540052/raspberry-pi-zero-as-read-write-mass-storage/65470397#65470397
	#echo "options ${USB_DEV} file=/${STORAGE_IMG} removable=1 ro=0 stall=0" | tee -a "${ROOTFS_DIR}/etc/modprobe.d/${USB_DEV}.conf"
	echo "blacklist ${USB_DEV}" | tee -a "${ROOTFS_DIR}/etc/modprobe.d/blacklist-${USB_DEV}.conf"

	sed -i "$ a /${STORAGE_IMG} /media/piusb auto defaults,noatime,sync,user,nofail,rw,umask=0000 0 0" "${ROOTFS_DIR}/etc/fstab"
	sed -i "\|^exit 0|i /usr/sbin/modprobe ${USB_DEV} file=/${STORAGE_IMG} stall=0 ro=0 removable=1\n" "${ROOTFS_DIR}/etc/rc.local"
fi
