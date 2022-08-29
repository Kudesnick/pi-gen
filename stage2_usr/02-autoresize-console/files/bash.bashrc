
# resize console according to window size
#see https://unix.stackexchange.com/questions/16578/resizable-serial-console-window/283206#283206
OLD_SETT=$(stty -g)
stty raw -echo min 0 time 5
printf '\0337\033[r\033[999;999H\033[6n\0338' > /dev/tty
IFS='[;R' read -r _ REAL_ROWS REAL_COLS _ < /dev/tty
stty ${OLD_SETT}
stty cols "${REAL_COLS}" rows "${REAL_ROWS}"
echo "tty size ${REAL_COLS}x${REAL_ROWS}"
