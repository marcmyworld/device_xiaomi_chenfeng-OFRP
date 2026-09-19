#!/system/bin/sh
# Initial cleanup for OrangeFox on chenfeng to ensure pristine R12 defaults
if [ ! -f /persist/Fox/.chenfeng_r12_init ]; then
    mkdir -p /persist
    mount -t ext4 /dev/block/bootdevice/by-name/persist /persist 2>/dev/null
    rm -rf /persist/Fox/.navbar /persist/Fox/.theme
    mkdir -p /persist/Fox
    touch /persist/Fox/.chenfeng_r12_init
    umount /persist 2>/dev/null
fi
