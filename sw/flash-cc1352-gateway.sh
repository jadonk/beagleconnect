#!/bin/bash -ve
export PORT=${1:-/dev/ttyACM0}
export PROJECT=${2:-build/wpanusb_beagleconnect}
#export PROJECT=${2:-build/wpanusb_beagleconnect_2G}
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT:-zephyr}
export ZEPHYR_SDK_INSTALL_DIR=${ZEPHYR_SDK_INSTALL_DIR:-~/zephyr-sdk-0.11.4}
export ZEPHYR_BASE=${ZEPHYR_BASE:-$SWDIR/zephyrproject/zephyr}

echo Make sure to use the correct ttyACMx...
lsusb | grep 2047:0aa5
#west flash -d $ZEPHYR_BASE/$PROJECT $PORT
./cc2538-bsl.py $ZEPHYR_BASE/$PROJECT $PORT


