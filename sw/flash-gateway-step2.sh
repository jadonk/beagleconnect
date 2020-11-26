#!/bin/bash -ve
export SWDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SWDIR/zephyrproject/zephyr
west flash -d $PWD/build/wpanusb_beagleconnect /dev/ttyACM0

