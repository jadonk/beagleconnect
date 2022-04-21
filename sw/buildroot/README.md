# buildroot

A complete distro image for the gateway.

NOTE: /tmp is just a place holder for where you checked out the beagleconnect repo

## Dependencies

```
sudo apt install -y sed make binutils build-essential \
  gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc \
  wget \
  libncurses5-dev \
  git cvs rsync subversion \
  asciidoc \
  ccache
```

## Building

```
cd /tmp
wget "https://buildroot.org/downloads/buildroot-2020.11.tar.gz"
tar xzf buildroot-2020.11.tar.gz
cd /tmp/beagleconnect/sw/buildroot
make -C /tmp/buildroot-2020.11 O=$PWD/qemu BR2_EXTERNAL=$PWD beagleconnect_gateway_qemu_x86_64_defconfig
cd qemu && make
cd ..
make -C /tmp/buildroot-2020.11 O=$PWD/pb BR2_EXTERNAL=$PWD beagleconnect_gateway_pocketbeagle_defconfig
cd pb && make
cd ..
```

## Running
```
./run
```

