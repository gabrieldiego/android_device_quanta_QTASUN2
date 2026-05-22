# QTASUN2 Android 10 bring-up notes

Target: Verizon/Quanta QTASUN2, Qualcomm MSM8952, Android 6.0.1 stock base
`SUN2_11A28`.

Known stock facts:

- Legacy non-Treble layout: `/vendor` is a symlink to `/system/vendor`.
- `boot` and `recovery` partitions are 64 MiB each.
- `/system` is about 3.5 GiB, which is tight for Android 10 plus proprietary blobs.
- Stock firmware uses footer-based full disk encryption on `/data`.
- Stock radio path is QMI RIL: `/vendor/lib64/libril-qc-qmi-1.so`.
- GPU firmware includes Adreno A5xx files, and OpenGL ES is advertised as 3.1.

Current bring-up stance:

- Stage the device tree outside the active Lineage checkout until `repo sync`
  completes, then copy or bind it into `device/quanta/QTASUN2`.
- Use the stock kernel initially. Replacing or forward-porting the 3.10 kernel is
  a separate task.
- Start with stock proprietary blobs from `rom-bringup/stock-dump/system`.
  `proprietary-files-full.txt` keeps the complete stock list; the active
  `proprietary-files.txt` is trimmed for first boot and excludes obvious
  nonessential payloads such as OCR/face model datasets, log-kit data, factory
  diagnostic MMI libraries, old vendor APKs, and PlayReady blobs.
- Regenerate the vendor tree with `./extract-files.sh /path/to/stock-dump/system`
  after copying this device tree into the Lineage checkout. From the staging
  tree, set `LINEAGE_ROOT=rom-bringup/lineage-17.1` if auto-detection fails.
- Prefer permissive-first boot debugging only for early bring-up; tighten SELinux
  once init, graphics, adb, storage, and radio service behavior are observable.

Restore path:

- OEM rollback images and guarded scripts are in `rom-bringup/oem-restore`.
- Verify `rom-bringup/oem-restore/SHA256SUMS` before any destructive flash.
