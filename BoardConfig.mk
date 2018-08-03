#
# Copyright (C) 2015 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
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
BOARD_VENDOR := xiaomi

DEVICE_PATH := device/xiaomi/cancro

# ReleaseTools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)/releasetools
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_cancro

TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER         := true
TARGET_NO_RADIOIMAGE         := true

# Platform
TARGET_BOARD_PLATFORM     := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330

# Architecture
TARGET_ARCH         := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI      := armeabi-v7a
TARGET_CPU_ABI2     := armeabi
TARGET_CPU_SMP      := true
TARGET_CPU_VARIANT  := krait

# Extended filesystem support
TARGET_EXFAT_DRIVER := sdfat

# Flags
BOARD_GLOBAL_CFLAGS   += -D__ARM_USE_PLD -D__ARM_CACHE_LINE_SIZE=64

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# Kernel
BOARD_KERNEL_CMDLINE               := console=none vmalloc=340M androidboot.hardware=qcom msm_rtb.filter=0x3b7 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 androidboot.selinux=permissive
LZMA_RAMDISK_TARGETS               := boot,recovery
BOARD_KERNEL_SEPARATED_DT          := true
BOARD_KERNEL_BASE                  := 0x00000000
BOARD_KERNEL_PAGESIZE              := 2048
BOARD_KERNEL_IMAGE_NAME            := zImage
BOARD_MKBOOTIMG_ARGS               := --ramdisk_offset 0x02000000 --tags_offset 0x01E00000
TARGET_KERNEL_SOURCE               := kernel/xiaomi/cancro
TARGET_KERNEL_ARCH                 := arm
TARGET_KERNEL_CONFIG               := virgo_defconfig
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-
BOARD_DTBTOOL_ARGS                 := -2

# Vendor Init
TARGET_INIT_VENDOR_LIB      := libinit_cancro
TARGET_LIBINIT_DEFINES_FILE := $(DEVICE_PATH)/init/init_cancro.cpp

# QCOM hardware
BOARD_USES_QCOM_HARDWARE            := true
TARGET_POWERHAL_VARIANT             := qcom
TARGET_POWERHAL_SET_INTERACTIVE_EXT := $(DEVICE_PATH)/power/power_ext.c

# Audio
BOARD_USES_ALSA_AUDIO                      := true
USE_CUSTOM_AUDIO_POLICY                    := 1
TARGET_USES_QCOM_MM_AUDIO                  := true
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP        := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS         := true
AUDIO_FEATURE_ENABLED_MULTIPLE_TUNNEL      := true
AUDIO_FEATURE_ENABLED_EXTN_POST_PROC       := true
AUDIO_FEATURE_ENABLED_ANC_HEADSET          := false
AUDIO_FEATURE_ENABLED_FLUENCE              := true
AUDIO_FEATURE_ENABLED_HFP                  := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE         := true
AUDIO_FEATURE_ENABLED_USBAUDIO             := true
AUDIO_FEATURE_ENABLED_SPKR_PROTECTION      := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true

# FM Radio
BOARD_HAVE_QCOM_FM := true
TARGET_FM_LEGACY_PATCHLOADER := true

# Bluetooth
BOARD_HAVE_BLUETOOTH                        := true
BOARD_HAVE_BLUETOOTH_QCOM                   := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
QCOM_BT_USE_SMD_TTY                         := true
BLUETOOTH_HCI_USE_MCT                       := true

# Radio
TARGET_RIL_VARIANT                := caf
FEATURE_QCRIL_UIM_SAP_SERVER_MODE := true

# Graphics
USE_OPENGL_RENDERER               := true
TARGET_CONTINUOUS_SPLASH_ENABLED  := true
TARGET_USES_C2D_COMPOSITION       := true
TARGET_USE_COMPAT_GRALLOC_PERFORM := true
TARGET_USES_ION                   := true
OVERRIDE_RS_DRIVER                := libRSDriver_adreno.so
NUM_FRAMEBUFFER_SURFACE_BUFFERS   := 3

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Camera
TARGET_USES_MEDIA_EXTENSIONS           := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
USE_DEVICE_SPECIFIC_CAMERA             := true

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
PRODUCT_VENDOR_MOVE_ENABLED      := true
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"
TARGET_PROVIDES_WCNSS_QMI        := true
TARGET_USES_QCOM_WCNSS_QMI       := true
TARGET_USES_WCNSS_CTRL           := true

# Filesystem
TARGET_USERIMAGES_USE_EXT4          := true
TARGET_USERIMAGES_USE_F2FS          := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE   := ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_BOOTIMAGE_PARTITION_SIZE      := 16384000
BOARD_RECOVERYIMAGE_PARTITION_SIZE  := 16384000
BOARD_SYSTEMIMAGE_PARTITION_SIZE    := 1342177280
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 13291503000
BOARD_CACHEIMAGE_PARTITION_SIZE     := 393216000
BOARD_VENDORIMAGE_PARTITION_SIZE    := 183500800
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_USES_VENDORIMAGE := true
TARGET_COPY_OUT_VENDOR := vendor
BOARD_PERSISTIMAGE_PARTITION_SIZE   := 16384000
BOARD_FLASH_BLOCK_SIZE              := 131072


# Treble
PRODUCT_SHIPPING_API_LEVEL := 18
PRODUCT_FULL_TREBLE_OVERRIDE := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

# Recovery
RECOVERY_FSTAB_VERSION             := 2
TARGET_RECOVERY_DENSITY            := xhdpi
TARGET_RECOVERY_FSTAB              := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT       := "RGBX_8888"
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/leds/lcd-backlight/brightness\"

# Lineage Hardware
BOARD_HARDWARE_CLASS += $(DEVICE_PATH)/lineagehw

# GPS HAL lives here
TARGET_GPS_HAL_PATH         := $(DEVICE_PATH)/gps
TARGET_PROVIDES_GPS_LOC_API := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Properites
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Use HW crypto for ODE
TARGET_HW_DISK_ENCRYPTION := true
TARGET_LEGACY_HW_DISK_ENCRYPTION := true

# Simple time service client
BOARD_USES_QC_TIME_SERVICES := true

# Shim
TARGET_LD_SHIM_LIBS := /vendor/lib/libFaceProc.so|libshim_dso_handle.so

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true

# Remove secdiscard command
TARGET_REMOVE_SECDISCARD_COMMAND := true

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
    endif
  endif
endif
DONT_DEXPREOPT_PREBUILTS := true

# qcom sepolicy
include device/qcom/sepolicy/sepolicy.mk
include device/qcom/sepolicy/legacy-sepolicy.mk

BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# TWRP Support
ifeq ($(WITH_TWRP),true)
-include $(DEVICE_PATH)/twrp/twrp.mk
endif

-include vendor/xiaomi/cancro/BoardConfigVendor.mk
