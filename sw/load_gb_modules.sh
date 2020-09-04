#!/bin/bash
if (( $EUID != 0 )); then
  sudo $0
  exit
fi
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd /lib/modules/$(uname -r)/kernel/drivers/greybus
$SCRIPTPATH/greybus/gbprobe.sh
cd /lib/modules/$(uname -r)/kernel/drivers/staging/greybus
$SCRIPTPATH/greybus/gbprobe.sh
