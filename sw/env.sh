#!/bin/bash -xe
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export MSP430_TOOLCHAIN_PATH=${MSP430_TOOLCHAIN_PATH:-/opt/msp430-gcc}
export ZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT:-zephyr}
export ZEPHYR_SDK_INSTALL_DIR=${ZEPHYR_SDK_INSTALL_DIR:-~/zephyr-sdk}
export ZEPHYR_BASE=${ZEPHYR_BASE:-$SWDIR/zephyrproject/zephyr}
export ZPRJ=$SWDIR/zephyrproject
#export ZEPHYR_EXTRA_MODULES=${ZEPHYR_EXTRA_MODULES:-"$ZPRJ/greybus-for-zephyr-mikrobus:$ZPRJ/sensortest/sgp30"}
export ZEPHYR_EXTRA_MODULES=${ZEPHYR_EXTRA_MODULES:-"$ZPRJ/greybus-for-zephyr-mikrobus"}
export MIKROBUS_ID=TBD
