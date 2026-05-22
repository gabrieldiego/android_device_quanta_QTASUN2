DEVICE_PATH := device/quanta/QTASUN2

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_SHIPPING_API_LEVEL := 23
PRODUCT_USE_DYNAMIC_PARTITIONS := false

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/fstab.qcom:root/fstab.qcom \
    $(DEVICE_PATH)/rootdir/init.qcom.rc:root/init.qcom.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.board.platform=msm8952 \
    ro.opengles.version=196609 \
    ro.telephony.default_network=11 \
    telephony.lteOnCdmaDevice=1 \
    persist.fuse_sdcard=true \
    persist.cne.feature=1 \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.data.mode=concurrent \
    persist.timed.enable=true \
    bluetooth.hfp.client=1

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
    rild.libargs=-d /dev/smd0 \
    ril.subscription.types=NV,RUIM

PRODUCT_PROPERTY_OVERRIDES += \
    qcom.hw.aac.encoder=true \
    mm.enable.smoothstreaming=true \
    av.debug.disable.pers.cache=true \
    mmp.enable.3g2=true \
    media.aac_51_output_enabled=true \
    mm.enable.qcom_parser=1048575 \
    audio.offload.buffer.size.kb=64 \
    audio.offload.min.duration.secs=30 \
    audio.offload.video=true \
    audio.offload.pcm.16bit.enable=true \
    audio.offload.pcm.24bit.enable=true \
    audio.offload.track.enable=true \
    audio.deep_buffer.media=true \
    audio.playback.mch.downsample=true \
    audio.offload.gapless.enabled=true \
    audio.offload.multiple.enabled=false \
    audio.safx.pbe.enabled=true \
    audio.pp.asphere.enabled=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.qualcomm.cabl=2 \
    persist.hwc.mdpcomp.enable=true \
    persist.hwc.downscale_threshold=1.15 \
    persist.hwc.enable_vds=1 \
    persist.debug.wfd.enable=1

PRODUCT_PACKAGES += \
    libion

$(call inherit-product-if-exists, vendor/quanta/QTASUN2/QTASUN2-vendor.mk)
