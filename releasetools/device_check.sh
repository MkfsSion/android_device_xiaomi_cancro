#!/sbin/sh
#
# Copyright (C) 2016 CyanogenMod Project
#
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

RAW_ID=`cat /sys/devices/system/soc/soc0/raw_id`

if [ $RAW_ID == 1974 ] || [ $RAW_ID == 1972 ]; then
    # Replace manifests
    rm -rf /vendor/manifest.xml
    mv /vendor/manifest_mi4.xml /vendor/manifest.xml
    # Remove NFC
    rm -rf /system/app/NfcNci
    rm -rf /system/priv-app/Tag
    rm -rf /vendor/lib/*nfc*
    rm -rf /vendor/etc/*nfc*
    rm -rf /vendor/etc/permissions/*nfc*
    rm -rf /vendor/vendor/firmware/*bcm*
    rm -rf /vendor/lib/hw/android.hardware.nfc@1.0-impl-bcm.so
    # Use Mi4 audio configs
    rm -f /vendor/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
    mv /vendor/etc/acdbdata/MTP/MTP_Speaker_cal_4.acdb /vendor/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
    rm -f /vendor/etc/mixer_paths.xml
    mv /vendor/etc/mixer_paths_4.xml /vendor/etc/mixer_paths.xml
    # Mi4 libdirac config
    rm -f /vendor/etc/diracmobile.config
    mv /vendor/etc/diracmobile_4.config /vendor/etc/diracmobile.config
else
    # Remove Mi4 consumerir support
    rm -rf /vendor/etc/permissions/android.hardware.consumerir.xml
    rm -rf /vendor/lib/hw/consumerir.msm8974.so
    rm -rf /vendor/lib/hw/android.hardware.ir@*.so
    rm -rf /vendor/bin/hw/android.hardware.ir@*.so
    rm -rf /vendor/manifest_mi4.xml
    # Remove Mi4 audio configs
    rm -rf /vendor/etc/acdbdata/MTP/MTP_Speaker_cal_4.acdb
    rm -f /vendor/etc/mixer_paths_4.xml
    # Remove Mi4 libdirac config
    rm -f /vendor/etc/diracmobile_4.config
fi

if [ $RAW_ID == 1978 ] || [ $RAW_ID == 1974 ]; then
    # Supported device (Mi3w - 1978 or Mi4 - 1974)
    return 0
else
    # Unsupported device
    return 1
fi
