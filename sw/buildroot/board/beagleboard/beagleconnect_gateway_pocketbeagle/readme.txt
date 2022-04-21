PocketBeagle

Description
===========

PocketBeagle mainline with minimal patches.

How to build it
===============

Select the default configuration for the target:
$ make pocketbeagle_defconfig

Optional: modify the configuration:
$ make menuconfig

Build:
$ make

Result of the build
===================
output/images/
├── am335x-pocketbeagle.dtb
├── boot.vfat
├── MLO
├── rootfs.ext2
├── rootfs.tar
├── sdcard.img
├── u-boot.img
├── uEnv.txt
└── zImage

To copy the image file to the sdcard use dd:
$ dd if=output/images/sdcard.img of=/dev/XXX

Tested hardware
===============

2018, Michael Welling <mwelling@ieee.org>
