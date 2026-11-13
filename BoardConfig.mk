#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2026 The TWRP Open Source Project
# Copyright (C) 2026 The OrangeFox Recovery Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generatort
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/infinix/X695C

# For building with minimal manifest & Build Hacks
ALLOW_MISSING_DEPENDENCIES := true

# Build hacks needed by recovery-only trees
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    system \
    system_ext \
    product \
    vendor \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Assert
TARGET_OTA_ASSERT_DEVICE := X695C,Infinix-X695C

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6785
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := mt6785

# Kernel - prebuilt 4.14.186-dirty
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtb

# Offsets verified
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Partitions 
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_USES_METADATA_PARTITION := true

BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := infinix_dynamic_partitions
BOARD_INFINIX_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    product \
    vendor
BOARD_INFINIX_DYNAMIC_PARTITIONS_SIZE := 9122611200

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
RECOVERY_SDCARD_ON_DATA := true

# AVB — same key/algorithm/rollback index as crDroid's boot.img footer (testkey_rsa2048, index 1)
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 1

# Security Patch Level
PLATFORM_SECURITY_PATCH := 2026-08-01
VENDOR_SECURITY_PATCH := 2022-11-05
PLATFORM_VERSION := 16
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# Decryption — FBEv2 + metadata encryption via MediaTek Microtrust/Beanpod keymaster 4.0
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
TW_PREPARE_DATA_MEDIA_EARLY := true

# Every library the Beanpod keymaster service links against (readelf NEEDED) that is not a vendor blob
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.1 \
    libkeymaster4 \
    libkeymaster41 \
    libkeymaster4_1support \
    libkeymaster_messages

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4_1support.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_messages.so

# TWRP UI / hardware
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_FRAMERATE := 60
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1024
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

TW_NO_FASTBOOT_BOOT := true
ifeq ($(X695C_RAMBOOT_TEST),1)
    BOARD_KERNEL_CMDLINE += twrpfastboot=1
endif

# Tools
TW_USE_TOOLBOX := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_PYTHON := true
TARGET_USES_MKE2FS := true

# Logging (keeps logcat/dmesg available for bug reports)
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Recovery-flavour specific settings
ifneq ($(filter pb_X695C,$(TARGET_PRODUCT)),)
    # PitchBlack (vendor/pb pb-12.1). PB's code tests MAX_BRIGHTNESS but reads BRIGHTNESS_MAX, so set both.
    PB_TORCH_PATH := "/system/flashlight"
    PB_TORCH_MAX_BRIGHTNESS := 1
    PB_TORCH_BRIGHTNESS_MAX := 1
    PB_DISABLE_DEFAULT_DM_VERITY := true
    PB_DISABLE_DEFAULT_TREBLE_COMP := true
endif

# UI: StatusBar
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CPU_POS := "245"
TW_CUSTOM_CLOCK_POS := "70"
TW_CUSTOM_BATTERY_POS := "790"

# Init
#TARGET_INIT_VENDOR_LIB := libinit_Infinix-X695C
#TARGET_RECOVERY_DEVICE_MODULES := libinit_Infinix-X695C

# Maintainer
TW_DEVICE_VERSION := Infinix-X695C | ExcaliburXD