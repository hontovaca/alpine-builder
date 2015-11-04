## Alpine Linux base image

This image provides a subset of Alpine Linux suitable for running in a container. Specifically it provides the dependencies of `alpine-base` minus installation scripts and OpenRC.

[I've previously claimed that this image removes the *init system*. This is not quite correct; `init` remains: it's baked into Alpine's `busybox` and works as designed. However, for a few reasons I shan't discuss here, ordinary init systems do not behave optimally under Docker.]

This image is built by vaca/builder with default options (the default options are set *to build this image*; this is the builder's primary consumer). It is not intended for general use; the primary consumer is vaca/s6, which extends this image with an s6-based init system which behaves sanely under Docker.

That said, there is no particular reason this image can't be used as the basis for even lighter than typical Alpine containers. However, in that case, you may wish to simply use vaca/builder to pull in *exactly* the dependencies you need, trimming away even apk-tools &c..
