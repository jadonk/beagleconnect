#!/bin/bash -ve
export SWDIR="$( cd "$(dirname "$0")/../.." >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_BASE=$SWDIR/zephyrproject/zephyr
export ZEPHYR_SDK=~/zephyr-sdk-0.11.3
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export MSP430_TOOLCHAIN_PATH=/opt/msp430-gcc
cd $SWDIR/usb_uart_bridge
lsusb | grep 2047:0200
make program

echo Now you can use ./flash.sh


