#!/system/bin/sh
# Initial cleanup for OrangeFox on chenfeng to ensure pristine R12 defaults
mkdir -p /persist
if mount -t ext4 /dev/block/bootdevice/by-name/persist /persist 2>/dev/null; then
    if [ ! -f /persist/Fox/.chenfeng_r12_init ]; then
        rm -rf /persist/Fox/.navbar /persist/Fox/.theme
        mkdir -p /persist/Fox
        touch /persist/Fox/.chenfeng_r12_init
    fi
    mkdir -p /mnt/vendor/persist/haptics
    if [ -d /persist/haptics ]; then
        cp -rf /persist/haptics/* /mnt/vendor/persist/haptics/ 2>/dev/null
        chmod -R 0777 /mnt/vendor/persist/haptics 2>/dev/null
    fi
    umount /persist 2>/dev/null
fi
