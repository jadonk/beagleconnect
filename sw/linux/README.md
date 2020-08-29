# mikroBUS Linux kernel driver

## Build

To build, make sure you've already built your previous kernel properly, then...

```
cd <your linux source tree>
git am <beagleconnect source tree>/sw/mikrobus/v2-0001-RFC-mikroBUS-driver-for-add-on-boards.patch
git am <beagleconnect source tree>/sw/mikrobus/0001-mikroBUS-build-fixes.patch
scripts/kconfig/merge_config.sh <beagleconnect source tree>/sw/mikrobus/mikrobus.config
make
sudo make modules_install
sudo make install
```

Then reboot and profit!

Notes:
* You'll need at least a 5.8 kernel

## Install

You'll still need something to instantiate a mikroBUS socket on your system.

TBD

