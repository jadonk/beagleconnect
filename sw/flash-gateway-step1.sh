#!/bin/bash -ve
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export MSP430_TOOLCHAIN_PATH=/opt/msp430-gcc
cd $SWDIR/usb_uart_bridge
lsusb | grep 2047:0200
make program

