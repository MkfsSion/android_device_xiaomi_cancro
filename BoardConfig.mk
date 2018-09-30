#
# Copyright (C) 2015-2016 The CyanogenMod Project
# Copyright (C) 2017-2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/xiaomi/cancro

# Architecture
TARGET_ARCH := arm
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_SUFFIX := _32
TARGET_BOARD_PLATFROM_GPU := qcom-adreno330
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := generic
TARGET_USES_64_BIT_BINDER := true
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_BOOTLOADER_BOARD_NAME := MSM8974

# Kernel
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/kernel
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

# Filesystem
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16384000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16384000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1342177280
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13291503000
BOARD_FLASH_BLOCK_SIZE := 131072

# TWRP
LZMA_RAMDISK_TARGETS                    := boot,recovery
TW_THEME                                := portrait_hdpi
BOARD_NATIVE_DUALBOOT                   := true
BOARD_NATIVE_DUALBOOT_SINGLEDATA        := true
TW_EXCLUDE_SUPERSU                      := true
TW_INCLUDE_NTFS_3G                      := true
TARGET_USERIMAGES_USE_EXT4              := true
TARGET_USERIMAGES_USE_F2FS              := true
BOARD_HAS_NO_REAL_SDCARD                := true
RECOVERY_GRAPHICS_USE_LINELENGTH        := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID  := ture
TARGET_RECOVERY_PIXEL_FORMAT            := "RGBX_8888"
TARGET_RECOVERY_FSTAB                   := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_LCD_BACKLIGHT_PATH      := "/sys/class/leds/lcd-backlight/brightness"
TW_INCLUDE_CRYPTO                       := true
TARGET_HW_DISK_ENCRYPTION               := true
TARGET_RECOVERY_QCOM_RTC_FIX            := true
BOARD_SUPPRESS_SECURE_ERASE             := true
BOARD_SUPPRESS_EMMC_WIPE                := true
RECOVERY_SDCARD_ON_DATA                 := true
TW_EXTRA_LANGUAGES                      := true

# Debug
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
