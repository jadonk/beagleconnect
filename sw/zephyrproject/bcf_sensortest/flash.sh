#!/bin/bash -ve
export SWDIR="$( cd "$(dirname "$0")/../.." >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_BASE=$SWDIR/zephyrproject/zephyr
export ZEPHYR_SDK=~/zephyr-sdk-0.11.3
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export PORT=${1:-/dev/ttyACM0}

echo Make sure to use the correct ttyACMx...
lsusb | grep 2047:0aa5
west flash -d build/bc_freedom $PORT


