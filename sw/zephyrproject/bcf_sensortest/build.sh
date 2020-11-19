#!/bin/sh
export SWDIR="$( cd "$(dirname "$0")/../.." >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_BASE=$SWDIR/zephyrproject/zephyr
export ZEPHYR_SDK=~/zephyr-sdk-0.11.3
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
west build -p always -b beagleconnect_freedom -d build/bc_freedom -- -DBOARD_ROOT=$ZEPHYR_BASE/../wpanusb_bc
