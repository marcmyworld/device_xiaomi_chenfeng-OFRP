#!/system/bin/sh
# Initial cleanup for OrangeFox on chenfeng to ensure pristine R12 defaults
mkdir -p /persist
if mount -t ext4 /dev/block/bootdevice/by-name/persist /persist 2>/dev/null; then
    if [ ! -f /persist/Fox/.chenfeng_r12_init_v2 ]; then
        rm -f /persist/.foxs
        rm -rf /persist/Fox/.navbar /persist/Fox/.theme /persist/Fox/.settings /persist/Fox/.foxs
        mkdir -p /persist/Fox
        touch /persist/Fox/.chenfeng_r12_init_v2
    fi
    mkdir -p /mnt/vendor/persist/haptics
    if [ -d /persist/haptics ]; then
        cp -rf /persist/haptics/* /mnt/vendor/persist/haptics/ 2>/dev/null
        chmod -R 0777 /mnt/vendor/persist/haptics 2>/dev/null
    fi
    umount /persist 2>/dev/null
fi

# Set AW8624 haptics mode to RAM mode (3)
if [ -f /sys/bus/i2c/drivers/awinic_haptic/2-005a/activate_mode ]; then
    echo 3 > /sys/bus/i2c/drivers/awinic_haptic/2-005a/activate_mode
    chmod 0666 /sys/bus/i2c/drivers/awinic_haptic/2-005a/activate_mode
fi
