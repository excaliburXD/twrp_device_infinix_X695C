#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2026 The TWRP Open Source Project
# Copyright (C) 2026 The OrangeFox Recovery Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from X695C device
$(call inherit-product, device/infinix/X695C/device.mk)

# Inherit some common PBRP stuff.
$(call inherit-product, vendor/pb/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := X695C
PRODUCT_NAME := pb_X695C
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X695C
PRODUCT_MANUFACTURER := INFINIX MOBILITY LIMITED

PRODUCT_GMS_CLIENTID_BASE := android-transsion

# PBRP's ramdisk has a real /etc directory (not a symlink to /system/etc like OrangeFox), so the boot
# control HAL's ReadDefaultFstab() cannot find /etc/recovery.fstab and init of IBootControl fails;
# recovery then retries getService forever while mounting /data (observed hang on the splash screen).
PRODUCT_COPY_FILES += \
    device/infinix/X695C/recovery/root/system/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/etc/recovery.fstab