#!/bin/bash -xe
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export MSP430_TOOLCHAIN_PATH=${MSP430_TOOLCHAIN_PATH:-/opt/msp430-gcc}
export ZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT:-zephyr}
export ZEPHYR_SDK_INSTALL_DIR=${ZEPHYR_SDK_INSTALL_DIR:-~/zephyr-sdk-0.11.4}
export ZEPHYR_BASE=${ZEPHYR_BASE:-$SWDIR/zephyrproject/zephyr}
export ZPRJ=$SWDIR/zephyrproject
export ZEPHYR_EXTRA_MODULES=${ZEPHYR_EXTRA_MODULES:-$ZPRJ/greybus-for-zephyr-mikrobus}

# MSP430
cd $SWDIR/usb_uart_bridge
make

# CC1352
cd $ZEPHYR_BASE

## 802.15.4 SubG
west build -p always -b cc1352r_sensortag $ZPRJ/greybus-for-zephyr-mikrobus/samples/subsys/greybus/net -d build/greybus_mikrobus_sensortag -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_DEV_NAME=\"IEEE802154_1\" -DCONFIG_IEEE802154_CC13XX_CC26XX=n -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ=y

west build -p always -b cc1352r1_launchxl $ZPRJ/greybus-for-zephyr-mikrobus/samples/subsys/greybus/net -d build/greybus_mikrobus_launchpad -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_DEV_NAME=\"IEEE802154_1\" -DCONFIG_IEEE802154_CC13XX_CC26XX=n -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ=y

west build -p always -b cc1352r1_launchxl $ZPRJ/greybus-for-zephyr/samples/subsys/greybus/net -d build/greybus_launchpad -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_DEV_NAME=\"IEEE802154_1\" -DCONFIG_IEEE802154_CC13XX_CC26XX=n -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ=y

west build -p always -b beagleconnect_freedom $ZPRJ/greybus-for-zephyr/samples/subsys/greybus/net -d build/greybus_beagleconnect -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_DEV_NAME=\"IEEE802154_1\" -DCONFIG_IEEE802154_CC13XX_CC26XX=n -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ=y -DBOARD_ROOT=$ZPRJ/wpanusb_bc

west build -p always -b beagleconnect_freedom $ZPRJ/wpanusb_bc -d $ZEPHYR_BASE/build/wpanusb_beagleconnect -- -DOVERLAY_CONFIG=overlay-subghz.conf -DBOARD_ROOT=$ZPRJ/wpanusb_bc

west build -p always -b cc1352r1_launchxl $ZPRJ/sensortest -d $ZEPHYR_BASE/build/sensortest_launchpad -- -DOVERLAY_CONFIG=overlay-subghz.conf

west build -p always -b beagleconnect_freedom $ZPRJ/sensortest -d $ZEPHYR_BASE/build/sensortest_beagleconnect -- -DOVERLAY_CONFIG=overlay-subghz.conf -DBOARD_ROOT=$ZPRJ/wpanusb_bc

## 802.15.4 2.4GHz

west build -p always -b cc1352r_sensortag $ZPRJ/greybus-for-zephyr-mikrobus/samples/subsys/greybus/net -d build/greybus_mikrobus_sensortag_2G -- -DOVERLAY_CONFIG=overlay-802154.conf -DCONFIG_IEEE802154_CC13XX_CC26XX=y

west build -p always -b cc1352r1_launchxl $ZPRJ/greybus-for-zephyr-mikrobus/samples/subsys/greybus/net -d build/greybus_mikrobus_launchpad_2G -- -DOVERLAY_CONFIG=overlay-802154.conf -DCONFIG_IEEE802154_CC13XX_CC26XX=y

west build -p always -b cc1352r1_launchxl $ZPRJ/greybus-for-zephyr/samples/subsys/greybus/net -d build/greybus_launchpad_2G -- -DCONFIG_IEEE802154_CC13XX_CC26XX=y

west build -p always -b beagleconnect_freedom $ZPRJ/greybus-for-zephyr/samples/subsys/greybus/net -d build/greybus_beagleconnect_2G -- -DCONFIG_IEEE802154_CC13XX_CC26XX=y -DBOARD_ROOT=$ZPRJ/wpanusb_bc

west build -p always -b beagleconnect_freedom $ZPRJ/wpanusb_bc -d $ZEPHYR_BASE/build/wpanusb_beagleconnect_2G -DBOARD_ROOT=$ZPRJ/wpanusb_bc

west build -p always -b cc1352r1_launchxl $ZPRJ/sensortest -d $ZEPHYR_BASE/build/sensortest_launchpad_2G

west build -p always -b beagleconnect_freedom $ZPRJ/sensortest -d $ZEPHYR_BASE/build/sensortest_beagleconnect_2G -DBOARD_ROOT=$ZPRJ/wpanusb_bc

