# buildroot

A complete distro image for the gateway.

NOTE: /tmp is just a place holder for where you checked out the beagleconnect repo

## Building

```
cd /tmp
wget "https://buildroot.org/downloads/buildroot-2020.08.tar.gz"
tar xzf buildroot-2020.08.tar.gz
cd /tmp/beagleconnect/sw/buildroot
make -C /tmp/buildroot-2020.08 O=$PWD BR2_EXTERNAL=$PWD beagleconnect_gateway_qemu_x86_64_defconfig
make
```

## Running
```
./run
```

