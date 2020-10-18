#!/bin/sh -xv
#ATMOD=`lsmod | grep atusb`
#if [ "$ATMOD" == "" ]; then
#  modprobe atusb
#fi
#sleep 1

IFLP=`ifconfig | grep lowpan`
ip link set wpan0 down
iwpan phy phy0 set channel 0 26
iwpan dev wpan0 set pan_id 0xabcd
if [ "$IFLP" == "" ]; then
  ip link add link wpan0 name lowpan0 type lowpan
  ip link set lowpan0 up
fi
ip link set wpan0 up
ip -6 addr add 2001:db8::2/64 dev lowpan0
sleep 1

killall -9 gbridge
sleep 1

NLMOD=`lsmod | grep gb_netlink`
if [ "$NLMOD" == "" ]; then
#  modprobe greybus
  modprobe gb-netlink
#  modprobe gb-bootrom
#  modprobe gb-gbphy
#  modprobe gb-loopback
#  modprobe gb-spilib
#  modprobe gb-firmware
#  modprobe gb-log
#  modprobe gb-raw
fi
sleep 1

gbridge > /var/log/gbridge

