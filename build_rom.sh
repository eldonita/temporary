# sync rom
repo init -u https://github.com/SuperiorExtended/manifest -b UDC --git-lfs
repo sync --force-sync
git clone https://github.com/LineageOS/android_device_xiaomi_lancelot -b lineage-21 device/xiaomi/lancelot
git clone https://github.com/LineageOS/android_device_xiaomi_mt6768-common -b lineage-21 device/xiaomi/mt6768-common
git clone https://github.com/LineageOS/android_kernel_xiaomi_mt6768 -b lineage-21 kernel/xiaomi/mt6768
git clone https://github.com/acex88/vendor_aeonax_ANXCamera -b v202 vendor/aeonax/ANXCamera
git clone https://github.com/LineageOS/android_hardware_xiaomi -b lineage-21 hardware/xiaomi
git clone https://github.com/LineageOS/android_hardware_mediatek -b lineage-20 hardware/mediatek

# build rom
source build/envsetup.sh
lunch lacelot user
export TZ=Asia/Dhaka #put before last build command
mka lancelot user

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
