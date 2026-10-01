#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
    echo "I:$@" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

rebind_touch() {
    (
        # Delayed driver rebind
        # Allows kernel worker and Synaptics FW check to finish cleanly before rebinding
        sleep 1.5

        rebound=0
        for i in 1 2 3 4 5; do
            for drv in /sys/bus/spi/drivers/synaptics_tcm* /sys/bus/platform/drivers/synaptics_tcm*; do
                [ -d "$drv" ] || continue
                for dev in "$drv"/*; do
                    [ -e "$dev" ] || continue
                    dev_name="$(basename "$dev")"
                    case "$dev_name" in
                        bind|unbind|uevent|module|new_device|delete_device)
                            continue
                            ;;
                        *)
                            if [ -f "$drv/unbind" ] && [ -f "$drv/bind" ]; then
                                LOGMSG "Executing delayed rebind for $dev_name on $(basename "$drv")..."
                                echo "$dev_name" > "$drv/unbind" 2>/dev/null
                                sleep 0.2
                                echo "$dev_name" > "$drv/bind" 2>/dev/null
                                LOGMSG "Delayed rebind of $dev_name completed"
                                rebound=1
                            fi
                            ;;
                    esac
                done
            done
            [ "$rebound" = "1" ] && break
            sleep 0.5
        done

        # Optional raw touch toggle fallback if node is present
        if [ -e /sys/devices/virtual/touch/touch_dev/enable_touch_raw ]; then
            echo 0 > /sys/devices/virtual/touch/touch_dev/enable_touch_raw 2>/dev/null
            sleep 0.1
            echo 1 > /sys/devices/virtual/touch/touch_dev/enable_touch_raw 2>/dev/null
        fi

        chmod 0666 /dev/input/event* 2>/dev/null
    ) &
}

rebind_touch

if [ -f /sbin/prune_historic_logs.sh ]; then
    /sbin/prune_historic_logs.sh 10
fi

LOGMSG "---$SCRIPT_NAME end---"
exit 0
