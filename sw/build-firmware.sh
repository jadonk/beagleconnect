#!/bin/bash -xe
export ZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT:-zephyr}
export ZEPHYR_SDK_INSTALL_DIR=${ZEPHYR_SDK_INSTALL_DIR:-~/zephyr-sdk-0.11.4}
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export ZEPHYR_BASE=${ZEPHYR_BASE:-$SWDIR/zephyrproject/zephyr}
export MSP430_TOOLCHAIN_PATH=${MSP430_TOOLCHAIN_PATH:-/opt/msp430-gcc}

# MSP430
cd $SWDIR/usb_uart_bridge
make

# CC1352
cd $ZEPHYR_BASE

## 802.15.4 SubG
west build -p always -b cc1352r1_launchxl samples/subsys/greybus/net -d build/greybus_launchpad -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_DEV_NAME=\"IEEE802154_1\" -DCONFIG_IEEE802154_CC13XX_CC26XX=n -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ=y

west build -p always -b beagleconnect_freedom -d $ZEPHYR_BASE/build/wpanusb_beagleconnect $ZEPHYR_BASE/../wpanusb_bc -- -DOVERLAY_CONFIG=overlay-subghz.conf

west build -p always -b beagleconnect_freedom -d $ZEPHYR_BASE/build/sensortest_beagleconnect $ZEPHYR_BASE/../bcf_sensortest -- -DOVERLAY_CONFIG=overlay-subghz.conf -DBOARD_ROOT=$ZEPHYR_BASE/../wpanusb_bc

## 802.15.4 2.4GHz

west build -p always -b cc1352r1_launchxl samples/subsys/greybus/net -d build/greybus_launchpad_2G -- -DCONFIG_IEEE802154_CC13XX_CC26XX=y

west build -p always -b beagleconnect_freedom samples/subsys/greybus/net -d build/greybus_beagleconnect_2G -- -DCONFIG_IEEE802154_CC13XX_CC26XX=y -DBOARD_ROOT=$ZEPHYR_BASE/../wpanusb_bc

west build -p always -b beagleconnect_freedom -d $ZEPHYR_BASE/build/wpanusb_beagleconnect_2G $ZEPHYR_BASE/../wpanusb_bc

west build -p always -b beagleconnect_freedom -d $ZEPHYR_BASE/build/sensortest_beagleconnect_2G $ZEPHYR_BASE/../bcf_sensortest -- -DBOARD_ROOT=$ZEPHYR_BASE/../wpanusb_bc

