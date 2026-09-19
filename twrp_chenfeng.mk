#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/chenfeng

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

## Device identifier
PRODUCT_DEVICE := chenfeng
PRODUCT_NAME := twrp_chenfeng
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Xiaomi 14 Civi
PRODUCT_MANUFACTURER := xiaomi

# Theme
TW_STATUS_ICONS_ALIGN := center
