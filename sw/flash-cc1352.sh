#!/bin/bash -ve
source ./env.sh
export PROJECT=${1:-build/wpanusb_beagleconnect}
export PORT=${2:-/dev/ttyACM0}

echo Make sure to use the correct ttyACMx...
lsusb | grep 2047:0aa5
#west flash -d $ZEPHYR_BASE/$PROJECT $PORT
./cc2538-bsl.py $ZEPHYR_BASE/$PROJECT $PORT

