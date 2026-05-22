# Building QTASUN2

## Current host constraint

This checkout was tested on an `sshfs` backed source tree. That layout is not
suitable for a full Android build:

- Soong cannot place its path-interposer Unix socket in an `out/` directory on
  `sshfs`.
- Moving `OUT_DIR` to `/tmp` fixes the socket issue, but source discovery still
  has to walk the full Android tree over `sshfs`, which is too slow to reach the
  first device-specific build error reliably.

Use a local Linux filesystem for the checkout or at least for a working copy of
the completed `lineage-17.1` tree. The output directory must also live on a
filesystem that supports Unix sockets.

`ntfs3` with the `windows_names` mount option is not sufficient. Even though it
can create Unix sockets on this host, it cannot check out Android source files
whose names are valid on Linux but invalid on Windows, such as
`build/blueprint/pathtools/testdata/escapes/*`.

## Last verified configuration step

With the checkout complete and the QTASUN2 device/vendor repos installed,
`lunch lineage_QTASUN2-userdebug` resolves successfully as Android 10 /
LineageOS 17.1.

The next useful build command after moving to a local filesystem is:

```bash
source ../build-env.sh
set +u
source build/envsetup.sh
lunch lineage_QTASUN2-userdebug
mka bacon
```
