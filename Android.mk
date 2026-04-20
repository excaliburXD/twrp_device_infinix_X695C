#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2026 The TWRP Open Source Project
# Copyright (C) 2026 The OrangeFox Recovery Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),Infinix-X695C,Infinix-X695D,Infinix-X695)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
