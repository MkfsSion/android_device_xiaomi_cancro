Copyright 2015 - The CyanogenMod Project

Copyright 2016-2018 - The LineageOS Project

Xiaomi Mi3 and Mi4
==============

The Xiaomi Mi3 (codenamed _"Cancro"_) is a high-end smartphone from Xiaomi.

The Xiaomi Mi4 (codanamed _"Cancro"_) is a high-end smartphone from Xiaomi.

Mi3 was announced in September 2013.

Mi4 was announced in July 2014.

Basic   | Mi3                               | Mi4
-------:|:---------------------------------:|------------------------------
CPU     | 2.3GHz Quad-Core MSM8974AB        | 2.5GHz Quad-Core MSM8974AC
GPU     | Adreno 330                        | Adreno 330
Memory  | 2GB RAM                           | 3GB RAM
Shipped Android Version | 4.3 up to 4.4.4   | 4.4.4
Storage | 16/64GB                           | 16/64GB
Battery | 3050 mAh                          | 3080 mAh
Display | 5.0" 1920 x 1080 px               | 5.0" 1920 x 1080px
Camera  | 13MPx, LED Flash                  | 13MPx, LED Flash

![Xiaomi Mi3](http://cdn.gsmarena.com/vv/reviewsimg/xiaomi-mi-3/gal/gsmarena_004.jpg "Xiaomi Mi3 in black")
![Xiaomi Mi4](http://cdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-mi-4-lte.jpg "Xiaomi Mi4 in white")

To build:
```sh
. build/envsetup,sh
lunch omni_cancro-eng
mka recoveryimage -jx
```

Kernel sources are available at: https://github.com/MkfsSion/android_kernel_xiaomi_cancro (virgo_defconfig)
