# mikroBUS Linux kernel driver

## Build

To build, make sure you've already built your previous kernel properly, then...

```
cd <your linux source tree>
git am <beagleconnect source tree>/sw/linux/*.patch
scripts/kconfig/merge_config.sh <beagleconnect source tree>/sw/linux/mikrobus.config
make
sudo make modules_install
sudo make install
```

Then reboot and profit!

Notes:
* You'll need at least a 5.8 kernel

## Instantiation

mikroBUS ports on a system can be of two different types:
* physical mikroBUS ports on host : For host systems like a [PocketBeagle](https://github.com/beagleboard/pocketbeagle/wiki/System-Reference-Manual#72-mikrobus-socket-connections) or a BeagleBone Black attached to [mikroBUS cape](mikroe.com/beaglebone-mikrobus-cape), the mikroBUS ports are physically present on the board and they can be instantiated over a suitable device tree overlay[1] to describe the mikroBUS port, with physical mikroBUS ports the add-on board discovery is performed directly by reading the manifest from the ID Board[2] physically over 1-wire.
* mikroBUS ports instantiated over Greybus : mikroBUS ports are instantiated over Greybus and in this case the add-on board discovery is performed along with the Greybus interface discovery mechanism over the Greybus manifest, in this case the remote MCU device will either store the add-on board manifests during compile time or fetch it during runtime from ID Board(TODO) and pass it to the host along with the Greybus interface manifest.



1. [PocketBeagle mikroBUS port 0 device tree overlay](https://github.com/beagleboard/bb.org-overlays/blob/master/src/arm/PB-MIKROBUS-0.dts)
2. [mikroBUS ID adapter hardware draft documentation](https://download.mikroe.com/documents/mikrobu_socket/ClickIdentificationFunctionlity.pdf)
