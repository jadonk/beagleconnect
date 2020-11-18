#!/bin/bash -xe
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.11.3
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export MSP430_TOOLCHAIN_PATH=/opt/msp430-gcc
cd $SWDIR/usb_uart_bridge
make
cd $SWDIR/usb_wpan_temp
make
cd $SWDIR/zephyrproject/zephyr
west build -p always -b cc1352r1_launchxl samples/subsys/greybus/net -d build/greybus_launchpad -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_DEV_NAME="\"IEEE802154_1\"" -DCONFIG_IEEE802154_CC13XX_CC26XX=n -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ=y
west build -p always -b beagle_connect -d $PWD/build/wpanusb_beagleconnect $PWD/../wpanusb_bc -- -DOVERLAY_CONFIG=overlay-subghz.conf
west build -p always -b cc1352r1_launchxl samples/subsys/greybus/net -d build/greybus_launchpad_2G -- -DCONFIG_IEEE802154_CC13XX_CC26XX=y
west build -p always -b beagle_connect -d $PWD/build/wpanusb_beagleconnect_2G $PWD/../wpanusb_bc
