# Alpine Linux rootfs Builder

This image builds an Alpine Linux rootfs, and by default outputs it as a tarball to stdout.

The `mkrootfs` script may also be used by itself to build a rootfs, which may be useful for e.g. a chroot. Note that `mkrootfs` depends on APK, so typically it will only be usable on an Alpine system. It should be possible to download and extract `apk-tools-static` and `alpine-keys` from the Alpine repos manually, but this is not supported.

## Options

The builder script takes the following options:

* `-d dest`: Sets the build destination. Defaults to `mnt`. This is unlikely to
  be useful when using the builder image. A volume mounted to the destination
  directory will collect the resulting rootfs, but this use is unsupported.
* `-m mirror`: Sets the base mirror URL. Defaults to the Glider Labs CDN proxy,
  `http://alpine.gliderlabs.com/alpine`.
* `-r release`: Sets the release tag. Defaults to `edge`. A useful alternative
  might be `latest-stable` or `v3.3`.
* `-p packages`: Comma-separated packages list to be passed into `apk add`.
  Default is `alpine-baselayout,alpine-keys,apk-tools,musl-utils`, which is an
  unholy abomination providing a functional container with no init. A sane
  alternative might be `alpine-base`.
* `-t timezone`: Sets the timezone. If not provided, no timezone will be set,
  which is probably fine.
* `-S`: Suppress output of the rootfs tarball to stdout. This is most likely to
  be useful when running `mkrootfs` as a standalone script.
