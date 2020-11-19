#!/bin/bash -ve
export SWDIR="$( cd "$(dirname "$0")/../.." >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_BASE=$SWDIR/zephyrproject/zephyr
export ZEPHYR_SDK=~/zephyr-sdk-0.11.3
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export MSP430_TOOLCHAIN_PATH=/opt/msp430-gcc
cd $SWDIR/usb_uart_bridge
lsusb | grep 2047:0200
make program

echo <<EOF
Now run...
lsusb | grep 2047:0aa5
west flash -d build/bc_freedom /dev/ttyACM0 -- -DBOARD_ROOT=$SWDIR/zephyrproject/wpanusb_bc
EOF


