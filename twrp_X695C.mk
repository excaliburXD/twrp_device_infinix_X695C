#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2026 The TWRP Open Source Project
# Copyright (C) 2026 The OrangeFox Recovery Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from X695C device
$(call inherit-product, device/infinix/X695C/device.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := X695C
PRODUCT_NAME := twrp_X695C
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X695C
PRODUCT_MANUFACTURER := INFINIX MOBILITY LIMITED

PRODUCT_GMS_CLIENTID_BASE := android-transsion