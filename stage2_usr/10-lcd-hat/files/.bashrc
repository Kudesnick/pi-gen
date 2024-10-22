
if [[ ${TERM} == "linux" ]]; then
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
