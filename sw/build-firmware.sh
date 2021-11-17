#!/bin/bash -xe
source ./env.sh

# MSP430
cd $SWDIR/usb_uart_bridge
make clean
make
cd ..
mkdir -p build/msp430
cp $SWDIR/usb_uart_bridge/usb_uart_bridge* build/msp430/

# CC1352
cd $ZEPHYR_BASE
west update

# WPANUSB Gateway SubG
west build -p always -b beagleconnect_freedom $ZPRJ/wpanusb_bc -d $ZEPHYR_BASE/build/wpanusb_beagleconnect -- -DOVERLAY_CONFIG=overlay-subghz.conf

# Sensortest application SubG
west build -p always -b beagleconnect_freedom samples/boards/beagle_bcf/sensortest -d $ZEPHYR_BASE/build/sensortest_beagleconnect -- -DOVERLAY_CONFIG=overlay-subghz.conf

# mikroBUS over Greybus node SubG
#west build -p always -b beagleconnect_freedom $ZPRJ/greybus-for-zephyr-mikrobus/samples/subsys/greybus/net -d build/greybus_mikrobus_beagleconnect -- -DOVERLAY_CONFIG=overlay-802154-subg.conf -DCONFIG_NET_CONFIG_IEEE802154_RADIO_TX_POWER=14 -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ_DIV_SETUP_PA=1 -DCONFIG_IEEE802154_CC13XX_CC26XX_SUB_GHZ_CS_THRESHOLD=-20

# mikroBUS ID flasher
#west build -p always -t flash -b beagleconnect_freedom $ZPRJ/mikrobus-clickid-flasher/samples/subsys/mikrobus/flasher -d build/greybus_mikrobus_beagleconnect_flasher -- -DBOARD_ROOT=$ZPRJ/wpanusb_bc -DCONFIG_MIKROBUS_FLASHER_CLICK_NAME='"'$MIKROBUS_ID'"'

# make a FW release directory with the FW binaries and relevant debug info
mkdir -p $SWDIR/build/cc1352
mkdir -p $SWDIR/build/msp430
cp $SWDIR/cc2538-bsl.py  $SWDIR/build/

copy_fwbin () {
		if [ -f $ZEPHYR_BASE/build/$1/zephyr/zephyr.bin ] ; then
			cp $ZEPHYR_BASE/build/$1/zephyr/zephyr.bin $SWDIR/build/cc1352/$1.bin
			cp $ZEPHYR_BASE/build/$1/zephyr/zephyr.dts $SWDIR/build/cc1352/$1.dts
			cp $ZEPHYR_BASE/build/$1/zephyr/.config $SWDIR/build/cc1352/$1.config
		fi
}

copy_fwbin wpanusb_beagleconnect
copy_fwbin sensortest_beagleconnect
#copy_fwbin greybus_mikrobus_beagleconnect
