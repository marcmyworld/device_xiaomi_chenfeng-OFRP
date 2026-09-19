#!/bin/bash

# Copyright (C) 2025-2026 OrangeFox Recovery Project
# SPDX-License-Identifier: GPL-3.0-only

FDEVICE="chenfeng"

fox_get_target_device() {
    local chkdev=""

    if [ -n "$ZSH_VERSION" ];
      then
        local current_source="${(%):-%x}"
        chkdev=$(echo "$current_source" | grep -w "$FDEVICE")
    elif [ -n "$BASH_VERSION" ];
      then chkdev=$(echo "$BASH_SOURCE" | grep -w "$FDEVICE")
    fi

    if [ -n "$chkdev" ];
      then FOX_BUILD_DEVICE="$FDEVICE"
    else
        if [ -n "$BASH_VERSION" ];
          then chkdev=$(set | grep BASH_ARGV | grep -w "$FDEVICE")
        elif [ -n "$ZSH_VERSION" ];
          then chkdev=$(echo "$*" | grep -w "$FDEVICE")
        fi
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ];
  then fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ];
  then
    export TARGET_DEVICE_ALT="chenfeng,chenfeng_in"
    export LC_ALL="C"
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export FOX_VANILLA_BUILD=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_LZ4_BINARY=1
    export FOX_USE_ZSTD_BINARY=1
    export FOX_USE_DATE_BINARY=1
    export FOX_USE_GREP_BINARY=1
    export FOX_USE_BUSYBOX_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_USE_FSCK_EROFS_BINARY=1
    export FOX_USE_PATCHELF_BINARY=1
    export FOX_USE_UPDATED_MAGISKBOOT=1
    export FOX_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1
    export FOX_DELETE_AROMAFM=1
    export FOX_ENABLE_KERNELSU_SUPPORT=1
    export FOX_ENABLE_KERNELSU_NEXT_SUPPORT=1
    export FOX_ENABLE_SUKISU_SUPPORT=1
    export FOX_SETTINGS_ROOT_DIRECTORY=/persist
    export FOX_ALLOW_EARLY_SETTINGS_LOAD=1

    # CCACHE
    export USE_CCACHE=1
    export CCACHE_EXEC="/usr/bin/ccache"
    export CCACHE_MAXSIZE="50G"
    export CCACHE_DIR="/home/sharkey/.ccache"

    # Warn if CCACHE_DIR is an invalid directory
    if [ $USE_CCACHE = 1 ] && [ ! -d ${CCACHE_DIR} ];
     then
       echo "CCACHE Directory/Partition is not mounted at \"${CCACHE_DIR}\""
       echo "Please edit the CCACHE_DIR build variable or mount the directory."
    fi

    export LC_ALL="C"
    export BUILD_USERNAME=marcmyworld
    export BUILD_HOSTNAME=android-kitchen

  else
    if [ -z "$FOX_BUILD_DEVICE" ] && [ -z "$BASH_SOURCE" ] && [ -z "$ZSH_VERSION" ]; 
      then echo "I: This script requires bash or zsh. Not processing $FDEVICE"
    fi
fi
