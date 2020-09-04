#!/bin/bash
if (( $EUID != 0 )); then
  sudo $0
  exit
fi
CHIP=`gpiodetect | grep "greybus_gpio" | awk '{print $1}'`
VAL=0; for ((;;)); do VAL=$((VAL^1)); echo $VAL | gpioset ${CHIP} 6=${VAL}; done
