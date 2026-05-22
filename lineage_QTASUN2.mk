$(call inherit-product, device/quanta/QTASUN2/device.mk)

$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_QTASUN2
PRODUCT_DEVICE := QTASUN2
PRODUCT_BRAND := Verizon
PRODUCT_MODEL := QTASUN2
PRODUCT_MANUFACTURER := Quanta

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="msm8952_64-user 6.0.1 MMB29M SUN2_11A28 release-keys" \
    PRODUCT_NAME=VZW_QTASUN2

BUILD_FINGERPRINT := Verizon/VZW_QTASUN2/QTASUN2:6.0.1/MMB29M/SUN2_11A28:user/release-keys
