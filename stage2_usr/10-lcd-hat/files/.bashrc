
if [[ ${TERM} == "linux" ]]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\w\$\[\033[00m\]'

	_IP=$(hostname -I)
	_TRY=10
	while [ ! $_IP ] && [ $_TRY -gt 0 ]; do
		echo -ne "net wait ${_TRY}.. \\r"
		sleep 2
		_IP=$(hostname -I)
		_TRY=$(( $_TRY - 1 ))
	done
		echo -ne "                \\r"
		if [ ! $_IP ]; then
			echo "Wireless error"
		else
			iwgetid -r
			hostname -I
		fi
fi
