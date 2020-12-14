#!/bin/bash -x

# MSP430
if [ ! -e /opt/msp430-gcc/bin/msp430-elf-gcc ]; then
  wget "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/9_2_0_0/export/msp430-gcc-full-linux-x64-installer-9.2.0.0.run"
  chmod +x ./msp430-gcc-full-linux-x64-installer-9.2.0.0.run
  sudo ./msp430-gcc-full-linux-x64-installer-9.2.0.0.run  --mode unattended --prefix /opt/msp430-gcc
  rm -f ./msp430-gcc-full-linux-x64-installer-9.2.0.0.run
  /opt/msp430-gcc/bin/msp430-elf-gcc --version
fi

# Zephyr
if [ ! -d ~/zephyr-sdk-0.11.4 ]; then
  sudo apt install -y --no-install-recommends git cmake ninja-build gperf \
    ccache dfu-util device-tree-compiler wget \
    python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
    make gcc gcc-multilib g++-multilib libsdl2-dev \
    cmake
  pip3 install --user -U west
  wget "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.11.4/zephyr-sdk-0.11.4-setup.run"
  chmod +x zephyr-sdk-0.11.4-setup.run
  ./zephyr-sdk-0.11.4-setup.run -- -d ~/zephyr-sdk-0.11.4
  rm -f ./zephyr-sdk-0.11.4-setup.run

  #export PATH=~/.local/bin:"$PATH"
  #cd sw/zephyrproject/zephyr
  #west update
  #west zephyr-export
  #pip3 install --user -r scripts/requirements.txt
fi

# Buildroot and gateway
sudo apt install -y sed make binutils build-essential \
  gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc \
  wget \
  libncurses5-dev \
  git cvs rsync subversion \
  asciidoc \
  ccache
sudo apt install -y wpan-tools
# install wpanusb driver from sw/linux/wpanusb
