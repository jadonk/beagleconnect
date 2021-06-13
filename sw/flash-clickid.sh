#!/bin/bash -xe

export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export MSP430_TOOLCHAIN_PATH=${MSP430_TOOLCHAIN_PATH:-/opt/msp430-gcc}
export ZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT:-zephyr}
export ZEPHYR_SDK_INSTALL_DIR=${ZEPHYR_SDK_INSTALL_DIR:-~/zephyr-sdk-0.11.4}
export ZEPHYR_BASE=${ZEPHYR_BASE:-$SWDIR/zephyrproject/zephyr}
export ZPRJ=$SWDIR/zephyrproject
export ZEPHYR_EXTRA_MODULES=${ZEPHYR_EXTRA_MODULES:-"$ZPRJ/mikrobus-clickid-flasher"}

west build -p always -t flash -b beagleconnect_freedom $ZPRJ/mikrobus-clickid-flasher/samples/subsys/mikrobus/flasher -d build/greybus_mikrobus_beagleconnect_flasher -- -DBOARD_ROOT=$ZPRJ/wpanusb_bc -DCONFIG_MIKROBUS_FLASHER_CLICK_NAME='"'$1'"'
