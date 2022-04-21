#!/bin/bash -xe
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT:-cross-compile}
export CROSS_COMPILE=/usr/bin/arm-none-eabi-
export ZEPHYR_BASE=${ZEPHYR_BASE:-$SWDIR/zephyrproject/zephyr}
export ZPRJ=$SWDIR/zephyrproject
export ZEPHYR_EXTRA_MODULES=${ZEPHYR_EXTRA_MODULES:-$ZPRJ/greybus-for-zephyr}

# CC1352
cd $ZEPHYR_BASE

## 802.15.4 SubG
#west build -p always -b cc1352r1_launchxl $ZPRJ/sensortest -d $ZEPHYR_BASE/build/sensortest_launchpad -- -DOVERLAY_CONFIG=overlay-subghz.conf

## 802.15.4 2.4GHz
west build -p always -b cc1352r1_launchxl $ZPRJ/sensortest -d $ZEPHYR_BASE/build/sensortest_launchpad_2G

