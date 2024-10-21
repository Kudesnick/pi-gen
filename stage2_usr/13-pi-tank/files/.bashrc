if [[ ${TERM} == "linux" ]]; then

        # resize console according to window size
        #see https://unix.stackexchange.com/questions/16578/resizable-serial-console-window/283206#283206
        OLD_SETT=$(stty -g)
        stty raw -echo min 0 time 5
        printf '\0337\033[r\033[999;999H\033[6n\0338' > /dev/tty
        IFS='[;R' read -r _ REAL_ROWS REAL_COLS _ < /dev/tty
        stty ${OLD_SETT}
        stty cols "${REAL_COLS}" rows "${REAL_ROWS}"
        tput clear
        echo "krnl $(uname -r)"
        echo "${HOSTNAME} ${USER}"
        echo "tty ${REAL_COLS}x${REAL_ROWS}"

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
