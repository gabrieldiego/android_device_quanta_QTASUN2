# QTASUN2 Android 10 Bring-Up Audit

## Downloaded tree findings

- The Lineage checkout is still incomplete, but the available tree already has
  Android 10 core projects plus legacy Qualcomm policy under
  `device/qcom/sepolicy-legacy` and `device/qcom/sepolicy-legacy-um`.
- Available Qualcomm HAL source does not include an obvious `msm8952` display or
  camera target yet. Expect to rely heavily on stock blobs at first, then map
  compatible HAL source directories only when the tree is complete.
- `vendor/lineage/config/common_full_phone.mk` is present and includes the
  telephony stack. We use it while keeping `PRODUCT_CHARACTERISTICS := tablet`.

## Stock firmware facts extracted

- Build: `Verizon/VZW_QTASUN2/QTASUN2:6.0.1/MMB29M/SUN2_11A28:user/release-keys`.
- Platform: `msm8952`, 64-bit userspace with 32-bit secondary ABI.
- Legacy vendor layout: `/vendor` is supplied by `/system/vendor`.
- Required side mounts from stock init:
  - `/persist` from `persist`
  - `/firmware` from `modem`
  - `/dsp` from `dsp`
  - `/NVM` from `NVM`
  - `/cache` from `cache`
- Stock fstab force-encrypts `/data` with `forceencrypt=footer`.
- Critical stock services seen in ramdisk:
  - `qseecomd`
  - `thermal-engine`
  - `wcnss_service`
  - `time_daemon`
  - `perfd`
  - camera/IMS/radio services that should be added only after first boot logs.

## Initial blockers

- Android 10 with a stock 3.10 kernel is possible only as a legacy bring-up and
  will likely need binder, ashmem, sdcardfs/fuse, netfilter, and SELinux fixes.
- `/system` is only about 3.5 GiB, so a minimal Lineage build without bundled
  GApps is the realistic target.
- Proprietary blobs are from Android 6.0.1. Some may require shims or symbol
  compatibility libraries on Android 10.
- The complete generated blob list is about 266 MiB. The active first-boot list
  is about 233 MiB after removing obvious nonessential stock payloads; restore
  entries from `proprietary-files-full.txt` if a missing service needs them.
- SELinux should start permissive during first boot investigation, then move
  toward enforcing once service denials are understood.
